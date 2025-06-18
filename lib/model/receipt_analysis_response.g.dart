// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_analysis_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReceiptAnalysisResponseImpl _$$ReceiptAnalysisResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ReceiptAnalysisResponseImpl(
      status: (json['status'] as num).toInt(),
      date: json['date'] as String?,
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => ReceiptItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ReceiptAnalysisResponseImplToJson(
        _$ReceiptAnalysisResponseImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'date': instance.date,
      'items': instance.items,
    };

_$ReceiptItemImpl _$$ReceiptItemImplFromJson(Map<String, dynamic> json) =>
    _$ReceiptItemImpl(
      id: _idFromJson(json['id']),
      name: json['name'] as String? ?? '不明',
      price: (json['price'] as num?)?.toInt() ?? 0,
      category: json['category'] as String? ?? 'なし',
      categoryDto: json['categoryDto'] == null
          ? null
          : CategoryDto.fromJson(json['categoryDto'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ReceiptItemImplToJson(_$ReceiptItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'category': instance.category,
      'categoryDto': instance.categoryDto,
    };
