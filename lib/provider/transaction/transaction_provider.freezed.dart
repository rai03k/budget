// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TransactionState {
  ReceiptAnalysisResponse? get scannedData =>
      throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  CategoryState get category => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String get itemName => throw _privateConstructorUsedError;

  /// Create a copy of TransactionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionStateCopyWith<TransactionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionStateCopyWith<$Res> {
  factory $TransactionStateCopyWith(
          TransactionState value, $Res Function(TransactionState) then) =
      _$TransactionStateCopyWithImpl<$Res, TransactionState>;
  @useResult
  $Res call(
      {ReceiptAnalysisResponse? scannedData,
      int id,
      int amount,
      CategoryState category,
      DateTime date,
      String itemName});

  $ReceiptAnalysisResponseCopyWith<$Res>? get scannedData;
  $CategoryStateCopyWith<$Res> get category;
}

/// @nodoc
class _$TransactionStateCopyWithImpl<$Res, $Val extends TransactionState>
    implements $TransactionStateCopyWith<$Res> {
  _$TransactionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scannedData = freezed,
    Object? id = null,
    Object? amount = null,
    Object? category = null,
    Object? date = null,
    Object? itemName = null,
  }) {
    return _then(_value.copyWith(
      scannedData: freezed == scannedData
          ? _value.scannedData
          : scannedData // ignore: cast_nullable_to_non_nullable
              as ReceiptAnalysisResponse?,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CategoryState,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      itemName: null == itemName
          ? _value.itemName
          : itemName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of TransactionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReceiptAnalysisResponseCopyWith<$Res>? get scannedData {
    if (_value.scannedData == null) {
      return null;
    }

    return $ReceiptAnalysisResponseCopyWith<$Res>(_value.scannedData!, (value) {
      return _then(_value.copyWith(scannedData: value) as $Val);
    });
  }

  /// Create a copy of TransactionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CategoryStateCopyWith<$Res> get category {
    return $CategoryStateCopyWith<$Res>(_value.category, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TransactionStateImplCopyWith<$Res>
    implements $TransactionStateCopyWith<$Res> {
  factory _$$TransactionStateImplCopyWith(_$TransactionStateImpl value,
          $Res Function(_$TransactionStateImpl) then) =
      __$$TransactionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ReceiptAnalysisResponse? scannedData,
      int id,
      int amount,
      CategoryState category,
      DateTime date,
      String itemName});

  @override
  $ReceiptAnalysisResponseCopyWith<$Res>? get scannedData;
  @override
  $CategoryStateCopyWith<$Res> get category;
}

/// @nodoc
class __$$TransactionStateImplCopyWithImpl<$Res>
    extends _$TransactionStateCopyWithImpl<$Res, _$TransactionStateImpl>
    implements _$$TransactionStateImplCopyWith<$Res> {
  __$$TransactionStateImplCopyWithImpl(_$TransactionStateImpl _value,
      $Res Function(_$TransactionStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scannedData = freezed,
    Object? id = null,
    Object? amount = null,
    Object? category = null,
    Object? date = null,
    Object? itemName = null,
  }) {
    return _then(_$TransactionStateImpl(
      scannedData: freezed == scannedData
          ? _value.scannedData
          : scannedData // ignore: cast_nullable_to_non_nullable
              as ReceiptAnalysisResponse?,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CategoryState,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      itemName: null == itemName
          ? _value.itemName
          : itemName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TransactionStateImpl implements _TransactionState {
  const _$TransactionStateImpl(
      {this.scannedData,
      required this.id,
      required this.amount,
      required this.category,
      required this.date,
      required this.itemName});

  @override
  final ReceiptAnalysisResponse? scannedData;
  @override
  final int id;
  @override
  final int amount;
  @override
  final CategoryState category;
  @override
  final DateTime date;
  @override
  final String itemName;

  @override
  String toString() {
    return 'TransactionState(scannedData: $scannedData, id: $id, amount: $amount, category: $category, date: $date, itemName: $itemName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionStateImpl &&
            (identical(other.scannedData, scannedData) ||
                other.scannedData == scannedData) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.itemName, itemName) ||
                other.itemName == itemName));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, scannedData, id, amount, category, date, itemName);

  /// Create a copy of TransactionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionStateImplCopyWith<_$TransactionStateImpl> get copyWith =>
      __$$TransactionStateImplCopyWithImpl<_$TransactionStateImpl>(
          this, _$identity);
}

abstract class _TransactionState implements TransactionState {
  const factory _TransactionState(
      {final ReceiptAnalysisResponse? scannedData,
      required final int id,
      required final int amount,
      required final CategoryState category,
      required final DateTime date,
      required final String itemName}) = _$TransactionStateImpl;

  @override
  ReceiptAnalysisResponse? get scannedData;
  @override
  int get id;
  @override
  int get amount;
  @override
  CategoryState get category;
  @override
  DateTime get date;
  @override
  String get itemName;

  /// Create a copy of TransactionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionStateImplCopyWith<_$TransactionStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
