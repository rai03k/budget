// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_create_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CategoryCreateState {
  int get id => throw _privateConstructorUsedError;
  String get categoryName => throw _privateConstructorUsedError;
  CategoryIcons get selectedIcon => throw _privateConstructorUsedError;
  AppColors get selectedColor => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of CategoryCreateState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CategoryCreateStateCopyWith<CategoryCreateState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryCreateStateCopyWith<$Res> {
  factory $CategoryCreateStateCopyWith(
          CategoryCreateState value, $Res Function(CategoryCreateState) then) =
      _$CategoryCreateStateCopyWithImpl<$Res, CategoryCreateState>;
  @useResult
  $Res call(
      {int id,
      String categoryName,
      CategoryIcons selectedIcon,
      AppColors selectedColor,
      bool isLoading,
      String errorMessage});
}

/// @nodoc
class _$CategoryCreateStateCopyWithImpl<$Res, $Val extends CategoryCreateState>
    implements $CategoryCreateStateCopyWith<$Res> {
  _$CategoryCreateStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CategoryCreateState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? categoryName = null,
    Object? selectedIcon = null,
    Object? selectedColor = null,
    Object? isLoading = null,
    Object? errorMessage = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      categoryName: null == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String,
      selectedIcon: null == selectedIcon
          ? _value.selectedIcon
          : selectedIcon // ignore: cast_nullable_to_non_nullable
              as CategoryIcons,
      selectedColor: null == selectedColor
          ? _value.selectedColor
          : selectedColor // ignore: cast_nullable_to_non_nullable
              as AppColors,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CategoryCreateStateImplCopyWith<$Res>
    implements $CategoryCreateStateCopyWith<$Res> {
  factory _$$CategoryCreateStateImplCopyWith(_$CategoryCreateStateImpl value,
          $Res Function(_$CategoryCreateStateImpl) then) =
      __$$CategoryCreateStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String categoryName,
      CategoryIcons selectedIcon,
      AppColors selectedColor,
      bool isLoading,
      String errorMessage});
}

/// @nodoc
class __$$CategoryCreateStateImplCopyWithImpl<$Res>
    extends _$CategoryCreateStateCopyWithImpl<$Res, _$CategoryCreateStateImpl>
    implements _$$CategoryCreateStateImplCopyWith<$Res> {
  __$$CategoryCreateStateImplCopyWithImpl(_$CategoryCreateStateImpl _value,
      $Res Function(_$CategoryCreateStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CategoryCreateState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? categoryName = null,
    Object? selectedIcon = null,
    Object? selectedColor = null,
    Object? isLoading = null,
    Object? errorMessage = null,
  }) {
    return _then(_$CategoryCreateStateImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      categoryName: null == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String,
      selectedIcon: null == selectedIcon
          ? _value.selectedIcon
          : selectedIcon // ignore: cast_nullable_to_non_nullable
              as CategoryIcons,
      selectedColor: null == selectedColor
          ? _value.selectedColor
          : selectedColor // ignore: cast_nullable_to_non_nullable
              as AppColors,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CategoryCreateStateImpl implements _CategoryCreateState {
  const _$CategoryCreateStateImpl(
      {this.id = 0,
      this.categoryName = '',
      this.selectedIcon = CategoryIcons.restaurant,
      this.selectedColor = AppColors.red,
      this.isLoading = false,
      this.errorMessage = ''});

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String categoryName;
  @override
  @JsonKey()
  final CategoryIcons selectedIcon;
  @override
  @JsonKey()
  final AppColors selectedColor;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final String errorMessage;

  @override
  String toString() {
    return 'CategoryCreateState(id: $id, categoryName: $categoryName, selectedIcon: $selectedIcon, selectedColor: $selectedColor, isLoading: $isLoading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryCreateStateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.selectedIcon, selectedIcon) ||
                other.selectedIcon == selectedIcon) &&
            (identical(other.selectedColor, selectedColor) ||
                other.selectedColor == selectedColor) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, categoryName, selectedIcon,
      selectedColor, isLoading, errorMessage);

  /// Create a copy of CategoryCreateState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryCreateStateImplCopyWith<_$CategoryCreateStateImpl> get copyWith =>
      __$$CategoryCreateStateImplCopyWithImpl<_$CategoryCreateStateImpl>(
          this, _$identity);
}

abstract class _CategoryCreateState implements CategoryCreateState {
  const factory _CategoryCreateState(
      {final int id,
      final String categoryName,
      final CategoryIcons selectedIcon,
      final AppColors selectedColor,
      final bool isLoading,
      final String errorMessage}) = _$CategoryCreateStateImpl;

  @override
  int get id;
  @override
  String get categoryName;
  @override
  CategoryIcons get selectedIcon;
  @override
  AppColors get selectedColor;
  @override
  bool get isLoading;
  @override
  String get errorMessage;

  /// Create a copy of CategoryCreateState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategoryCreateStateImplCopyWith<_$CategoryCreateStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
