// lib/viewmodel/category_edit_view_model.dart
import 'package:budget/data/local/app_database.dart' as db;
import 'package:budget/service/database_service.dart';
import 'package:budget/provider/category/category_provider.dart';
import 'package:budget/views/budget/budget_view_model.dart';
import 'package:budget/views/input/input_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_list_view_model.g.dart';

@Riverpod(keepAlive: false)
class CategoryListViewModel extends _$CategoryListViewModel {
  final DatabaseService _databaseService = DatabaseService.instance;

  @override
  Future<List<db.Category>> build() async {
    final categories = await _databaseService.getAllCategories();
    return categories;
  }

  void reorder(int oldIndex, int newIndex) {
    final currentList = [...state.value!];
    if (oldIndex < newIndex) newIndex -= 1;
    final item = currentList.removeAt(oldIndex);
    currentList.insert(newIndex, item);
    state = AsyncValue.data(currentList);
  }

  Future<void> saveOrder() async {
    if (state.value != null) {
      for (var i = 0; i < state.value!.length; i++) {
        final category = state.value![i];
        await _databaseService.saveCategory(
          id: category.id,
          categoryName: category.categoryName,
          icon: category.icon,
          iconColor: category.iconColor,
          sortOrder: i,
        );
      }
      
      // カテゴリ順序変更後に関連Providerを無効化
      ref.invalidate(categoryProvider);           // カテゴリプロバイダー
      ref.invalidate(budgetViewModelProvider);    // 予算画面
      ref.invalidate(inputViewModelProvider);     // 入力画面
      
      // 自分自身も再読み込み
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() => build());
    }
  }

  Future<void> deleteCategory(int id) async {
    await _databaseService.deleteCategory(id);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final categories = await _databaseService.getAllCategories();
      return categories;
    });
  }
}
