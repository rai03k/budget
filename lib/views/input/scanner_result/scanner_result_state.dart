import 'package:budget/data/local/app_database.dart';
import 'package:budget/model/receipt_analysis_response.dart';
import 'package:camera/camera.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'scanner_result_state.freezed.dart';

@freezed
class ScannerResultState with _$ScannerResultState {
  const factory ScannerResultState({
    @Default([]) List<Category> categories,
  }) = _ScannerResultState;
}
