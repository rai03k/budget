import 'package:budget/common/enum/category_icons.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../common/enum/app_colors.dart';
import '../../common/enum/app_icon.dart';

part 'category_create_state.freezed.dart';

@freezed
class CategoryCreateState with _$CategoryCreateState {
  const factory CategoryCreateState({
    @Default(0) int id,
    @Default('') String categoryName,
    @Default(CategoryIcons.restaurant) CategoryIcons selectedIcon,
    @Default(AppColors.red) AppColors selectedColor,
    @Default(false) bool isLoading,
    @Default('') String errorMessage,
  }) = _CategoryCreateState;
}
