import 'dart:ui';

import 'package:budget/provider/transaction/transaction_provider.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_state.freezed.dart';

@freezed
class CalendarState with _$CalendarState {
  const factory CalendarState({
    required DateTime selectedDate,
    required DateTime currentPageDate,
    required int currentPageIndex,
    @Default(false) bool isBottomSheetVisible,
    @Default(0.0) double position,
    @Default([]) List<TransactionState> transactions,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _CalendarState;

  factory CalendarState.initial() {
    final now = DateTime.now();
    return CalendarState(
      selectedDate: now,
      currentPageDate: DateTime(now.year, now.month, 1),
      currentPageIndex: 1200, // ViewModelの基準インデックスを使用
      isBottomSheetVisible: false,
      position: 0,
      transactions: [],
      isLoading: false,
    );
  }
}
