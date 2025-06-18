import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../provider/category/category_provider.dart';
import '../../service/database_service.dart';
import 'budget_state.dart';

part 'budget_view_model.g.dart';

@riverpod
class BudgetViewModel extends _$BudgetViewModel {
  final DatabaseService _databaseService = DatabaseService.instance;

  @override
  Future<BudgetPageState> build() async {
    try {
      // Driftからカテゴリ一覧を取得
      final categories = await _databaseService.getAllCategories();
      
      // 予算データを取得
      final budgets = await _databaseService.getAllBudgets();

      // Category → CategoryState に変換
      final categoryStates = categories
          .map((c) => CategoryState(
                id: c.id,
                title: c.categoryName,
                icon: c.icon,
                color: c.iconColor,
              ))
          .toList();

      // BudgetPageState を返す
      return BudgetPageState(
        categories: categoryStates,
        isLoading: false,
      );
    } catch (e) {
      return BudgetPageState(
        isLoading: false,
        errorMessage: 'データの読み込みに失敗しました: $e',
      );
    }
  }

  /// 編集モードの切り替え
  void toggleEditMode() async {
    final currentState = await future;
    state = AsyncValue.data(
      currentState.copyWith(isEditing: !currentState.isEditing),
    );
  }

  /// カテゴリの予算を更新
  Future<void> updateCategoryBudget(int categoryId, int budgetAmount) async {
    try {
      state = const AsyncValue.loading();
      
      // 既存の予算を検索
      final existingBudgets = await _databaseService.getAllBudgets();
      final existingBudget = existingBudgets
          .where((b) => b.budgetAmount == budgetAmount) // 仮の条件、実際はカテゴリIDで検索
          .firstOrNull;

      if (existingBudget != null) {
        // 既存の予算を更新
        await _databaseService.saveBudget(
          id: existingBudget.id,
          budgetAmount: budgetAmount,
          spentAmount: existingBudget.spentAmount,
          startDate: existingBudget.startDate,
          endDate: existingBudget.endDate,
        );
      } else {
        // 新しい予算を作成
        await _databaseService.saveBudget(
          budgetAmount: budgetAmount,
          spentAmount: 0,
          startDate: DateTime.now(),
          endDate: DateTime.now().add(const Duration(days: 30)),
        );
      }

      // データを再読み込み
      await refresh();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// データを再読み込み
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => build());
  }

  /// 予算を削除
  Future<void> deleteBudget(int budgetId) async {
    try {
      await _databaseService.deleteBudget(budgetId);
      await refresh();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}