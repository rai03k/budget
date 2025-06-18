import 'package:budget/provider/category/category_provider.dart';
import 'package:budget/provider/budget/budget_provider.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'budget_state.freezed.dart';

@freezed
class BudgetPageState with _$BudgetPageState {
  const factory BudgetPageState({
    @Default(false) bool isEditing,
    @Default([]) List<CategoryState> categories,
    @Default([]) List<BudgetState> budgets,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _BudgetPageState;
}