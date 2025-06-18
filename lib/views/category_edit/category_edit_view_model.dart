// lib/viewmodel/category_edit_view_model.dart
import 'package:budget/common/enum/app_colors.dart';
import 'package:budget/common/enum/category_icons.dart';
import 'package:budget/data/local/app_database.dart';
import 'package:budget/service/database_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'category_edit_state.dart';

part 'category_edit_view_model.g.dart';

@Riverpod(keepAlive: true)
class CategoryEditViewModel extends _$CategoryEditViewModel {
  final DatabaseService _databaseService = DatabaseService.instance;

  @override
  CategoryEditState build() {
    return const CategoryEditState();
  }

  void setCategory(Category category) {
    state = state.copyWith(
      id: category.id,
      categoryName: category.categoryName,
      selectedIcon: category.icon,
      selectedColor: category.iconColor,
    );
  }

  CategoryEditState getCategory() {
    return state;
  }

  void updateCategoryName(String name) {
    state = state.copyWith(categoryName: name);
  }

  void selectIcon(CategoryIcons icon) {
    state = state.copyWith(selectedIcon: icon);
  }

  void selectColor(AppColors color) {
    state = state.copyWith(selectedColor: color);
  }

  Future<String> saveCategory() async {
    state = state.copyWith(isLoading: true, errorMessage: '');

    try {
      final categories = await _databaseService.getAllCategories();
      final isContains = categories.any((category) =>
          category.categoryName == state.categoryName &&
          category.id != state.id);

      if (isContains) {
        return 'すでに存在するカテゴリ名です';
      }

      await _databaseService.saveCategory(
        id: state.id,
        categoryName: state.categoryName,
        icon: state.selectedIcon,
        iconColor: state.selectedColor,
      );
      state = state.copyWith(isLoading: false);
      return 'success';
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
      );
      return '保存に失敗しました';
    }
  }
}
