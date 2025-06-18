import 'package:flutter/material.dart';

// カテゴリーのキーを定義
enum CategoryType {
  food,
  transportation,
  housing,
  entertainment,
  utilities,
  others,
}

/// アプリ全体のテーマとは別に、カテゴリーごとの色を定義するクラス
/// ThemeExtension を使用することで、Theme.of(context) から簡単にアクセスできるようになります。
class CategoryColors extends ThemeExtension<CategoryColors> {
  final Map<CategoryType, Color> colors;

  const CategoryColors({
    required this.colors,
  });

  /// ライトモード用のデフォルトのカテゴリー色
  static const CategoryColors light = CategoryColors(
    colors: {
      CategoryType.food: Colors.red,
      CategoryType.transportation: Colors.blue,
      CategoryType.housing: Colors.green,
      CategoryType.entertainment: Colors.purple,
      CategoryType.utilities: Colors.orange,
      CategoryType.others: Colors.grey,
    },
  );

  /// ダークモード用のデフォルトのカテゴリー色（必要であれば）
  /// 例えば、ライトモードで明るすぎる色は、ダークモードでは見にくくなる可能性があるため、
  /// 少し暗めの色や、補色を使うなど調整することができます。
  static const CategoryColors dark = CategoryColors(
    colors: {
      CategoryType.food: Color(0xFFE57373), // 赤を少し暗めに
      CategoryType.transportation: Color(0xFF64B5F6), // 青を少し暗めに
      CategoryType.housing: Color(0xFF81C784), // 緑を少し暗めに
      CategoryType.entertainment: Color(0xFFBA68C8), // 紫を少し暗めに
      CategoryType.utilities: Color(0xFFFFB74D), // オレンジを少し暗めに
      CategoryType.others: Color(0xFFBDBDBD), // 灰色を少し明るめに
    },
  );

  /// コピーメソッド (ThemeExtension の要件)
  @override
  CategoryColors copyWith({Map<CategoryType, Color>? colors}) {
    return CategoryColors(
      colors: colors ?? this.colors,
    );
  }

  /// 補間メソッド (ThemeExtension の要件)
  @override
  CategoryColors lerp(ThemeExtension<CategoryColors>? other, double t) {
    if (other is! CategoryColors) {
      return this;
    }
    final Map<CategoryType, Color> lerpedColors = {};
    for (var key in colors.keys) {
      lerpedColors[key] = Color.lerp(colors[key], other.colors[key], t)!;
    }
    return CategoryColors(colors: lerpedColors);
  }
}
