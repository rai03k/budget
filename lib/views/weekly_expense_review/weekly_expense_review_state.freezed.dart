// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weekly_expense_review_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ExpenseItem {
  String get title => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError; // Driftのintに合わせる
  DateTime get date => throw _privateConstructorUsedError;
  bool get isDismissed => throw _privateConstructorUsedError;
  String get emoji => throw _privateConstructorUsedError;

  /// Create a copy of ExpenseItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExpenseItemCopyWith<ExpenseItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseItemCopyWith<$Res> {
  factory $ExpenseItemCopyWith(
          ExpenseItem value, $Res Function(ExpenseItem) then) =
      _$ExpenseItemCopyWithImpl<$Res, ExpenseItem>;
  @useResult
  $Res call(
      {String title,
      int amount,
      DateTime date,
      bool isDismissed,
      String emoji});
}

/// @nodoc
class _$ExpenseItemCopyWithImpl<$Res, $Val extends ExpenseItem>
    implements $ExpenseItemCopyWith<$Res> {
  _$ExpenseItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExpenseItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? amount = null,
    Object? date = null,
    Object? isDismissed = null,
    Object? emoji = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isDismissed: null == isDismissed
          ? _value.isDismissed
          : isDismissed // ignore: cast_nullable_to_non_nullable
              as bool,
      emoji: null == emoji
          ? _value.emoji
          : emoji // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExpenseItemImplCopyWith<$Res>
    implements $ExpenseItemCopyWith<$Res> {
  factory _$$ExpenseItemImplCopyWith(
          _$ExpenseItemImpl value, $Res Function(_$ExpenseItemImpl) then) =
      __$$ExpenseItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      int amount,
      DateTime date,
      bool isDismissed,
      String emoji});
}

/// @nodoc
class __$$ExpenseItemImplCopyWithImpl<$Res>
    extends _$ExpenseItemCopyWithImpl<$Res, _$ExpenseItemImpl>
    implements _$$ExpenseItemImplCopyWith<$Res> {
  __$$ExpenseItemImplCopyWithImpl(
      _$ExpenseItemImpl _value, $Res Function(_$ExpenseItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExpenseItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? amount = null,
    Object? date = null,
    Object? isDismissed = null,
    Object? emoji = null,
  }) {
    return _then(_$ExpenseItemImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isDismissed: null == isDismissed
          ? _value.isDismissed
          : isDismissed // ignore: cast_nullable_to_non_nullable
              as bool,
      emoji: null == emoji
          ? _value.emoji
          : emoji // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ExpenseItemImpl implements _ExpenseItem {
  const _$ExpenseItemImpl(
      {required this.title,
      required this.amount,
      required this.date,
      this.isDismissed = false,
      this.emoji = '🍫'});

  @override
  final String title;
  @override
  final int amount;
// Driftのintに合わせる
  @override
  final DateTime date;
  @override
  @JsonKey()
  final bool isDismissed;
  @override
  @JsonKey()
  final String emoji;

  @override
  String toString() {
    return 'ExpenseItem(title: $title, amount: $amount, date: $date, isDismissed: $isDismissed, emoji: $emoji)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpenseItemImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.isDismissed, isDismissed) ||
                other.isDismissed == isDismissed) &&
            (identical(other.emoji, emoji) || other.emoji == emoji));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, title, amount, date, isDismissed, emoji);

  /// Create a copy of ExpenseItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpenseItemImplCopyWith<_$ExpenseItemImpl> get copyWith =>
      __$$ExpenseItemImplCopyWithImpl<_$ExpenseItemImpl>(this, _$identity);
}

abstract class _ExpenseItem implements ExpenseItem {
  const factory _ExpenseItem(
      {required final String title,
      required final int amount,
      required final DateTime date,
      final bool isDismissed,
      final String emoji}) = _$ExpenseItemImpl;

  @override
  String get title;
  @override
  int get amount; // Driftのintに合わせる
  @override
  DateTime get date;
  @override
  bool get isDismissed;
  @override
  String get emoji;

  /// Create a copy of ExpenseItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExpenseItemImplCopyWith<_$ExpenseItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$WeeklyExpenseReviewState {
  List<ExpenseItem> get items => throw _privateConstructorUsedError;
  List<String> get dismissedEmojis => throw _privateConstructorUsedError;
  int get dismissedTotal =>
      throw _privateConstructorUsedError; // Driftのintに合わせる
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of WeeklyExpenseReviewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WeeklyExpenseReviewStateCopyWith<WeeklyExpenseReviewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeeklyExpenseReviewStateCopyWith<$Res> {
  factory $WeeklyExpenseReviewStateCopyWith(WeeklyExpenseReviewState value,
          $Res Function(WeeklyExpenseReviewState) then) =
      _$WeeklyExpenseReviewStateCopyWithImpl<$Res, WeeklyExpenseReviewState>;
  @useResult
  $Res call(
      {List<ExpenseItem> items,
      List<String> dismissedEmojis,
      int dismissedTotal,
      bool isLoading,
      String? errorMessage});
}

/// @nodoc
class _$WeeklyExpenseReviewStateCopyWithImpl<$Res,
        $Val extends WeeklyExpenseReviewState>
    implements $WeeklyExpenseReviewStateCopyWith<$Res> {
  _$WeeklyExpenseReviewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WeeklyExpenseReviewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? dismissedEmojis = null,
    Object? dismissedTotal = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ExpenseItem>,
      dismissedEmojis: null == dismissedEmojis
          ? _value.dismissedEmojis
          : dismissedEmojis // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dismissedTotal: null == dismissedTotal
          ? _value.dismissedTotal
          : dismissedTotal // ignore: cast_nullable_to_non_nullable
              as int,
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
abstract class _$$WeeklyExpenseReviewStateImplCopyWith<$Res>
    implements $WeeklyExpenseReviewStateCopyWith<$Res> {
  factory _$$WeeklyExpenseReviewStateImplCopyWith(
          _$WeeklyExpenseReviewStateImpl value,
          $Res Function(_$WeeklyExpenseReviewStateImpl) then) =
      __$$WeeklyExpenseReviewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ExpenseItem> items,
      List<String> dismissedEmojis,
      int dismissedTotal,
      bool isLoading,
      String? errorMessage});
}

/// @nodoc
class __$$WeeklyExpenseReviewStateImplCopyWithImpl<$Res>
    extends _$WeeklyExpenseReviewStateCopyWithImpl<$Res,
        _$WeeklyExpenseReviewStateImpl>
    implements _$$WeeklyExpenseReviewStateImplCopyWith<$Res> {
  __$$WeeklyExpenseReviewStateImplCopyWithImpl(
      _$WeeklyExpenseReviewStateImpl _value,
      $Res Function(_$WeeklyExpenseReviewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of WeeklyExpenseReviewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? dismissedEmojis = null,
    Object? dismissedTotal = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$WeeklyExpenseReviewStateImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ExpenseItem>,
      dismissedEmojis: null == dismissedEmojis
          ? _value._dismissedEmojis
          : dismissedEmojis // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dismissedTotal: null == dismissedTotal
          ? _value.dismissedTotal
          : dismissedTotal // ignore: cast_nullable_to_non_nullable
              as int,
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

class _$WeeklyExpenseReviewStateImpl extends _WeeklyExpenseReviewState {
  const _$WeeklyExpenseReviewStateImpl(
      {final List<ExpenseItem> items = const [],
      final List<String> dismissedEmojis = const [],
      this.dismissedTotal = 0,
      this.isLoading = false,
      this.errorMessage})
      : _items = items,
        _dismissedEmojis = dismissedEmojis,
        super._();

  final List<ExpenseItem> _items;
  @override
  @JsonKey()
  List<ExpenseItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  final List<String> _dismissedEmojis;
  @override
  @JsonKey()
  List<String> get dismissedEmojis {
    if (_dismissedEmojis is EqualUnmodifiableListView) return _dismissedEmojis;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dismissedEmojis);
  }

  @override
  @JsonKey()
  final int dismissedTotal;
// Driftのintに合わせる
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'WeeklyExpenseReviewState(items: $items, dismissedEmojis: $dismissedEmojis, dismissedTotal: $dismissedTotal, isLoading: $isLoading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeeklyExpenseReviewStateImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            const DeepCollectionEquality()
                .equals(other._dismissedEmojis, _dismissedEmojis) &&
            (identical(other.dismissedTotal, dismissedTotal) ||
                other.dismissedTotal == dismissedTotal) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      const DeepCollectionEquality().hash(_dismissedEmojis),
      dismissedTotal,
      isLoading,
      errorMessage);

  /// Create a copy of WeeklyExpenseReviewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WeeklyExpenseReviewStateImplCopyWith<_$WeeklyExpenseReviewStateImpl>
      get copyWith => __$$WeeklyExpenseReviewStateImplCopyWithImpl<
          _$WeeklyExpenseReviewStateImpl>(this, _$identity);
}

abstract class _WeeklyExpenseReviewState extends WeeklyExpenseReviewState {
  const factory _WeeklyExpenseReviewState(
      {final List<ExpenseItem> items,
      final List<String> dismissedEmojis,
      final int dismissedTotal,
      final bool isLoading,
      final String? errorMessage}) = _$WeeklyExpenseReviewStateImpl;
  const _WeeklyExpenseReviewState._() : super._();

  @override
  List<ExpenseItem> get items;
  @override
  List<String> get dismissedEmojis;
  @override
  int get dismissedTotal; // Driftのintに合わせる
  @override
  bool get isLoading;
  @override
  String? get errorMessage;

  /// Create a copy of WeeklyExpenseReviewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WeeklyExpenseReviewStateImplCopyWith<_$WeeklyExpenseReviewStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
