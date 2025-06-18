import 'package:budget/data/local/app_database.dart' as db;
import 'package:budget/service/database_service.dart';
import 'package:budget/views/input/input_state.dart';
import 'package:budget/views/calendar/calendar_view_model.dart';
import 'package:budget/views/home/home_view_model.dart';
import 'package:budget/views/budget/budget_view_model.dart';
import 'package:budget/provider/category/category_provider.dart';
import 'package:budget/provider/transaction/transaction_provider.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'input_view_model.g.dart';

@Riverpod(keepAlive: false)
class InputViewModel extends _$InputViewModel {
  final DatabaseService _databaseService = DatabaseService.instance;

  @override
  Future<InputState> build() async {
    final categories = await _databaseService.getAllCategories();
    return InputState(
      amount: '',
      itemName: '',
      categories: categories,
      selectedDate: DateTime.now(),
      selectedCategory: null,
    );
  }

  void setSelectedDate(DateTime date) {
    final current = state.value;
    if (current == null) return;
    state = AsyncValue.data(current.copyWith(selectedDate: date));
  }

  void setAmount(String amount) {
    final current = state.value;
    if (current == null) return;

    state = AsyncValue.data(current.copyWith(amount: amount));
  }

  void setItemName(String itemName) {
    final current = state.value;
    if (current == null) return;
    state = AsyncValue.data(current.copyWith(itemName: itemName));
  }

  void setSelectedCategory(db.Category? category) {
    final current = state.value;
    if (current == null) return;
    state = AsyncValue.data(current.copyWith(selectedCategory: category));
  }

  Future<String> saveTransaction() async {
    try {
      final current = state.value;
      if (current == null) return 'error';
      final amount = int.tryParse(current.amount);
      if (amount == null) return 'error';
      if (current.itemName.isEmpty) return 'error';
      if (current.selectedCategory == null) return 'error';

      await _databaseService.saveTransaction(
        amount: amount,
        itemName: current.itemName,
        date: current.selectedDate,
        categoryId: current.selectedCategory!.id,
      );
      
      // 関連するProviderを無効化してリアルタイム更新
      ref.invalidate(calendarViewModelProvider);  // カレンダー画面
      ref.invalidate(homeViewModelProvider);      // ホーム画面
      ref.invalidate(budgetViewModelProvider);    // 予算画面
      ref.invalidate(categoryProvider);           // カテゴリデータ
      ref.invalidate(transactionProvider);        // 取引データ
      
      return 'success';
    } catch (e) {
      return 'error';
    }
  }

  void scan(InlineDataPart imagePart) async {
    final current = state.value;
    if (current == null) return;
    final categories = current.categories;
    if (categories.isEmpty) return;
    final categoryNames = categories
        .map((c) => c.categoryName)
        .whereType<String>()
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toSet() // 重複排除
        .toList();

    if (!categoryNames.contains('なし')) {
      categoryNames.add('なし');
    }
  }
}
