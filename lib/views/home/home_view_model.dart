import 'package:budget/service/database_service.dart';
import 'package:budget/views/home/home_state.dart';
import 'package:riverpod/riverpod.dart';

final homeViewModelProvider = StateNotifierProvider<HomeViewModelNotifier, AsyncValue<HomeState>>((ref) {
  return HomeViewModelNotifier();
});

class HomeViewModelNotifier extends StateNotifier<AsyncValue<HomeState>> {
  final DatabaseService _databaseService = DatabaseService.instance;

  HomeViewModelNotifier() : super(const AsyncValue.loading()) {
    loadExpenseData();
  }

  Future<void> loadExpenseData() async {
    try {
      state = const AsyncValue.loading();
      final data = await _loadExpenseData();
      state = AsyncValue.data(data);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<HomeState> _loadExpenseData() async {
    try {
      final now = DateTime.now();
      
      // 今日の日付範囲
      final todayStart = DateTime(now.year, now.month, now.day);
      final todayEnd = todayStart.add(const Duration(days: 1));
      
      // 昨日の日付範囲
      final yesterdayStart = todayStart.subtract(const Duration(days: 1));
      final yesterdayEnd = todayStart;
      
      // 今週の日付範囲（月曜日始まり）
      final weekday = now.weekday;
      final thisWeekStart = now.subtract(Duration(days: weekday - 1));
      final thisWeekStartDay = DateTime(thisWeekStart.year, thisWeekStart.month, thisWeekStart.day);
      final thisWeekEnd = thisWeekStartDay.add(const Duration(days: 7));
      
      // 先週の日付範囲
      final lastWeekStart = thisWeekStartDay.subtract(const Duration(days: 7));
      final lastWeekEnd = thisWeekStartDay;
      
      // 今月の日付範囲
      final thisMonthStart = DateTime(now.year, now.month, 1);
      final thisMonthEnd = DateTime(now.year, now.month + 1, 1);
      
      // 先月の日付範囲
      final lastMonthStart = DateTime(now.year, now.month - 1, 1);
      final lastMonthEnd = DateTime(now.year, now.month, 1);

      // 各期間の支出を並列で取得
      final futures = await Future.wait([
        _getExpenseForPeriod(todayStart, todayEnd),      // 今日
        _getExpenseForPeriod(yesterdayStart, yesterdayEnd), // 昨日
        _getExpenseForPeriod(thisWeekStartDay, thisWeekEnd),  // 今週
        _getExpenseForPeriod(lastWeekStart, lastWeekEnd),     // 先週
        _getExpenseForPeriod(thisMonthStart, thisMonthEnd),   // 今月
        _getExpenseForPeriod(lastMonthStart, lastMonthEnd),   // 先月
      ]);

      return HomeState(
        todayExpense: futures[0],
        yesterdayExpense: futures[1],
        thisWeekExpense: futures[2],
        lastWeekExpense: futures[3],
        thisMonthExpense: futures[4],
        lastMonthExpense: futures[5],
        totalSavings: 0, // TODO: 実際の節約額計算を実装
        isLoading: false,
      );
    } catch (e) {
      return HomeState(
        isLoading: false,
        errorMessage: '支出データの読み込みに失敗しました: $e',
      );
    }
  }

  Future<int> _getExpenseForPeriod(DateTime start, DateTime end) async {
    try {
      final transactions = await _databaseService.getTransactionsByDateRange(start, end);
      return transactions.fold<int>(0, (sum, transaction) => sum + transaction.amount);
    } catch (e) {
      return 0;
    }
  }

  /// データを再読み込み
  Future<void> refresh() async {
    await loadExpenseData();
  }
}

/// 比較パーセンテージを文字列で取得
String getComparisonText(double percentage) {
  if (percentage > 0) {
    return '+${percentage.toStringAsFixed(0)}%';
  } else if (percentage < 0) {
    return '${percentage.toStringAsFixed(0)}%';
  } else {
    return '±0%';
  }
}

/// 比較アイコンのタイプを取得
ComparisonType getComparisonType(double percentage) {
  if (percentage > 0) {
    return ComparisonType.increase;
  } else if (percentage < 0) {
    return ComparisonType.decrease;
  } else {
    return ComparisonType.same;
  }
}

enum ComparisonType {
  increase,
  decrease,
  same,
}