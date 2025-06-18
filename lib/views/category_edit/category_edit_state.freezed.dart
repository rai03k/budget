// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_edit_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CategoryEditState {
  int get id => throw _privateConstructorUsedError;
  String get categoryName => throw _privateConstructorUsedError;
  CategoryIcons get selectedIcon => throw _privateConstructorUsedError;
  AppColors get selectedColor => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of CategoryEditState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CategoryEditStateCopyWith<CategoryEditState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryEditStateCopyWith<$Res> {
  factory $CategoryEditStateCopyWith(
          CategoryEditState value, $Res Function(CategoryEditState) then) =
      _$CategoryEditStateCopyWithImpl<$Res, CategoryEditState>;
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
class _$CategoryEditStateCopyWithImpl<$Res, $Val extends CategoryEditState>
    implements $CategoryEditStateCopyWith<$Res> {
  _$CategoryEditStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CategoryEditState
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
abstract class _$$CategoryEditStateImplCopyWith<$Res>
    implements $CategoryEditStateCopyWith<$Res> {
  factory _$$CategoryEditStateImplCopyWith(_$CategoryEditStateImpl value,
          $Res Function(_$CategoryEditStateImpl) then) =
      __$$CategoryEditStateImplCopyWithImpl<$Res>;
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
class __$$CategoryEditStateImplCopyWithImpl<$Res>
    extends _$CategoryEditStateCopyWithImpl<$Res, _$CategoryEditStateImpl>
    implements _$$CategoryEditStateImplCopyWith<$Res> {
  __$$CategoryEditStateImplCopyWithImpl(_$CategoryEditStateImpl _value,
      $Res Function(_$CategoryEditStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CategoryEditState
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
    return _then(_$CategoryEditStateImpl(
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

class _$CategoryEditStateImpl implements _CategoryEditState {
  const _$CategoryEditStateImpl(
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
    return 'CategoryEditState(id: $id, categoryName: $categoryName, selectedIcon: $selectedIcon, selectedColor: $selectedColor, isLoading: $isLoading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryEditStateImpl &&
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

  /// Create a copy of CategoryEditState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryEditStateImplCopyWith<_$CategoryEditStateImpl> get copyWith =>
      __$$CategoryEditStateImplCopyWithImpl<_$CategoryEditStateImpl>(
          this, _$identity);
}

abstract class _CategoryEditState implements CategoryEditState {
  const factory _CategoryEditState(
      {final int id,
      final String categoryName,
      final CategoryIcons selectedIcon,
      final AppColors selectedColor,
      final bool isLoading,
      final String errorMessage}) = _$CategoryEditStateImpl;

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

  /// Create a copy of CategoryEditState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategoryEditStateImplCopyWith<_$CategoryEditStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
