import 'package:budget/common/enum/app_colors.dart';
import 'package:flutter/material.dart';

import 'category_colors.dart';

class AppTheme {
  /// ライトモードのテーマデータ
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme(
      brightness: Brightness.light, // 全体の明るさ（ライトまたはダーク）
      primary: Color(0xFFFFFFFF), // 主要な要素の色
      onPrimary: Color(0xFF000000), // primary の上にあるテキストやアイコンの色
      secondary: Color(0xFFE9EAEB), // アクセントとなる色
      onSecondary: Color(0xFF535862), // secondary の上にあるテキストやアイコンの色
      error: Color(0xFFBC1B06), // エラー表示の色
      onError: Color(0xFFB00020), // error の上にあるテキストやアイコンの色
      surface: Color(0xFFF5F5F5), // カードやダイアログなどの表面の色
      onSurface: Color(0xFF181D27), // surface の上にあるテキストやアイコンの色
    ),
    // ここでカスタム拡張を追加します
    extensions: const <ThemeExtension<dynamic>>[
      AppColorScheme.light,
    ],
  );

  /// ダークモードのテーマデータ
  static ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.dark, // 全体の明るさ（ライトまたはダーク）
      primary: Color(0xFF1C1C1C), // 主要な要素の色
      onPrimary: Color(0xFFFFFFFF), // primary の上にあるテキストやアイコンの色
      secondary: Color(0xFF2C2C2C), // アクセントとなる色
      onSecondary: Color(0xFF94979C), // secondary の上にあるテキストやアイコンの色
      error: Color(0xFFBC1B06), // エラー表示の色
      onError: Color(0xFFB00020), // error の上にあるテキストやアイコンの色
      surface: Color(0xFF000000), // カードやダイアログなどの表面の色
      onSurface: Color(0xFFF0F0F1), // surface の上にあるテキストやアイコンの色
    ),
    // ダークモード用のカスタム拡張を追加
    extensions: const <ThemeExtension<dynamic>>[
      AppColorScheme.dark,
    ],
  );
}
