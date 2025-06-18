import 'package:freezed_annotation/freezed_annotation.dart';

part 'weekly_expense_review_state.freezed.dart';

@freezed
class ExpenseItem with _$ExpenseItem {
  const factory ExpenseItem({
    required String title,
    required int amount, // Driftのintに合わせる
    required DateTime date,
    @Default(false) bool isDismissed,
    @Default('🍫') String emoji,
  }) = _ExpenseItem;
}

@freezed
class WeeklyExpenseReviewState with _$WeeklyExpenseReviewState {
  const factory WeeklyExpenseReviewState({
    @Default([]) List<ExpenseItem> items,
    @Default([]) List<String> dismissedEmojis,
    @Default(0) int dismissedTotal, // Driftのintに合わせる
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _WeeklyExpenseReviewState;

  const WeeklyExpenseReviewState._();

  bool get isAllItemsDismissed => items.every((item) => item.isDismissed);
}
