import 'package:budget/common/enum/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonCategoryIcon extends StatelessWidget {
  const CommonCategoryIcon({this.color, this.icon, super.key});

  final Color? color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final defaultColor = AppColors.grey.color(context);
    final defaultIcon = Icons.question_mark;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color ?? defaultColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon ?? defaultIcon,
        color: Colors.white,
        size: 20,
      ),
    );
  }
}
