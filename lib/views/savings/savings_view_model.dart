import 'dart:async';
import 'dart:math' as math;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'savings_state.dart'; // StateおよびFallingEmoji, SavingsInitParamsをインポート

// AutoDisposeFamilyNotifier を拡張
class SavingsViewModel extends AutoDisposeFamilyNotifier<SavingsState, SavingsInitParams> {
  Timer? _timer;
  // buildメソッドの引数 `arg` をタイマーコールバック内で使用するため、
  // 一時的に保持するフィールド。Notifierが再生成されると更新される。
  SavingsInitParams? _currentParams;

  @override
  SavingsState build(SavingsInitParams arg) {
    // 現在のパラメータを保持
    _currentParams = arg;

    // 初期状態を生成
    final initialState = SavingsState.initial(arg);

    // Notifierが破棄されるときにタイマーをキャンセルする処理を登録
    ref.onDispose(() {
      _timer?.cancel();
      print("SavingsViewModel disposed for params: $arg"); // デバッグ用ログ
    });

    // アニメーションを開始
    // 注意: buildメソッドはNotifierが再生成されるたびに呼ばれるため、
    // アニメーションもそのたびに再開されます。
    // もし初回のみ実行したい場合は、追加の制御が必要です。
    _startFallingEmojiAnimation();
    _startSavingsAnimation();

    // 初期状態を返す
    return initialState;
  }

  // 落下絵文字のアニメーションロジック (プライベートメソッド化)
  void _startFallingEmojiAnimation() {
    // 既存のタイマーがあればキャンセル（build再実行時のため）
    _timer?.cancel();
    final random = math.Random();

    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      // パラメータが利用可能かチェック
      if (_currentParams == null) return;

      // 現在の状態を取得して更新
      final currentState = state; // 現在の状態を取得
      final currentEmojis = List<FallingEmoji>.from(currentState.fallingEmojis);

      final updatedEmojis = currentEmojis.map((emoji) {
        double newY = emoji.startY + emoji.speed;

        final screenHeight = _currentParams!.screenHeight;
        final screenWidth = _currentParams!.screenWidth;

        if (newY > screenHeight + 50) {
          // 画面外に出たら再生成
          newY = -50.0 - (random.nextDouble() * 300);
          final newX = random.nextDouble() * screenWidth;
          final newRotationSpeed = (random.nextDouble() - 0.5) * 0.05;
          return emoji.copyWith(startY: newY, startX: newX, rotationSpeed: newRotationSpeed);
        } else {
          // Y座標のみ更新
          return emoji.copyWith(startY: newY);
        }
      }).toList();

      // stateを更新 (Notifierのstateプロパティを直接更新)
      state = currentState.copyWith(fallingEmojis: updatedEmojis);
    });
  }

  // 金額アニメーションのロジック (プライベートメソッド化)
  void _startSavingsAnimation() {
    // 500ms後にアニメーションターゲット値を設定
    Future.delayed(const Duration(milliseconds: 500), () {
      // Futureのコールバック実行時にNotifierがまだ有効か（破棄されていないか）
      // 確認するためにパラメータのnullチェックを行う。
      // より厳密には、stateへのアクセス時にtry-catchを使うなども考えられる。
      if (_currentParams == null) return;

      // stateを更新
      // `mounted` のようなチェックは不要
      try {
        // Notifierが破棄された後にstateにアクセスしようとするとエラーになる可能性があるため
        // try-catchで囲むとより安全ですが、通常はonDisposeで適切に処理されていれば不要な場合が多い
        state = state.copyWith(animatedSavingsValueTarget: _currentParams!.totalSavings);
      } catch (e) {
        print("Error updating state in delayed future: $e"); // エラーログ
      }
    });
  }
}

// Providerを定義 (AutoDisposeNotifierProviderFamilyを使用)
// クラスのコンストラクタ参照 (SavingsViewModel.new) を渡す
final savingsViewModelProvider = AutoDisposeNotifierProviderFamily<SavingsViewModel, SavingsState, SavingsInitParams>(
  SavingsViewModel.new,
);