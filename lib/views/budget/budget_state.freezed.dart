// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'budget_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BudgetPageState {
  bool get isEditing => throw _privateConstructorUsedError;
  List<CategoryState> get categories => throw _privateConstructorUsedError;
  List<BudgetState> get budgets => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of BudgetPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BudgetPageStateCopyWith<BudgetPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BudgetPageStateCopyWith<$Res> {
  factory $BudgetPageStateCopyWith(
          BudgetPageState value, $Res Function(BudgetPageState) then) =
      _$BudgetPageStateCopyWithImpl<$Res, BudgetPageState>;
  @useResult
  $Res call(
      {bool isEditing,
      List<CategoryState> categories,
      List<BudgetState> budgets,
      bool isLoading,
      String? errorMessage});
}

/// @nodoc
class _$BudgetPageStateCopyWithImpl<$Res, $Val extends BudgetPageState>
    implements $BudgetPageStateCopyWith<$Res> {
  _$BudgetPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BudgetPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isEditing = null,
    Object? categories = null,
    Object? budgets = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      isEditing: null == isEditing
          ? _value.isEditing
          : isEditing // ignore: cast_nullable_to_non_nullable
              as bool,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryState>,
      budgets: null == budgets
          ? _value.budgets
          : budgets // ignore: cast_nullable_to_non_nullable
              as List<BudgetState>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BudgetPageStateImplCopyWith<$Res>
    implements $BudgetPageStateCopyWith<$Res> {
  factory _$$BudgetPageStateImplCopyWith(_$BudgetPageStateImpl value,
          $Res Function(_$BudgetPageStateImpl) then) =
      __$$BudgetPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isEditing,
      List<CategoryState> categories,
      List<BudgetState> budgets,
      bool isLoading,
      String? errorMessage});
}

/// @nodoc
class __$$BudgetPageStateImplCopyWithImpl<$Res>
    extends _$BudgetPageStateCopyWithImpl<$Res, _$BudgetPageStateImpl>
    implements _$$BudgetPageStateImplCopyWith<$Res> {
  __$$BudgetPageStateImplCopyWithImpl(
      _$BudgetPageStateImpl _value, $Res Function(_$BudgetPageStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of BudgetPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isEditing = null,
    Object? categories = null,
    Object? budgets = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$BudgetPageStateImpl(
      isEditing: null == isEditing
          ? _value.isEditing
          : isEditing // ignore: cast_nullable_to_non_nullable
              as bool,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryState>,
      budgets: null == budgets
          ? _value._budgets
          : budgets // ignore: cast_nullable_to_non_nullable
              as List<BudgetState>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$BudgetPageStateImpl implements _BudgetPageState {
  const _$BudgetPageStateImpl(
      {this.isEditing = false,
      final List<CategoryState> categories = const [],
      final List<BudgetState> budgets = const [],
      this.isLoading = false,
      this.errorMessage})
      : _categories = categories,
        _budgets = budgets;

  @override
  @JsonKey()
  final bool isEditing;
  final List<CategoryState> _categories;
  @override
  @JsonKey()
  List<CategoryState> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  final List<BudgetState> _budgets;
  @override
  @JsonKey()
  List<BudgetState> get budgets {
    if (_budgets is EqualUnmodifiableListView) return _budgets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_budgets);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'BudgetPageState(isEditing: $isEditing, categories: $categories, budgets: $budgets, isLoading: $isLoading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BudgetPageStateImpl &&
            (identical(other.isEditing, isEditing) ||
                other.isEditing == isEditing) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality().equals(other._budgets, _budgets) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isEditing,
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(_budgets),
      isLoading,
      errorMessage);

  /// Create a copy of BudgetPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BudgetPageStateImplCopyWith<_$BudgetPageStateImpl> get copyWith =>
      __$$BudgetPageStateImplCopyWithImpl<_$BudgetPageStateImpl>(
          this, _$identity);
}

abstract class _BudgetPageState implements BudgetPageState {
  const factory _BudgetPageState(
      {final bool isEditing,
      final List<CategoryState> categories,
      final List<BudgetState> budgets,
      final bool isLoading,
      final String? errorMessage}) = _$BudgetPageStateImpl;

  @override
  bool get isEditing;
  @override
  List<CategoryState> get categories;
  @override
  List<BudgetState> get budgets;
  @override
  bool get isLoading;
  @override
  String? get errorMessage;

  /// Create a copy of BudgetPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BudgetPageStateImplCopyWith<_$BudgetPageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
