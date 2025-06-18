// lib/viewmodel/category_edit_view_model.dart
import 'package:budget/common/enum/app_colors.dart';
import 'package:budget/common/enum/app_icon.dart';
import 'package:budget/common/enum/category_icons.dart';
import 'package:budget/service/database_service.dart';
import 'package:budget/provider/category/category_provider.dart';
import 'package:budget/views/input/input_view_model.dart';
import 'package:budget/views/budget/budget_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'category_create_state.dart';

part 'category_create_view_model.g.dart';

@Riverpod(keepAlive: false)
class CategoryCreateViewModel extends _$CategoryCreateViewModel {
  final DatabaseService _databaseService = DatabaseService.instance;

  @override
  CategoryCreateState build() {
    return const CategoryCreateState();
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
      final isContains = categories
          .map((category) => category.categoryName)
          .any((name) => name.contains(state.categoryName));

      if (isContains) {
        state = state.copyWith(isLoading: false);
        return 'すでに存在するカテゴリ名です';
      }

      await _databaseService.saveCategory(
        categoryName: state.categoryName,
        icon: state.selectedIcon,
        iconColor: state.selectedColor,
      );
      
      // カテゴリ追加後に関連Providerを無効化
      ref.invalidate(categoryProvider);        // カテゴリ一覧を更新
      ref.invalidate(inputViewModelProvider);  // 入力画面のカテゴリ選択肢を更新
      ref.invalidate(budgetViewModelProvider); // 予算画面のカテゴリ情報を更新
      
      state = state.copyWith(isLoading: false);
      return 'success';
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
      );
      return '保存に失敗しました';
    }
  }

  // IDを指定してカテゴリを取得し、Stateを更新する (編集画面を後から開く場合など)
  // このメソッドは build で initialCategory を渡す場合は必須ではないが、
  // ID のみで画面遷移後にデータをロードするケースなどで利用できる
  // Future<void> _loadCategoryById(int categoryId) async {
  //   state = state.copyWith(isLoading: true, errorMessage: null);
  //   try {
  //     final category = await _isarService.getCategoryById(categoryId);
  //     if (category != null) {
  //       state = state.copyWith(
  //         id: category.id,
  //         categoryName: category.categoryName ?? '',
  //         selectedIcon: category.icon,
  //         selectedColor: category.iconColor,
  //         isLoading: false,
  //       );
  //     } else {
  //       state = state.copyWith(isLoading: false, errorMessage: 'カテゴリが見つかりません。');
  //     }
  //   } catch (e) {
  //     state = state.copyWith(
  //         isLoading: false, errorMessage: '読み込みに失敗しました: ${e.toString()}');
  //   }
  // }
}
