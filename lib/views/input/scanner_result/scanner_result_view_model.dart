import 'dart:async';
import 'dart:typed_data';
import 'package:budget/model/category.dart';
import 'package:budget/model/dto/category_dto.dart';
import 'package:budget/model/receipt_analysis_response.dart';
import 'package:budget/model/transaction.dart';
import 'package:budget/model/transaction.dart' as model;
import 'package:budget/provider/transaction/transaction_provider.dart';
import 'package:budget/service/database_service.dart';
import 'package:budget/service/receipt_analysis_service.dart';
import 'package:budget/views/input/input_view_model.dart';
import 'package:budget/views/input/scanner_result/scanner_result_state.dart';
import 'package:budget/views/calendar/calendar_view_model.dart';
import 'package:camera/camera.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:firebase_ai/firebase_ai.dart' as ai;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'scanner_result_view_model.g.dart';

@Riverpod(keepAlive: false)
class ScannerResultViewModel extends _$ScannerResultViewModel {
  @override
  Future<ScannerResultState> build() async {
    final DatabaseService databaseService = DatabaseService.instance;
    try {
      final categoriesData = await databaseService.getAllCategories();
      // 成功した場合、カテゴリーデータを含んだStateを返す
      print("カテゴリー: $categoriesData");
      return ScannerResultState(categories: categoriesData);
    } catch (e) {
      // 失敗した場合、空のリストを含んだStateを返す
      print("カテゴリーの読み込みに失敗: $e");
      return const ScannerResultState(categories: []);
    }
  }

  void updateTransaction(ReceiptItem updatedItem) {
    // 1. 現在のstateからscannedDataを取得
    final currentScannedData =
        ref.read(transactionProvider.notifier).getScannedData();
    print('${updatedItem.toJson()}');

    // scannedDataがnullの場合は更新できないので処理を中断
    if (currentScannedData == null) {
      // 必要であればエラーログなどを出力
      print("Error: scannedData is null. Cannot update transaction.");
      return;
    }

    // 2. itemsリストの新しいバージョンを作成
    // mapを使って、IDが一致する項目だけをupdatedItemに差し替える
    final newItems = currentScannedData.items.map((item) {
      return item.id == updatedItem.id ? updatedItem : item;
    }).toList(); // mapの結果はIterableなのでListに変換

    // 3. ReceiptAnalysisResponseの新しいバージョンを作成
    // .copyWithを使い、itemsプロパティだけを新しいリストで上書きする
    final newScannedData = currentScannedData.copyWith(items: newItems);
    print('${newScannedData.items.map((i) => i.price)}');
    // 4. ReceiptScannerStateの新しいバージョンを作成
    // .copyWithを使い、scannedDataプロパティだけを新しいデータで上書きする
    ref.read(transactionProvider.notifier).setScannedData(newScannedData);
  }

  Future<bool> saveAllTransactions() async {
    final DatabaseService _databaseService = DatabaseService.instance;

    // 1. 現在のStateからスキャン結果を取得
    final dataToSave = ref.read(transactionProvider.notifier).getScannedData();
    if (dataToSave == null || dataToSave.items.isEmpty) {
      // 保存するデータがない場合は何もしない
      return false;
    }

    try {
      // スキャンされた日付。なければ現在日時を使う。
      final transactionDate = dataToSave.date != null
          ? DateTime.tryParse(dataToSave.date!)
          : DateTime.now();

      // 各ReceiptItemをループしてDatabaseServiceで保存
      final List<Map<String, dynamic>> transactionsToSave = [];

      for (final receiptItem in dataToSave.items) {
        // CategoryDtoからカテゴリIDを取得
        final categoryDto = receiptItem.categoryDto;
        if (categoryDto?.id == null) {
          // カテゴリが設定されていない項目はスキップ
          continue;
        }

        transactionsToSave.add({
          'amount': receiptItem.price,
          'itemName': receiptItem.name,
          'date': transactionDate ?? DateTime.now(),
          'categoryId': categoryDto!.id!,
        });
      }

      // DatabaseServiceを呼び出して一括保存
      await _databaseService.saveAllTransactions(transactionsToSave);

      // カレンダーのデータを更新するためにProviderを無効化
      ref.invalidate(calendarViewModelProvider);
      
      // 他の関連Providerも更新
      ref.invalidate(transactionProvider);

      return true; // 成功
    } catch (e) {
      // エラーログなどを記録
      print('Failed to save transactions: $e');
      return false; // 失敗
    }
  }
}
