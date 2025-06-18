import 'package:budget/model/dto/category_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';

part 'receipt_analysis_response.freezed.dart';
part 'receipt_analysis_response.g.dart';

@freezed
class ReceiptAnalysisResponse with _$ReceiptAnalysisResponse {
  const factory ReceiptAnalysisResponse({
    required int status,
    String? date,
    @Default([]) List<ReceiptItem> items,
  }) = _ReceiptAnalysisResponse;

  factory ReceiptAnalysisResponse.fromJson(Map<String, dynamic> json) =>
      _$ReceiptAnalysisResponseFromJson(json);
}

String _idFromJson(dynamic json) => json as String? ?? const Uuid().v4();

@freezed
class ReceiptItem with _$ReceiptItem {
  const factory ReceiptItem({
    // ★ 2. idフィールドに@JsonKeyを追加し、先ほどの関数を指定
    @JsonKey(fromJson: _idFromJson) required String id,
    @Default('不明') String name,
    @Default(0) int price,
    @Default('なし') String category,
    CategoryDto? categoryDto,
  }) = _ReceiptItem;

  factory ReceiptItem.fromJson(Map<String, dynamic> json) =>
      _$ReceiptItemFromJson(json);
}
