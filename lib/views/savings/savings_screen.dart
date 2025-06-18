import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;
import 'dart:async'; // Future.delayed のために必要
import 'package:go_router/go_router.dart';

import 'savings_view_model.dart'; // ViewModelをインポート
import 'savings_state.dart'; // Stateクラス、FallingEmoji、SavingsInitParamsをインポート

// StatefulWidgetからConsumerStatefulWidgetに変更
// これにより、StateクラスでTickerProviderStateMixinを使用できる
class SavingsScreen extends ConsumerStatefulWidget {
  final List<String> emojis;
  final double totalSavings;

  const SavingsScreen({
    super.key,
    required this.emojis,
    required this.totalSavings,
  });

  @override
  // ConsumerState<SavingsScreen> を返すように変更
  ConsumerState<SavingsScreen> createState() => _SavingsScreenState();
}

// Stateクラスは ConsumerState を継承し、TickerProviderStateMixin を使用
class _SavingsScreenState extends ConsumerState<SavingsScreen>
    with TickerProviderStateMixin {
  // 落下絵文字リスト、アニメーション値のターゲット、初期化フラグはViewModelに移動したため不要
  // List<FallingEmoji> fallingEmojis = []; // 不要
  // double animatedValue = 0; // ViewModelのanimatedSavingsValueTargetを使用
  // bool _initialized = false; // 不要

  // スケールアニメーション関連はView（State）で管理し続ける
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  // 落下絵文字の位置更新タイマーはViewModelに移動したため不要
  // Timer? _timer; // 不要

  @override
  void initState() {
    super.initState();

    // スケールアニメーションコントローラーの初期化とリスナー設定はViewで行う
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this, // TickerProviderStateMixin を使用
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: Curves.easeInOut,
      ),
    )..addStatusListener((status) {
        // アニメーションの繰り返しロジック
        if (status == AnimationStatus.completed) {
          _scaleController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _scaleController.forward();
        }
      });

    // 金額アニメーションの目標値がViewModelに設定された後、
    // 少し遅延させてスケールアニメーションを開始する
    // ViewModel側で目標値が設定されるのが500ms後、TweenAnimationBuilderが2秒かけてアニメーションするので、
    // その後に開始するのが自然。ここではシンプルに遅延でトリガー。
    Future.delayed(const Duration(seconds: 2, milliseconds: 500), () {
      // ViewModelの遅延(500ms) + Tween duration(2s) = 2.5s 後に開始が適切かもしれないが、元のコードに合わせて2秒後に開始
      if (mounted) {
        // Widgetがまだ画面に表示されているか確認
        _scaleController.forward(); // スケールアニメーションを開始
      }
    });

    // 落下絵文字の初期化とタイマーの開始はViewModelで行うため、initStateからは削除
  }

  @override
  void dispose() {
    // AnimationControllerの破棄はViewで行う
    _scaleController.dispose();
    // ViewModelのタイマーはViewModelのdisposeでキャンセルされる
    // _timer?.cancel(); // 不要
    super.dispose();
  }

  // didChangeDependenciesでの初期化ロジックはViewModelに移動したため不要
  /*
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 初期化ロジックはViewModelへ移動
  }
  */

  @override
  // buildメソッドの引数にBuildContextとWidgetRefを追加
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra as Map?;
    final List<String> emojis =
        (extra?['emojis'] as List<dynamic>?)?.cast<String>() ?? [];
    final double totalSavings =
        (extra?['totalSavings'] as num?)?.toDouble() ?? 0.0;

    // ViewModelをwatchし、状態を取得します。
    // ViewModelのState（fallingEmojis, animatedSavingsValueTarget）の更新に伴い、
    // このbuildメソッドが自動的に再実行され、画面が更新されます。
    // ViewModelには初期パラメータ (emojis, totalSavings) と画面サイズを渡します。
    final state = ref.watch(savingsViewModelProvider(
      SavingsInitParams(
        emojis: emojis,
        totalSavings: totalSavings,
        // 画面サイズをMediaQueryから取得し、ViewModelに渡す
        screenWidth: MediaQuery.of(context).size.width,
        screenHeight: MediaQuery.of(context).size.height,
      ),
    ));

    // ViewModelのNotifier（メソッド）は、現状Viewから直接呼び出すものは無いが、必要なら読み取る
    // final viewModel = ref.read(savingsViewModelProvider(params).notifier);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 背景の落下絵文字を表示
          // ViewModelの状態 (state.fallingEmojis) を使用してリストを生成
          ...state.fallingEmojis.map((emoji) {
            return Positioned(
              left: emoji.startX,
              top: emoji.startY, // ViewModelによってタイマーで更新されるstartYを使用
              child: Transform.rotate(
                // 回転角度の計算はViewに残すが、絵文字のstartYとrotationSpeedを使用
                angle: emoji.startY * emoji.rotationSpeed,
                child: Text(
                  emoji.emoji, // 絵文字の文字列を使用
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
              ),
            );
          }).toList(), // Mapの結果をListに変換
          // メインコンテンツは元のコードのまま
          Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '振り返り完了！',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 40),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[900]?.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          '今週の不要な支出は・・・',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // TweenAnimationBuilder は View に残し、
                        // アニメーションの最終目標値に ViewModel の状態を使用
                        TweenAnimationBuilder<double>(
                          // アニメーション終了値をViewModelの状態から取得
                          tween: Tween<double>(
                              begin: 0, end: state.animatedSavingsValueTarget),
                          duration: const Duration(seconds: 2),
                          curve: Curves.easeOut,
                          builder: (context, value, child) {
                            // AnimatedBuilder と Transform.scale はスケールアニメーションのために View に残す
                            return AnimatedBuilder(
                              // View の AnimationController を使用
                              animation: _scaleAnimation,
                              builder: (context, child) {
                                return Transform.scale(
                                  // View の AnimationController の値を使用
                                  scale: _scaleAnimation.value,
                                  child: Text(
                                    '¥${value.toInt()}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'あと1回ラーメン行けたかも？',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '来週はもっとスマートに',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '💡',
                        style: TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 元のコードにあった FallingEmoji クラスは State ファイルに移動されました。
// 元のコードにあった _SavingsScreenState の状態変数 (_initialized, fallingEmojis, animatedValue, _timer) は ViewModel に移動されました。
