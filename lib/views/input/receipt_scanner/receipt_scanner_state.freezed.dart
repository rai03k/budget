// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'receipt_scanner_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ReceiptScannerState {
// カメラが初期化されたか
  bool get isCameraInitialized =>
      throw _privateConstructorUsedError; // 現在のフラッシュモード
  FlashMode get flashMode => throw _privateConstructorUsedError; // 読み取り/処理中か
  bool get isProcessing => throw _privateConstructorUsedError; // エラーメッセージ
  String? get errorMessage => throw _privateConstructorUsedError;
  List<Category> get categories => throw _privateConstructorUsedError;

  /// Create a copy of ReceiptScannerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReceiptScannerStateCopyWith<ReceiptScannerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReceiptScannerStateCopyWith<$Res> {
  factory $ReceiptScannerStateCopyWith(
          ReceiptScannerState value, $Res Function(ReceiptScannerState) then) =
      _$ReceiptScannerStateCopyWithImpl<$Res, ReceiptScannerState>;
  @useResult
  $Res call(
      {bool isCameraInitialized,
      FlashMode flashMode,
      bool isProcessing,
      String? errorMessage,
      List<Category> categories});
}

/// @nodoc
class _$ReceiptScannerStateCopyWithImpl<$Res, $Val extends ReceiptScannerState>
    implements $ReceiptScannerStateCopyWith<$Res> {
  _$ReceiptScannerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReceiptScannerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isCameraInitialized = null,
    Object? flashMode = null,
    Object? isProcessing = null,
    Object? errorMessage = freezed,
    Object? categories = null,
  }) {
    return _then(_value.copyWith(
      isCameraInitialized: null == isCameraInitialized
          ? _value.isCameraInitialized
          : isCameraInitialized // ignore: cast_nullable_to_non_nullable
              as bool,
      flashMode: null == flashMode
          ? _value.flashMode
          : flashMode // ignore: cast_nullable_to_non_nullable
              as FlashMode,
      isProcessing: null == isProcessing
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<Category>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReceiptScannerStateImplCopyWith<$Res>
    implements $ReceiptScannerStateCopyWith<$Res> {
  factory _$$ReceiptScannerStateImplCopyWith(_$ReceiptScannerStateImpl value,
          $Res Function(_$ReceiptScannerStateImpl) then) =
      __$$ReceiptScannerStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isCameraInitialized,
      FlashMode flashMode,
      bool isProcessing,
      String? errorMessage,
      List<Category> categories});
}

/// @nodoc
class __$$ReceiptScannerStateImplCopyWithImpl<$Res>
    extends _$ReceiptScannerStateCopyWithImpl<$Res, _$ReceiptScannerStateImpl>
    implements _$$ReceiptScannerStateImplCopyWith<$Res> {
  __$$ReceiptScannerStateImplCopyWithImpl(_$ReceiptScannerStateImpl _value,
      $Res Function(_$ReceiptScannerStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReceiptScannerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isCameraInitialized = null,
    Object? flashMode = null,
    Object? isProcessing = null,
    Object? errorMessage = freezed,
    Object? categories = null,
  }) {
    return _then(_$ReceiptScannerStateImpl(
      isCameraInitialized: null == isCameraInitialized
          ? _value.isCameraInitialized
          : isCameraInitialized // ignore: cast_nullable_to_non_nullable
              as bool,
      flashMode: null == flashMode
          ? _value.flashMode
          : flashMode // ignore: cast_nullable_to_non_nullable
              as FlashMode,
      isProcessing: null == isProcessing
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<Category>,
    ));
  }
}

/// @nodoc

class _$ReceiptScannerStateImpl implements _ReceiptScannerState {
  const _$ReceiptScannerStateImpl(
      {this.isCameraInitialized = false,
      this.flashMode = FlashMode.off,
      this.isProcessing = false,
      this.errorMessage,
      final List<Category> categories = const []})
      : _categories = categories;

// カメラが初期化されたか
  @override
  @JsonKey()
  final bool isCameraInitialized;
// 現在のフラッシュモード
  @override
  @JsonKey()
  final FlashMode flashMode;
// 読み取り/処理中か
  @override
  @JsonKey()
  final bool isProcessing;
// エラーメッセージ
  @override
  final String? errorMessage;
  final List<Category> _categories;
  @override
  @JsonKey()
  List<Category> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  String toString() {
    return 'ReceiptScannerState(isCameraInitialized: $isCameraInitialized, flashMode: $flashMode, isProcessing: $isProcessing, errorMessage: $errorMessage, categories: $categories)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReceiptScannerStateImpl &&
            (identical(other.isCameraInitialized, isCameraInitialized) ||
                other.isCameraInitialized == isCameraInitialized) &&
            (identical(other.flashMode, flashMode) ||
                other.flashMode == flashMode) &&
            (identical(other.isProcessing, isProcessing) ||
                other.isProcessing == isProcessing) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isCameraInitialized,
      flashMode,
      isProcessing,
      errorMessage,
      const DeepCollectionEquality().hash(_categories));

  /// Create a copy of ReceiptScannerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReceiptScannerStateImplCopyWith<_$ReceiptScannerStateImpl> get copyWith =>
      __$$ReceiptScannerStateImplCopyWithImpl<_$ReceiptScannerStateImpl>(
          this, _$identity);
}

abstract class _ReceiptScannerState implements ReceiptScannerState {
  const factory _ReceiptScannerState(
      {final bool isCameraInitialized,
      final FlashMode flashMode,
      final bool isProcessing,
      final String? errorMessage,
      final List<Category> categories}) = _$ReceiptScannerStateImpl;

// カメラが初期化されたか
  @override
  bool get isCameraInitialized; // 現在のフラッシュモード
  @override
  FlashMode get flashMode; // 読み取り/処理中か
  @override
  bool get isProcessing; // エラーメッセージ
  @override
  String? get errorMessage;
  @override
  List<Category> get categories;

  /// Create a copy of ReceiptScannerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReceiptScannerStateImplCopyWith<_$ReceiptScannerStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
