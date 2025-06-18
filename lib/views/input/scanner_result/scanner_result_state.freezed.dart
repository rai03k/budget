// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scanner_result_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ScannerResultState {
  List<Category> get categories => throw _privateConstructorUsedError;

  /// Create a copy of ScannerResultState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScannerResultStateCopyWith<ScannerResultState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScannerResultStateCopyWith<$Res> {
  factory $ScannerResultStateCopyWith(
          ScannerResultState value, $Res Function(ScannerResultState) then) =
      _$ScannerResultStateCopyWithImpl<$Res, ScannerResultState>;
  @useResult
  $Res call({List<Category> categories});
}

/// @nodoc
class _$ScannerResultStateCopyWithImpl<$Res, $Val extends ScannerResultState>
    implements $ScannerResultStateCopyWith<$Res> {
  _$ScannerResultStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScannerResultState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = null,
  }) {
    return _then(_value.copyWith(
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<Category>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScannerResultStateImplCopyWith<$Res>
    implements $ScannerResultStateCopyWith<$Res> {
  factory _$$ScannerResultStateImplCopyWith(_$ScannerResultStateImpl value,
          $Res Function(_$ScannerResultStateImpl) then) =
      __$$ScannerResultStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Category> categories});
}

/// @nodoc
class __$$ScannerResultStateImplCopyWithImpl<$Res>
    extends _$ScannerResultStateCopyWithImpl<$Res, _$ScannerResultStateImpl>
    implements _$$ScannerResultStateImplCopyWith<$Res> {
  __$$ScannerResultStateImplCopyWithImpl(_$ScannerResultStateImpl _value,
      $Res Function(_$ScannerResultStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ScannerResultState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = null,
  }) {
    return _then(_$ScannerResultStateImpl(
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<Category>,
    ));
  }
}

/// @nodoc

class _$ScannerResultStateImpl implements _ScannerResultState {
  const _$ScannerResultStateImpl({final List<Category> categories = const []})
      : _categories = categories;

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
    return 'ScannerResultState(categories: $categories)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScannerResultStateImpl &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_categories));

  /// Create a copy of ScannerResultState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScannerResultStateImplCopyWith<_$ScannerResultStateImpl> get copyWith =>
      __$$ScannerResultStateImplCopyWithImpl<_$ScannerResultStateImpl>(
          this, _$identity);
}

abstract class _ScannerResultState implements ScannerResultState {
  const factory _ScannerResultState({final List<Category> categories}) =
      _$ScannerResultStateImpl;

  @override
  List<Category> get categories;

  /// Create a copy of ScannerResultState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScannerResultStateImplCopyWith<_$ScannerResultStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
