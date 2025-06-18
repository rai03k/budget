import 'package:budget/data/local/app_database.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'input_state.freezed.dart';

@freezed
class InputState with _$InputState {
  const factory InputState({
    required List<Category> categories,
    required DateTime selectedDate,
    @Default(null) Category? selectedCategory,
    required String amount,
    required String itemName,
  }) = _InputState;
}
