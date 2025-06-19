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
    // カテゴリーデータの変更を監視するために、categoryProviderに依存
    ref.watch(categoryProvider);
    
    try {
      // Driftからカテゴリ一覧を取得
      final categories = await _databaseService.getAllCategories();
      
      // 予算データを取得
      final budgets = await _databaseService.getAllBudgets();

      // Category → CategoryState に変換（データベースから既にソート順で取得済み）
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

  /// 指定された月とカテゴリの予算情報を取得
  Future<Map<String, int>> getBudgetAndSpentForCategory(int categoryId, DateTime month) async {
    try {
      final startDate = DateTime(month.year, month.month, 1);
      final endDate = DateTime(month.year, month.month + 1, 0);
      
      // 該当月・カテゴリの予算を取得
      final budget = await _databaseService.getBudgetByCategoryAndMonth(
        categoryId, 
        month.year, 
        month.month
      );
      
      print('予算データ検索: categoryId=$categoryId, 年=${month.year}, 月=${month.month}');
      print('取得した予算: ${budget?.budgetAmount ?? 0}');
      
      // 該当月・カテゴリの支出合計を取得
      final transactions = await _databaseService.getTransactionsByDateRange(startDate, endDate);
      final spent = transactions
          .where((t) => t.categoryId == categoryId)
          .fold<int>(0, (sum, t) => sum + t.amount);
      
      print('支出合計: $spent');
      
      return {
        'budget': budget?.budgetAmount ?? 0,
        'spent': spent,
      };
    } catch (e) {
      print('予算取得エラー: $e');
      return {'budget': 0, 'spent': 0};
    }
  }

  /// 編集モードの切り替え
  void toggleEditMode() async {
    final currentState = await future;
    state = AsyncValue.data(
      currentState.copyWith(isEditing: !currentState.isEditing),
    );
  }

  /// カテゴリの予算を更新（非推奨: saveBudgetを使用してください）
  @Deprecated('Use saveBudget instead')
  Future<void> updateCategoryBudget(int categoryId, int budgetAmount) async {
    await saveBudget(
      categoryId: categoryId,
      budgetAmount: budgetAmount,
      month: DateTime.now(),
    );
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

  /// カテゴリーの予算を保存（指定月に適用）
  Future<void> saveBudget({
    required int categoryId,
    required int budgetAmount,
    required DateTime month,
  }) async {
    try {
      print('予算保存開始: categoryId=$categoryId, 金額=$budgetAmount, 年=${month.year}, 月=${month.month}');
      
      // 既存の予算をチェック
      final existingBudget = await _databaseService.getBudgetByCategoryAndMonth(
        categoryId, 
        month.year, 
        month.month
      );
      
      if (existingBudget != null) {
        print('既存予算を更新: ID=${existingBudget.id}');
        // 既存の予算を更新
        await _databaseService.saveBudget(
          id: existingBudget.id,
          categoryId: categoryId,
          year: month.year,
          month: month.month,
          budgetAmount: budgetAmount,
        );
      } else {
        print('新規予算を作成');
        // 新規予算を作成
        await _databaseService.saveBudget(
          categoryId: categoryId,
          year: month.year,
          month: month.month,
          budgetAmount: budgetAmount,
        );
      }
      
      // 次月の予算を自動引き継ぎ
      await _propagateBudgetToFutureMonths(categoryId, budgetAmount, month);
      
      print('予算保存完了');
      
      // データを再読み込み
      await refresh();
    } catch (e) {
      print('予算保存エラー: $e');
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// 指定された月以降の未来の月に予算を引き継ぎ
  Future<void> _propagateBudgetToFutureMonths(
    int categoryId, 
    int budgetAmount, 
    DateTime currentMonth
  ) async {
    try {
      // 次月から12ヶ月先まで予算を引き継ぎ（既存の予算がない場合のみ）
      for (int i = 1; i <= 12; i++) {
        DateTime futureMonth;
        if (currentMonth.month + i > 12) {
          // 年を跨ぐ場合
          futureMonth = DateTime(
            currentMonth.year + ((currentMonth.month + i - 1) ~/ 12),
            ((currentMonth.month + i - 1) % 12) + 1,
            1
          );
        } else {
          futureMonth = DateTime(currentMonth.year, currentMonth.month + i, 1);
        }
        
        // 未来の月に既存予算があるかチェック
        final existingFutureBudget = await _databaseService.getBudgetByCategoryAndMonth(
          categoryId,
          futureMonth.year,
          futureMonth.month
        );
        
        if (existingFutureBudget == null) {
          // 既存予算がない場合のみ新規作成
          await _databaseService.saveBudget(
            categoryId: categoryId,
            year: futureMonth.year,
            month: futureMonth.month,
            budgetAmount: budgetAmount,
          );
          print('予算引き継ぎ: ${futureMonth.year}年${futureMonth.month}月に¥$budgetAmount');
        }
      }
    } catch (e) {
      print('予算引き継ぎエラー: $e');
    }
  }

  /// ページから入力された予算を一括保存
  Future<void> saveBudgetsFromPage(DateTime month) async {
    // この実装では、BudgetCardから直接保存されるため、
    // 特別な処理は不要。必要に応じて追加のロジックを実装可能
    print('予算一括保存完了: ${month.year}年${month.month}月');
  }
}