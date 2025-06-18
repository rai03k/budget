import 'package:flutter/material.dart';

enum AppColors {
  red,
  blue,
  green,
  yellow,
  orange,
  purple,
  pink,
  brown,
  cyan,
  lime,
  indigo,
  teal,
  amber,
  grey,
}

extension AppColorsExtension on AppColors {
  Color color(BuildContext context) {
    final scheme = Theme.of(context).extension<AppColorScheme>();
    return scheme?.colors[this] ?? Colors.black;
  }
}

class AppColorScheme extends ThemeExtension<AppColorScheme> {
  final Map<AppColors, Color> colors;

  const AppColorScheme({required this.colors});

  @override
  AppColorScheme copyWith({Map<AppColors, Color>? colors}) {
    return AppColorScheme(colors: colors ?? this.colors);
  }

  @override
  AppColorScheme lerp(ThemeExtension<AppColorScheme>? other, double t) {
    if (other is! AppColorScheme) return this;
    return AppColorScheme(
      colors: {
        for (final key in colors.keys)
          key: Color.lerp(colors[key], other.colors[key], t) ?? colors[key]!,
      },
    );
  }

  // ライトテーマ用
  static const light = AppColorScheme(
    colors: {
      AppColors.red: Colors.red,
      AppColors.blue: Colors.blue,
      AppColors.green: Colors.green,
      AppColors.yellow: Colors.yellow,
      AppColors.orange: Colors.orange,
      AppColors.purple: Colors.purple,
      AppColors.pink: Colors.pink,
      AppColors.brown: Colors.brown,
      AppColors.cyan: Colors.cyan,
      AppColors.lime: Colors.lime,
      AppColors.indigo: Colors.indigo,
      AppColors.teal: Colors.teal,
      AppColors.amber: Colors.amber,
      AppColors.grey: Colors.grey,
    },
  );

// ダークテーマ用（やや暗めや落ち着いたトーンに）
  static const dark = AppColorScheme(
    colors: {
      AppColors.red: Colors.red,
      AppColors.blue: Colors.blue,
      AppColors.green: Colors.green,
      AppColors.yellow: Colors.yellow,
      AppColors.orange: Colors.orange,
      AppColors.purple: Colors.purple,
      AppColors.pink: Colors.pink,
      AppColors.brown: Colors.brown,
      AppColors.cyan: Colors.cyan,
      AppColors.lime: Colors.lime,
      AppColors.indigo: Colors.indigo,
      AppColors.teal: Colors.teal,
      AppColors.amber: Colors.amber,
      AppColors.grey: Colors.grey,
    },
  );
}
