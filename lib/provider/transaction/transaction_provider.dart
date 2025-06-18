import 'package:budget/common/enum/app_colors.dart';
import 'package:budget/common/enum/category_icons.dart';
import 'package:budget/model/receipt_analysis_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../service/database_service.dart';
import '../category/category_provider.dart';

part 'transaction_provider.freezed.dart';
part 'transaction_provider.g.dart';

@freezed
class TransactionState with _$TransactionState {
  const factory TransactionState({
    ReceiptAnalysisResponse? scannedData,
    required int id,
    required int amount,
    required CategoryState category,
    required DateTime date,
    required String itemName,
  }) = _TransactionState;
}

@Riverpod(keepAlive: true)
class Transaction extends _$Transaction {
  final DatabaseService _databaseService = DatabaseService.instance;

  @override
  Future<List<TransactionState>> build() async {
    return loadTransactions();
  }

  Future<List<TransactionState>> loadTransactions() async {
    final transactionsWithCategory = await _databaseService.getAllTransactionsWithCategory();

    return transactionsWithCategory.map((transactionWithCategory) {
      final transaction = transactionWithCategory.transaction;
      final category = transactionWithCategory.category;
      
      final categoryState = CategoryState(
        id: category.id,
        title: category.categoryName,
        icon: category.icon,
        color: category.iconColor,
      );

      return TransactionState(
        id: transaction.id,
        amount: transaction.amount,
        category: categoryState,
        date: transaction.date,
        itemName: transaction.itemName,
      );
    }).toList();
  }

  Future<void> saveTransaction(
      TransactionState transactionState, CategoryState categoryState) async {
    
    // カテゴリが新規の場合は先に保存
    int categoryId = categoryState.id;
    if (categoryId == 0) {
      categoryId = await _databaseService.saveCategory(
        categoryName: categoryState.title,
        icon: categoryState.icon,
        iconColor: categoryState.color,
      );
    }

    // 取引を保存
    await _databaseService.saveTransaction(
      id: transactionState.id != 0 ? transactionState.id : null,
      amount: transactionState.amount,
      itemName: transactionState.itemName,
      date: transactionState.date,
      categoryId: categoryId,
    );

    await refreshTransactions();
  }

  Future<void> refreshTransactions() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => loadTransactions());
  }

  void setScannedData(ReceiptAnalysisResponse scannedData) {
    state = AsyncValue.data(state.value
            ?.map((t) => t.copyWith(scannedData: scannedData))
            .toList() ??
        []);
  }

  ReceiptAnalysisResponse? getScannedData() {
    return state.value?.firstOrNull?.scannedData;
  }

  void clearScannedData() {
    // state全体をリセットするのではなく、
    // scannedDataプロパティだけをnullにした新しいstateで更新する

    // 現在のstateを取得
    final currentState = state;

    // scannedDataだけをnullにした新しいstateオブジェクトを作成
    // ※ YourTransactionState は、あなたが定義したStateクラス名に置き換えてください
    final newState = AsyncValue.data(
        state.value?.map((t) => t.copyWith(scannedData: null)).toList() ?? []);

    // stateを更新
    state = newState;

    print("以前のスキャン結果がクリアされました。");
  }
}
