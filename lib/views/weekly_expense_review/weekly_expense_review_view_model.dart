import 'package:budget/service/database_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'weekly_expense_review_state.dart';

part 'weekly_expense_review_view_model.g.dart';

@riverpod
class WeeklyExpenseReviewViewModel extends _$WeeklyExpenseReviewViewModel {
  final DatabaseService _databaseService = DatabaseService.instance;

  @override
  Future<WeeklyExpenseReviewState> build() async {
    try {
      // 過去1週間の取引を取得
      final now = DateTime.now();
      final weekAgo = now.subtract(const Duration(days: 7));
      
      final transactionsWithCategory = await _databaseService.getAllTransactionsWithOptionalCategory();
      
      // 過去1週間の取引をフィルタリング
      final weeklyTransactions = transactionsWithCategory
          .where((tx) => tx.transaction.date.isAfter(weekAgo) && tx.transaction.date.isBefore(now))
          .toList();

      // ExpenseItemに変換
      final expenseItems = weeklyTransactions.map((tx) {
        final transaction = tx.transaction;
        final category = tx.category;
        
        // カテゴリのアイコンから絵文字を生成（簡単な例）
        String emoji = '🍫'; // デフォルト
        if (category != null) {
          switch (category.icon.name) {
          case 'restaurant':
            emoji = '🍽️';
            break;
          case 'shopping':
            emoji = '🛒';
            break;
          case 'transport':
            emoji = '🚗';
            break;
          case 'entertainment':
            emoji = '🎬';
            break;
          default:
            emoji = '💰';
          }
        }

        return ExpenseItem(
          title: transaction.itemName,
          amount: transaction.amount,
          date: transaction.date,
          emoji: emoji,
          isDismissed: false,
        );
      }).toList();

      return WeeklyExpenseReviewState(
        items: expenseItems,
        isLoading: false,
      );
    } catch (e) {
      return WeeklyExpenseReviewState(
        items: _getDefaultItems(),
        isLoading: false,
        errorMessage: 'データの読み込みに失敗しました: $e',
      );
    }
  }

  /// デフォルトのサンプルデータ
  List<ExpenseItem> _getDefaultItems() {
    return [
      ExpenseItem(
        title: 'お菓子',
        amount: 5409,
        date: DateTime.now().subtract(const Duration(days: 1)),
        emoji: '😋',
      ),
      ExpenseItem(
        title: 'コーヒー',
        amount: 540,
        date: DateTime.now().subtract(const Duration(days: 2)),
        emoji: '☕',
      ),
      ExpenseItem(
        title: '昼食',
        amount: 1200,
        date: DateTime.now().subtract(const Duration(days: 3)),
        emoji: '🍱',
      ),
      ExpenseItem(
        title: '牛乳',
        amount: 280,
        date: DateTime.now().subtract(const Duration(days: 4)),
        emoji: '🥛',
      ),
      ExpenseItem(
        title: '卵',
        amount: 350,
        date: DateTime.now().subtract(const Duration(days: 5)),
        emoji: '🥚',
      ),
    ];
  }

  /// アイテムを除外（節約として処理）
  void dismissItem(int index) async {
    final currentState = await future;
    final updatedItems = [...currentState.items];
    
    if (index < 0 || index >= updatedItems.length) return;
    
    final item = updatedItems[index];
    updatedItems[index] = item.copyWith(isDismissed: true);
    
    final updatedEmojis = [...currentState.dismissedEmojis, item.emoji];
    final updatedTotal = currentState.dismissedTotal + item.amount;
    
    state = AsyncValue.data(currentState.copyWith(
      items: updatedItems,
      dismissedEmojis: updatedEmojis,
      dismissedTotal: updatedTotal,
    ));
  }

  /// アイテムをリセット
  void resetItems() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => build());
  }

  /// データを再読み込み
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => build());
  }
}