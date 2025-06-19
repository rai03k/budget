import 'package:budget/common/enum/app_colors.dart';
import 'package:budget/provider/category/category_provider.dart';
import 'package:budget/provider/transaction/transaction_provider.dart';
import 'package:budget/service/database_service.dart';
import 'package:budget/views/home/home_view_model.dart';
import 'package:budget/views/budget/budget_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'calendar_state.dart';

part 'calendar_view_model.g.dart';

@Riverpod(keepAlive: false)
class CalendarViewModel extends _$CalendarViewModel {
  final _databaseService = DatabaseService.instance;

  @override
  Future<CalendarState> build() async {
    // 取引データの変更を監視するために、transactionProviderに依存
    // ref.watch(transactionProvider); // 一時的にコメントアウト
    
    try {
      // 削除されたカテゴリの支出も含めて取得
      final transactionsWithCategory = await _databaseService.getAllTransactionsWithOptionalCategory();

      final transactionStates = transactionsWithCategory.map((transactionWithCategory) {
        final transaction = transactionWithCategory.transaction;
        final category = transactionWithCategory.category;

        // カテゴリが削除されている場合は「不明」カテゴリを使用
        final CategoryState categoryState;
        if (category == null) {
          categoryState = CategoryState.unknownCategory;
        } else {
          categoryState = CategoryState(
            id: category.id,
            title: category.categoryName,
            icon: category.icon,
            color: category.iconColor,
          );
        }

        return TransactionState(
          id: transaction.id,
          amount: transaction.amount,
          date: transaction.date,
          itemName: transaction.itemName,
          category: categoryState,
        );
      }).toList();

      return CalendarState.initial().copyWith(
        transactions: transactionStates,
        isLoading: false,
      );
    } catch (e) {
      return CalendarState.initial().copyWith(
        isLoading: false,
        errorMessage: 'データの読み込みに失敗しました: $e',
      );
    }
  }

  /// PageViewのページが変更された時の処理
  void updateCurrentPage(int newPageIndex) async {
    final currentState = await future;
    
    if (newPageIndex == currentState.currentPageIndex) return;

    // 新しいページインデックスに基づいて表示月を計算
    final int monthDiff = newPageIndex - currentState.currentPageIndex;
    final DateTime newPageDate = DateTime(
      currentState.currentPageDate.year,
      currentState.currentPageDate.month + monthDiff,
      1,
    );

    // 状態を更新
    state = AsyncValue.data(currentState.copyWith(
      currentPageIndex: newPageIndex,
      currentPageDate: newPageDate,
      isBottomSheetVisible: false, // 月が変わったらボトムシートを閉じる
    ));
  }

  /// 日付を選択する
  void selectDate(DateTime date, double position) async {
    final currentState = await future;
    
    // 選択した日付が現在のページの月と異なる場合、その月に移動
    if (date.month != currentState.currentPageDate.month ||
        date.year != currentState.currentPageDate.year) {
      final DateTime newPageDate = DateTime(date.year, date.month, 1);
      final now = DateTime.now();
      final int monthDiff =
          (newPageDate.year - now.year) * 12 + newPageDate.month - now.month;
      final newPageIndex = 1200 + monthDiff;

      state = AsyncValue.data(currentState.copyWith(
        selectedDate: date,
        currentPageIndex: newPageIndex,
        currentPageDate: newPageDate,
        isBottomSheetVisible: true,
        position: position,
      ));
    } else {
      // 同じ月内の日付選択の場合
      state = AsyncValue.data(currentState.copyWith(
        selectedDate: date,
        isBottomSheetVisible: true,
        position: position,
      ));
    }
  }

  /// ボトムシートを閉じる
  void closeBottomSheet() async {
    final currentState = await future;
    state = AsyncValue.data(currentState.copyWith(
      isBottomSheetVisible: false,
    ));
  }

  /// 指定した日付の取引を取得
  List<TransactionState> getTransactionsForDate(DateTime date) {
    return state.when(
      data: (calendarState) => calendarState.transactions
          .where((tx) =>
              tx.date.year == date.year &&
              tx.date.month == date.month &&
              tx.date.day == date.day)
          .toList(),
      loading: () => [],
      error: (_, __) => [],
    );
  }

  /// カテゴリの色一覧を取得
  List<CategoryState> getCategoryColors() {
    return state.when(
      data: (calendarState) {
        final seenColors = <AppColors>{};
        final ret = <CategoryState>[];

        for (final transaction in calendarState.transactions) {
          final color = transaction.category.color;
          if (!seenColors.contains(color)) {
            seenColors.add(color);
            ret.add(transaction.category);
          }
        }
        return ret;
      },
      loading: () => [],
      error: (_, __) => [],
    );
  }

  /// 指定した日付の取引で使用されているカテゴリを取得
  List<CategoryState> getCategoriesForDate(DateTime date) {
    return state.when(
      data: (calendarState) {
        final seenCategories = <int>{};
        final ret = <CategoryState>[];

        final dailyTransactions = calendarState.transactions
            .where((t) =>
                t.date.year == date.year &&
                t.date.month == date.month &&
                t.date.day == date.day)
            .toList();

        for (final transaction in dailyTransactions) {
          final categoryId = transaction.category.id;
          if (!seenCategories.contains(categoryId)) {
            seenCategories.add(categoryId);
            ret.add(transaction.category);
          }
        }
        return ret;
      },
      loading: () => [],
      error: (_, __) => [],
    );
  }

  /// データを再読み込み
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => build());
  }

  /// ボトムシートの状態を保持しながらデータを再読み込み
  Future<void> refreshPreservingBottomSheet() async {
    final currentState = await future;
    
    try {
      // 削除されたカテゴリの支出も含めて取得
      final transactionsWithCategory = await _databaseService.getAllTransactionsWithOptionalCategory();

      final transactionStates = transactionsWithCategory.map((transactionWithCategory) {
        final transaction = transactionWithCategory.transaction;
        final category = transactionWithCategory.category;

        // カテゴリが削除されている場合は「不明」カテゴリを使用
        final CategoryState categoryState;
        if (category == null) {
          categoryState = CategoryState.unknownCategory;
        } else {
          categoryState = CategoryState(
            id: category.id,
            title: category.categoryName,
            icon: category.icon,
            color: category.iconColor,
          );
        }

        return TransactionState(
          id: transaction.id,
          amount: transaction.amount,
          date: transaction.date,
          itemName: transaction.itemName,
          category: categoryState,
        );
      }).toList();

      // 既存の状態を保持しつつ、取引データのみ更新
      state = AsyncValue.data(currentState.copyWith(
        transactions: transactionStates,
        isLoading: false,
      ));
    } catch (e) {
      state = AsyncValue.data(currentState.copyWith(
        isLoading: false,
        errorMessage: 'データの読み込みに失敗しました: $e',
      ));
    }
  }

  /// 「今日」ボタンが押された時の処理
  void goToToday() async {
    final today = DateTime.now();
    final currentState = await future;
    
    final newPageDate = DateTime(today.year, today.month, 1);
    final monthDiff = (today.year - DateTime.now().year) * 12 + today.month - DateTime.now().month;
    final newPageIndex = 1200 + monthDiff;

    state = AsyncValue.data(currentState.copyWith(
      selectedDate: today,
      currentPageIndex: newPageIndex,
      currentPageDate: newPageDate,
      isBottomSheetVisible: false,
    ));
  }

  /// 指定した日付の支出合計を取得
  int? getExpenseForDate(DateTime date) {
    return state.when(
      data: (calendarState) {
        final dailyTransactions = calendarState.transactions
            .where((t) =>
                t.date.year == date.year &&
                t.date.month == date.month &&
                t.date.day == date.day)
            .toList();
        
        if (dailyTransactions.isEmpty) return null;
        
        final dailyTotal = dailyTransactions.fold<int>(0, (sum, t) => sum + t.amount);
        return dailyTotal > 0 ? dailyTotal : null;
      },
      loading: () => null,
      error: (_, __) => null,
    );
  }

  /// 選択されたセルの矩形情報をクリア
  void clearSelectedCellRect() {
    // 矩形情報をクリア（必要に応じて実装）
  }

  /// 取引を削除
  Future<void> deleteTransaction(int transactionId) async {
    try {
      // まず、ローカル状態から削除してUI即座に更新
      final currentState = await future;
      final updatedTransactions = currentState.transactions
          .where((transaction) => transaction.id != transactionId)
          .toList();
      
      // ローカル状態を更新（ボトムシート状態は保持）
      state = AsyncValue.data(currentState.copyWith(
        transactions: updatedTransactions,
      ));
      
      // バックグラウンドでデータベース削除
      await _databaseService.deleteTransaction(transactionId);
      
      // 他の画面のプロバイダーを遅延して無効化
      Future.delayed(const Duration(milliseconds: 100), () {
        ref.invalidate(transactionProvider);        // 取引データ
        ref.invalidate(homeViewModelProvider);      // ホーム画面
        ref.invalidate(budgetViewModelProvider);    // 予算画面
      });
      
    } catch (e) {
      // エラーハンドリング（必要に応じて実装）
      print('Failed to delete transaction: $e');
      // エラーが発生した場合は元の状態に戻す
      await refreshPreservingBottomSheet();
    }
  }
}