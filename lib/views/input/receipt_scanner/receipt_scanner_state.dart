import 'package:budget/data/local/app_database.dart';
import 'package:budget/model/receipt_analysis_response.dart';
import 'package:camera/camera.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'receipt_scanner_state.freezed.dart';

@freezed
class ReceiptScannerState with _$ReceiptScannerState {
  const factory ReceiptScannerState({
    // カメラが初期化されたか
    @Default(false) bool isCameraInitialized,
    // 現在のフラッシュモード
    @Default(FlashMode.off) FlashMode flashMode,
    // 読み取り/処理中か
    @Default(false) bool isProcessing,
    // エラーメッセージ
    String? errorMessage,
    @Default([]) List<Category> categories,
  }) = _ReceiptScannerState;
}
