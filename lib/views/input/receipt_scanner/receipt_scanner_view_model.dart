import 'dart:async';
import 'dart:typed_data';
import 'package:budget/data/local/app_database.dart';
import 'package:budget/model/dto/category_dto.dart';
import 'package:budget/model/receipt_analysis_response.dart';
import 'package:budget/model/transaction.dart';
import 'package:budget/model/transaction.dart' as model;
import 'package:budget/provider/transaction/transaction_provider.dart';
import 'package:budget/service/database_service.dart';
import 'package:budget/service/receipt_analysis_service.dart';
import 'package:budget/views/input/input_view_model.dart';
import 'package:camera/camera.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:firebase_ai/firebase_ai.dart' as ai;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'receipt_scanner_state.dart';

part 'receipt_scanner_view_model.g.dart';

@Riverpod(keepAlive: false)
class ReceiptScannerViewModel extends _$ReceiptScannerViewModel {
  // Viewから直接アクセスさせないため、プライベートにする
  CameraController? _cameraController;
  final ImagePicker _imagePicker = ImagePicker();

  // Viewがカメラプレビューを描画するためにコントローラーを公開する
  CameraController? get cameraController => _cameraController;

  @override
  ReceiptScannerState build() {
    // このViewModelが破棄されるタイミングでカメラコントローラーも破棄する
    ref.onDispose(() {
      _cameraController?.dispose();
      print("カメラコントローラーが破棄されました");
    });
    // 初期化処理を呼び出す
    initializeCamera();
    // 初期状態を返す
    return const ReceiptScannerState();
  }

  /// カメラの初期化処理
  Future<void> initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        throw Exception('利用可能なカメラが見つかりません');
      }
      _cameraController = CameraController(
        cameras[0], // 背面カメラ
        ResolutionPreset.high,
        enableAudio: false,
      );
      await _cameraController!.initialize();
      // 状態を更新してUIに通知
      state = state.copyWith(isCameraInitialized: true, errorMessage: null);
    } catch (e) {
      // エラーが発生したら状態にメッセージをセット
      state = state.copyWith(
          isCameraInitialized: false,
          errorMessage: e.toString().replaceFirst('Exception: ', ''));
    }
  }

  /// 写真を撮影する
  Future<void> takePicture() async {
    if (!state.isCameraInitialized ||
        _cameraController!.value.isTakingPicture) {
      return;
    }
    state = state.copyWith(isProcessing: true);
    try {
      final image = await _cameraController!.takePicture();
      _processImage(image);
    } catch (e) {
      state = state.copyWith(isProcessing: false, errorMessage: e.toString());
    }
  }

  /// ギャラリーから画像を選択する
  Future<void> pickImageFromGallery() async {
    state = state.copyWith(isProcessing: true);
    try {
      final image = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        _processImage(image);
      } else {
        // 画像選択がキャンセルされた場合
        state = state.copyWith(isProcessing: false);
      }
    } catch (e) {
      state = state.copyWith(isProcessing: false, errorMessage: e.toString());
    }
  }

  /// フラッシュモードを切り替える
  Future<void> toggleFlash() async {
    if (!state.isCameraInitialized) return;

    final newMode = switch (state.flashMode) {
      FlashMode.off => FlashMode.auto,
      FlashMode.auto => FlashMode.torch,
      FlashMode.torch => FlashMode.off,
      _ => FlashMode.off,
    };

    try {
      await _cameraController!.setFlashMode(newMode);
      state = state.copyWith(flashMode: newMode);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  /// 撮影/選択された画像を処理する（バックエンド処理の起点）
  Future<void> _processImage(XFile image) async {
    try {
      await _loadCategories();
      final categories = getCategories();

      final categoryNames = categories
          .where((c) => c != null)
          .map((c) => c.categoryName)
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toSet() // 重複排除
          .toList();

      if (!categoryNames.contains(' ')) {
        categoryNames.add(' ');
      }

      // 2. 作成したサービスクラスを呼び出す
      final analysisService = ref.read(receiptAnalysisServiceProvider);
      final ReceiptAnalysisResponse result =
          await analysisService.analyzeReceiptImage(
        imageFile: image,
        availableCategories: categoryNames,
      );

      final categoryEntities = getCategories();

      final updatedItems = result.items.map((item) {
        final matched = categoryEntities
            .where((c) => c != null && c.categoryName == item.category)
            .firstOrNull;

        return item.copyWith(
          categoryDto: matched != null ? CategoryDto.fromEntity(matched) : null,
        );
      }).toList();

      final updatedResult = result.copyWith(items: updatedItems);

      print('--- ViewModelが受け取った結果 ---');
      print('ステータス: ${result.status}');

      // 4. UIの状態を更新
      ref.read(transactionProvider.notifier).setScannedData(updatedResult);
      state = state.copyWith(isProcessing: false);
    } catch (e) {
      print('ViewModel Error: $e');
      state = state.copyWith(
          isProcessing: false, errorMessage: 'エラーが発生しました\nもう一度お試しください');
    }
  }

  void updateTransaction(ReceiptItem updatedItem) {
    // 1. 現在のstateからscannedDataを取得
    final currentScannedData =
        ref.read(transactionProvider.notifier).getScannedData();

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

      return true; // 成功
    } catch (e) {
      // エラーログなどを記録
      print('Failed to save transactions: $e');
      return false; // 失敗
    }
  }

  Future<void> _loadCategories() async {
    // すでにデータがあるか、読み込み中なら何もしない
    if (state.categories.isNotEmpty) return;

    final DatabaseService _databaseService = DatabaseService.instance;
    try {
      final categoriesData = await _databaseService.getAllCategories();
      state = state.copyWith(categories: categoriesData);
    } catch (e) {
      state = state.copyWith(categories: []);
    }
    print("カテゴリー: ${state.categories.map((c) => '${c.categoryName},')}");
  }

  List<Category> getCategories() {
    return state.categories;
  }
}
