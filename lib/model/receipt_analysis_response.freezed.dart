// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'receipt_analysis_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReceiptAnalysisResponse _$ReceiptAnalysisResponseFromJson(
    Map<String, dynamic> json) {
  return _ReceiptAnalysisResponse.fromJson(json);
}

/// @nodoc
mixin _$ReceiptAnalysisResponse {
  int get status => throw _privateConstructorUsedError;
  String? get date => throw _privateConstructorUsedError;
  List<ReceiptItem> get items => throw _privateConstructorUsedError;

  /// Serializes this ReceiptAnalysisResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReceiptAnalysisResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReceiptAnalysisResponseCopyWith<ReceiptAnalysisResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReceiptAnalysisResponseCopyWith<$Res> {
  factory $ReceiptAnalysisResponseCopyWith(ReceiptAnalysisResponse value,
          $Res Function(ReceiptAnalysisResponse) then) =
      _$ReceiptAnalysisResponseCopyWithImpl<$Res, ReceiptAnalysisResponse>;
  @useResult
  $Res call({int status, String? date, List<ReceiptItem> items});
}

/// @nodoc
class _$ReceiptAnalysisResponseCopyWithImpl<$Res,
        $Val extends ReceiptAnalysisResponse>
    implements $ReceiptAnalysisResponseCopyWith<$Res> {
  _$ReceiptAnalysisResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReceiptAnalysisResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? date = freezed,
    Object? items = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ReceiptItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReceiptAnalysisResponseImplCopyWith<$Res>
    implements $ReceiptAnalysisResponseCopyWith<$Res> {
  factory _$$ReceiptAnalysisResponseImplCopyWith(
          _$ReceiptAnalysisResponseImpl value,
          $Res Function(_$ReceiptAnalysisResponseImpl) then) =
      __$$ReceiptAnalysisResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int status, String? date, List<ReceiptItem> items});
}

/// @nodoc
class __$$ReceiptAnalysisResponseImplCopyWithImpl<$Res>
    extends _$ReceiptAnalysisResponseCopyWithImpl<$Res,
        _$ReceiptAnalysisResponseImpl>
    implements _$$ReceiptAnalysisResponseImplCopyWith<$Res> {
  __$$ReceiptAnalysisResponseImplCopyWithImpl(
      _$ReceiptAnalysisResponseImpl _value,
      $Res Function(_$ReceiptAnalysisResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReceiptAnalysisResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? date = freezed,
    Object? items = null,
  }) {
    return _then(_$ReceiptAnalysisResponseImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ReceiptItem>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReceiptAnalysisResponseImpl implements _ReceiptAnalysisResponse {
  const _$ReceiptAnalysisResponseImpl(
      {required this.status,
      this.date,
      final List<ReceiptItem> items = const []})
      : _items = items;

  factory _$ReceiptAnalysisResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReceiptAnalysisResponseImplFromJson(json);

  @override
  final int status;
  @override
  final String? date;
  final List<ReceiptItem> _items;
  @override
  @JsonKey()
  List<ReceiptItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'ReceiptAnalysisResponse(status: $status, date: $date, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReceiptAnalysisResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, status, date, const DeepCollectionEquality().hash(_items));

  /// Create a copy of ReceiptAnalysisResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReceiptAnalysisResponseImplCopyWith<_$ReceiptAnalysisResponseImpl>
      get copyWith => __$$ReceiptAnalysisResponseImplCopyWithImpl<
          _$ReceiptAnalysisResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReceiptAnalysisResponseImplToJson(
      this,
    );
  }
}

abstract class _ReceiptAnalysisResponse implements ReceiptAnalysisResponse {
  const factory _ReceiptAnalysisResponse(
      {required final int status,
      final String? date,
      final List<ReceiptItem> items}) = _$ReceiptAnalysisResponseImpl;

  factory _ReceiptAnalysisResponse.fromJson(Map<String, dynamic> json) =
      _$ReceiptAnalysisResponseImpl.fromJson;

  @override
  int get status;
  @override
  String? get date;
  @override
  List<ReceiptItem> get items;

  /// Create a copy of ReceiptAnalysisResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReceiptAnalysisResponseImplCopyWith<_$ReceiptAnalysisResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ReceiptItem _$ReceiptItemFromJson(Map<String, dynamic> json) {
  return _ReceiptItem.fromJson(json);
}

/// @nodoc
mixin _$ReceiptItem {
// ★ 2. idフィールドに@JsonKeyを追加し、先ほどの関数を指定
  @JsonKey(fromJson: _idFromJson)
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  CategoryDto? get categoryDto => throw _privateConstructorUsedError;

  /// Serializes this ReceiptItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReceiptItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReceiptItemCopyWith<ReceiptItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReceiptItemCopyWith<$Res> {
  factory $ReceiptItemCopyWith(
          ReceiptItem value, $Res Function(ReceiptItem) then) =
      _$ReceiptItemCopyWithImpl<$Res, ReceiptItem>;
  @useResult
  $Res call(
      {@JsonKey(fromJson: _idFromJson) String id,
      String name,
      int price,
      String category,
      CategoryDto? categoryDto});
}

/// @nodoc
class _$ReceiptItemCopyWithImpl<$Res, $Val extends ReceiptItem>
    implements $ReceiptItemCopyWith<$Res> {
  _$ReceiptItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReceiptItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? price = null,
    Object? category = null,
    Object? categoryDto = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      categoryDto: freezed == categoryDto
          ? _value.categoryDto
          : categoryDto // ignore: cast_nullable_to_non_nullable
              as CategoryDto?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReceiptItemImplCopyWith<$Res>
    implements $ReceiptItemCopyWith<$Res> {
  factory _$$ReceiptItemImplCopyWith(
          _$ReceiptItemImpl value, $Res Function(_$ReceiptItemImpl) then) =
      __$$ReceiptItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(fromJson: _idFromJson) String id,
      String name,
      int price,
      String category,
      CategoryDto? categoryDto});
}

/// @nodoc
class __$$ReceiptItemImplCopyWithImpl<$Res>
    extends _$ReceiptItemCopyWithImpl<$Res, _$ReceiptItemImpl>
    implements _$$ReceiptItemImplCopyWith<$Res> {
  __$$ReceiptItemImplCopyWithImpl(
      _$ReceiptItemImpl _value, $Res Function(_$ReceiptItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReceiptItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? price = null,
    Object? category = null,
    Object? categoryDto = freezed,
  }) {
    return _then(_$ReceiptItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      categoryDto: freezed == categoryDto
          ? _value.categoryDto
          : categoryDto // ignore: cast_nullable_to_non_nullable
              as CategoryDto?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReceiptItemImpl implements _ReceiptItem {
  const _$ReceiptItemImpl(
      {@JsonKey(fromJson: _idFromJson) required this.id,
      this.name = '不明',
      this.price = 0,
      this.category = 'なし',
      this.categoryDto});

  factory _$ReceiptItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReceiptItemImplFromJson(json);

// ★ 2. idフィールドに@JsonKeyを追加し、先ほどの関数を指定
  @override
  @JsonKey(fromJson: _idFromJson)
  final String id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final int price;
  @override
  @JsonKey()
  final String category;
  @override
  final CategoryDto? categoryDto;

  @override
  String toString() {
    return 'ReceiptItem(id: $id, name: $name, price: $price, category: $category, categoryDto: $categoryDto)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReceiptItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.categoryDto, categoryDto) ||
                other.categoryDto == categoryDto));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, price, category, categoryDto);

  /// Create a copy of ReceiptItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReceiptItemImplCopyWith<_$ReceiptItemImpl> get copyWith =>
      __$$ReceiptItemImplCopyWithImpl<_$ReceiptItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReceiptItemImplToJson(
      this,
    );
  }
}

abstract class _ReceiptItem implements ReceiptItem {
  const factory _ReceiptItem(
      {@JsonKey(fromJson: _idFromJson) required final String id,
      final String name,
      final int price,
      final String category,
      final CategoryDto? categoryDto}) = _$ReceiptItemImpl;

  factory _ReceiptItem.fromJson(Map<String, dynamic> json) =
      _$ReceiptItemImpl.fromJson;

// ★ 2. idフィールドに@JsonKeyを追加し、先ほどの関数を指定
  @override
  @JsonKey(fromJson: _idFromJson)
  String get id;
  @override
  String get name;
  @override
  int get price;
  @override
  String get category;
  @override
  CategoryDto? get categoryDto;

  /// Create a copy of ReceiptItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReceiptItemImplCopyWith<_$ReceiptItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
