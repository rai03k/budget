import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:math' as math; // 乱数生成のために使用

part 'savings_state.freezed.dart';

// 落下する絵文字一つ一つの状態を保持するクラス
@freezed
class FallingEmoji with _$FallingEmoji {
  const factory FallingEmoji({
    required String emoji,
    required double startX, // 現在のX座標
    required double startY, // 現在のY座標
    required double speed, // 落下速度
    required double rotationSpeed, // 回転速度
  }) = _FallingEmoji;

  // 絵文字の初期位置などをランダムに生成するファクトリコンストラクタ
  // 画面サイズを知る必要があるため、ViewModelに渡すinitParamsで使用
  factory FallingEmoji.initial(String emoji, double screenWidth) {
    final random = math.Random();
    return FallingEmoji(
      emoji: emoji,
      startX: random.nextDouble() * screenWidth, // 画面幅に応じて初期X座標を設定
      startY: -50.0 - (random.nextDouble() * 300), // 画面上部よりさらに上に設定
      speed: 2.0 + random.nextDouble() * 2.0, // 落下速度をランダムに設定
      rotationSpeed: (random.nextDouble() - 0.5) * 0.1, // 回転速度をランダムに設定
    );
  }
}

// SavingsScreenの初期化パラメータをViewModelに渡すためのクラス
@freezed
class SavingsInitParams with _$SavingsInitParams {
  const factory SavingsInitParams({
    required List<String> emojis, // 表示する絵文字リスト
    required double totalSavings, // アニメーションする合計金額
    required double screenWidth, // 画面幅 (絵文字の初期位置計算に使用)
    required double screenHeight, // 画面高さ (絵文字の落下判定に使用)
  }) = _SavingsInitParams;
}

// SavingsScreen画面全体の状態を保持するクラス
@freezed
class SavingsState with _$SavingsState {
  const factory SavingsState({
    // 画面上に表示されている落下中の絵文字リスト（位置はViewModelが更新）
    required List<FallingEmoji> fallingEmojis,
    // 金額カウントアップアニメーションの最終目標値
    required double animatedSavingsValueTarget,
  }) = _SavingsState;

  // 初期状態を生成するためのファクトリコンストラクタ
  factory SavingsState.initial(SavingsInitParams params) {
    // InitParamsから受け取った絵文字リストを元に、FallingEmojiのリストを生成
    return SavingsState(
      fallingEmojis: params.emojis
          .map((emoji) => FallingEmoji.initial(emoji, params.screenWidth))
          .toList(),
      // 金額アニメーションの目標値は初期パラメータから取得
      animatedSavingsValueTarget: params.totalSavings,
    );
  }
}
