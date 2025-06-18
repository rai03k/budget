import 'package:freezed_annotation/freezed_annotation.dart';

part 'budget_provider.freezed.dart';

@freezed
class BudgetState with _$BudgetState {
  const factory BudgetState({
    required int id,
    @Default(null) int? budgetAmount,
    @Default(null) int? spentAmount,
    @Default(null) DateTime? startDate,
    @Default(null) DateTime? endDate,
  }) = _BudgetState;
}
