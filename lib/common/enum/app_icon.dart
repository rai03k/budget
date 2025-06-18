import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

enum AppIcon {
  none,
  home,
  setting,
  chart,
  plus,
  calendar,
}

extension AppIconExtension on AppIcon {
  IconData get iconData {
    switch (this) {
      case AppIcon.none:
        return HugeIcons.strokeRoundedBorderNone02;
      case AppIcon.home:
        return HugeIcons.strokeRoundedHome03;
      case AppIcon.setting:
        return HugeIcons.strokeRoundedSetting07;
      case AppIcon.chart:
        return HugeIcons.strokeRoundedCoins01;
      case AppIcon.plus:
        return HugeIcons.strokeRoundedPlusSign;
      case AppIcon.calendar:
        return HugeIcons.strokeRoundedCalendar03;
    }
  }
}
