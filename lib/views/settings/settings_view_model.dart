import 'package:budget/service/database_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../provider/category/category_provider.dart';
import 'settings_state.dart';

part 'settings_view_model.g.dart';

@Riverpod(keepAlive: true)
class SettingsViewModel extends _$SettingsViewModel {
  final DatabaseService _databaseService = DatabaseService.instance;

  @override
  Future<SettingsState> build() async {
    try {
      final categories = await _databaseService.getAllCategories();
      
      // Driftのカテゴリデータを CategoryState に変換
      final categoryStates = categories
          .map((category) => CategoryState(
                id: category.id,
                title: category.categoryName,
                icon: category.icon,
                color: category.iconColor,
              ))
          .toList();

      return SettingsState(categories: categoryStates);
    } catch (e) {
      // エラーが発生した場合は空のリストを返す
      return const SettingsState(categories: []);
    }
  }

  /// カテゴリーリストを更新
  Future<void> refreshCategories() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => build());
  }

  /// カテゴリを削除
  Future<void> deleteCategory(int categoryId) async {
    try {
      await _databaseService.deleteCategory(categoryId);
      await refreshCategories();
    } catch (e) {
      // エラーハンドリング
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// データベースをクリア（デバッグ用）
  Future<void> clearDatabase() async {
    try {
      // 全ての取引を削除
      final transactions = await _databaseService.getAllTransactions();
      for (final transaction in transactions) {
        await _databaseService.deleteTransaction(transaction.id);
      }

      // 全てのカテゴリを削除
      final categories = await _databaseService.getAllCategories();
      for (final category in categories) {
        await _databaseService.deleteCategory(category.id);
      }

      // 全ての予算を削除
      final budgets = await _databaseService.getAllBudgets();
      for (final budget in budgets) {
        await _databaseService.deleteBudget(budget.id);
      }

      await refreshCategories();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}