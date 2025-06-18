// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'savings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FallingEmoji {
  String get emoji => throw _privateConstructorUsedError;
  double get startX => throw _privateConstructorUsedError; // 現在のX座標
  double get startY => throw _privateConstructorUsedError; // 現在のY座標
  double get speed => throw _privateConstructorUsedError; // 落下速度
  double get rotationSpeed => throw _privateConstructorUsedError;

  /// Create a copy of FallingEmoji
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FallingEmojiCopyWith<FallingEmoji> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FallingEmojiCopyWith<$Res> {
  factory $FallingEmojiCopyWith(
          FallingEmoji value, $Res Function(FallingEmoji) then) =
      _$FallingEmojiCopyWithImpl<$Res, FallingEmoji>;
  @useResult
  $Res call(
      {String emoji,
      double startX,
      double startY,
      double speed,
      double rotationSpeed});
}

/// @nodoc
class _$FallingEmojiCopyWithImpl<$Res, $Val extends FallingEmoji>
    implements $FallingEmojiCopyWith<$Res> {
  _$FallingEmojiCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FallingEmoji
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emoji = null,
    Object? startX = null,
    Object? startY = null,
    Object? speed = null,
    Object? rotationSpeed = null,
  }) {
    return _then(_value.copyWith(
      emoji: null == emoji
          ? _value.emoji
          : emoji // ignore: cast_nullable_to_non_nullable
              as String,
      startX: null == startX
          ? _value.startX
          : startX // ignore: cast_nullable_to_non_nullable
              as double,
      startY: null == startY
          ? _value.startY
          : startY // ignore: cast_nullable_to_non_nullable
              as double,
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double,
      rotationSpeed: null == rotationSpeed
          ? _value.rotationSpeed
          : rotationSpeed // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FallingEmojiImplCopyWith<$Res>
    implements $FallingEmojiCopyWith<$Res> {
  factory _$$FallingEmojiImplCopyWith(
          _$FallingEmojiImpl value, $Res Function(_$FallingEmojiImpl) then) =
      __$$FallingEmojiImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String emoji,
      double startX,
      double startY,
      double speed,
      double rotationSpeed});
}

/// @nodoc
class __$$FallingEmojiImplCopyWithImpl<$Res>
    extends _$FallingEmojiCopyWithImpl<$Res, _$FallingEmojiImpl>
    implements _$$FallingEmojiImplCopyWith<$Res> {
  __$$FallingEmojiImplCopyWithImpl(
      _$FallingEmojiImpl _value, $Res Function(_$FallingEmojiImpl) _then)
      : super(_value, _then);

  /// Create a copy of FallingEmoji
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emoji = null,
    Object? startX = null,
    Object? startY = null,
    Object? speed = null,
    Object? rotationSpeed = null,
  }) {
    return _then(_$FallingEmojiImpl(
      emoji: null == emoji
          ? _value.emoji
          : emoji // ignore: cast_nullable_to_non_nullable
              as String,
      startX: null == startX
          ? _value.startX
          : startX // ignore: cast_nullable_to_non_nullable
              as double,
      startY: null == startY
          ? _value.startY
          : startY // ignore: cast_nullable_to_non_nullable
              as double,
      speed: null == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double,
      rotationSpeed: null == rotationSpeed
          ? _value.rotationSpeed
          : rotationSpeed // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$FallingEmojiImpl implements _FallingEmoji {
  const _$FallingEmojiImpl(
      {required this.emoji,
      required this.startX,
      required this.startY,
      required this.speed,
      required this.rotationSpeed});

  @override
  final String emoji;
  @override
  final double startX;
// 現在のX座標
  @override
  final double startY;
// 現在のY座標
  @override
  final double speed;
// 落下速度
  @override
  final double rotationSpeed;

  @override
  String toString() {
    return 'FallingEmoji(emoji: $emoji, startX: $startX, startY: $startY, speed: $speed, rotationSpeed: $rotationSpeed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FallingEmojiImpl &&
            (identical(other.emoji, emoji) || other.emoji == emoji) &&
            (identical(other.startX, startX) || other.startX == startX) &&
            (identical(other.startY, startY) || other.startY == startY) &&
            (identical(other.speed, speed) || other.speed == speed) &&
            (identical(other.rotationSpeed, rotationSpeed) ||
                other.rotationSpeed == rotationSpeed));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, emoji, startX, startY, speed, rotationSpeed);

  /// Create a copy of FallingEmoji
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FallingEmojiImplCopyWith<_$FallingEmojiImpl> get copyWith =>
      __$$FallingEmojiImplCopyWithImpl<_$FallingEmojiImpl>(this, _$identity);
}

abstract class _FallingEmoji implements FallingEmoji {
  const factory _FallingEmoji(
      {required final String emoji,
      required final double startX,
      required final double startY,
      required final double speed,
      required final double rotationSpeed}) = _$FallingEmojiImpl;

  @override
  String get emoji;
  @override
  double get startX; // 現在のX座標
  @override
  double get startY; // 現在のY座標
  @override
  double get speed; // 落下速度
  @override
  double get rotationSpeed;

  /// Create a copy of FallingEmoji
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FallingEmojiImplCopyWith<_$FallingEmojiImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SavingsInitParams {
  List<String> get emojis => throw _privateConstructorUsedError; // 表示する絵文字リスト
  double get totalSavings =>
      throw _privateConstructorUsedError; // アニメーションする合計金額
  double get screenWidth =>
      throw _privateConstructorUsedError; // 画面幅 (絵文字の初期位置計算に使用)
  double get screenHeight => throw _privateConstructorUsedError;

  /// Create a copy of SavingsInitParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SavingsInitParamsCopyWith<SavingsInitParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SavingsInitParamsCopyWith<$Res> {
  factory $SavingsInitParamsCopyWith(
          SavingsInitParams value, $Res Function(SavingsInitParams) then) =
      _$SavingsInitParamsCopyWithImpl<$Res, SavingsInitParams>;
  @useResult
  $Res call(
      {List<String> emojis,
      double totalSavings,
      double screenWidth,
      double screenHeight});
}

/// @nodoc
class _$SavingsInitParamsCopyWithImpl<$Res, $Val extends SavingsInitParams>
    implements $SavingsInitParamsCopyWith<$Res> {
  _$SavingsInitParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SavingsInitParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emojis = null,
    Object? totalSavings = null,
    Object? screenWidth = null,
    Object? screenHeight = null,
  }) {
    return _then(_value.copyWith(
      emojis: null == emojis
          ? _value.emojis
          : emojis // ignore: cast_nullable_to_non_nullable
              as List<String>,
      totalSavings: null == totalSavings
          ? _value.totalSavings
          : totalSavings // ignore: cast_nullable_to_non_nullable
              as double,
      screenWidth: null == screenWidth
          ? _value.screenWidth
          : screenWidth // ignore: cast_nullable_to_non_nullable
              as double,
      screenHeight: null == screenHeight
          ? _value.screenHeight
          : screenHeight // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SavingsInitParamsImplCopyWith<$Res>
    implements $SavingsInitParamsCopyWith<$Res> {
  factory _$$SavingsInitParamsImplCopyWith(_$SavingsInitParamsImpl value,
          $Res Function(_$SavingsInitParamsImpl) then) =
      __$$SavingsInitParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> emojis,
      double totalSavings,
      double screenWidth,
      double screenHeight});
}

/// @nodoc
class __$$SavingsInitParamsImplCopyWithImpl<$Res>
    extends _$SavingsInitParamsCopyWithImpl<$Res, _$SavingsInitParamsImpl>
    implements _$$SavingsInitParamsImplCopyWith<$Res> {
  __$$SavingsInitParamsImplCopyWithImpl(_$SavingsInitParamsImpl _value,
      $Res Function(_$SavingsInitParamsImpl) _then)
      : super(_value, _then);

  /// Create a copy of SavingsInitParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emojis = null,
    Object? totalSavings = null,
    Object? screenWidth = null,
    Object? screenHeight = null,
  }) {
    return _then(_$SavingsInitParamsImpl(
      emojis: null == emojis
          ? _value._emojis
          : emojis // ignore: cast_nullable_to_non_nullable
              as List<String>,
      totalSavings: null == totalSavings
          ? _value.totalSavings
          : totalSavings // ignore: cast_nullable_to_non_nullable
              as double,
      screenWidth: null == screenWidth
          ? _value.screenWidth
          : screenWidth // ignore: cast_nullable_to_non_nullable
              as double,
      screenHeight: null == screenHeight
          ? _value.screenHeight
          : screenHeight // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$SavingsInitParamsImpl implements _SavingsInitParams {
  const _$SavingsInitParamsImpl(
      {required final List<String> emojis,
      required this.totalSavings,
      required this.screenWidth,
      required this.screenHeight})
      : _emojis = emojis;

  final List<String> _emojis;
  @override
  List<String> get emojis {
    if (_emojis is EqualUnmodifiableListView) return _emojis;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_emojis);
  }

// 表示する絵文字リスト
  @override
  final double totalSavings;
// アニメーションする合計金額
  @override
  final double screenWidth;
// 画面幅 (絵文字の初期位置計算に使用)
  @override
  final double screenHeight;

  @override
  String toString() {
    return 'SavingsInitParams(emojis: $emojis, totalSavings: $totalSavings, screenWidth: $screenWidth, screenHeight: $screenHeight)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SavingsInitParamsImpl &&
            const DeepCollectionEquality().equals(other._emojis, _emojis) &&
            (identical(other.totalSavings, totalSavings) ||
                other.totalSavings == totalSavings) &&
            (identical(other.screenWidth, screenWidth) ||
                other.screenWidth == screenWidth) &&
            (identical(other.screenHeight, screenHeight) ||
                other.screenHeight == screenHeight));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_emojis),
      totalSavings,
      screenWidth,
      screenHeight);

  /// Create a copy of SavingsInitParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SavingsInitParamsImplCopyWith<_$SavingsInitParamsImpl> get copyWith =>
      __$$SavingsInitParamsImplCopyWithImpl<_$SavingsInitParamsImpl>(
          this, _$identity);
}

abstract class _SavingsInitParams implements SavingsInitParams {
  const factory _SavingsInitParams(
      {required final List<String> emojis,
      required final double totalSavings,
      required final double screenWidth,
      required final double screenHeight}) = _$SavingsInitParamsImpl;

  @override
  List<String> get emojis; // 表示する絵文字リスト
  @override
  double get totalSavings; // アニメーションする合計金額
  @override
  double get screenWidth; // 画面幅 (絵文字の初期位置計算に使用)
  @override
  double get screenHeight;

  /// Create a copy of SavingsInitParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SavingsInitParamsImplCopyWith<_$SavingsInitParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SavingsState {
// 画面上に表示されている落下中の絵文字リスト（位置はViewModelが更新）
  List<FallingEmoji> get fallingEmojis =>
      throw _privateConstructorUsedError; // 金額カウントアップアニメーションの最終目標値
  double get animatedSavingsValueTarget => throw _privateConstructorUsedError;

  /// Create a copy of SavingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SavingsStateCopyWith<SavingsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SavingsStateCopyWith<$Res> {
  factory $SavingsStateCopyWith(
          SavingsState value, $Res Function(SavingsState) then) =
      _$SavingsStateCopyWithImpl<$Res, SavingsState>;
  @useResult
  $Res call(
      {List<FallingEmoji> fallingEmojis, double animatedSavingsValueTarget});
}

/// @nodoc
class _$SavingsStateCopyWithImpl<$Res, $Val extends SavingsState>
    implements $SavingsStateCopyWith<$Res> {
  _$SavingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SavingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fallingEmojis = null,
    Object? animatedSavingsValueTarget = null,
  }) {
    return _then(_value.copyWith(
      fallingEmojis: null == fallingEmojis
          ? _value.fallingEmojis
          : fallingEmojis // ignore: cast_nullable_to_non_nullable
              as List<FallingEmoji>,
      animatedSavingsValueTarget: null == animatedSavingsValueTarget
          ? _value.animatedSavingsValueTarget
          : animatedSavingsValueTarget // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SavingsStateImplCopyWith<$Res>
    implements $SavingsStateCopyWith<$Res> {
  factory _$$SavingsStateImplCopyWith(
          _$SavingsStateImpl value, $Res Function(_$SavingsStateImpl) then) =
      __$$SavingsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<FallingEmoji> fallingEmojis, double animatedSavingsValueTarget});
}

/// @nodoc
class __$$SavingsStateImplCopyWithImpl<$Res>
    extends _$SavingsStateCopyWithImpl<$Res, _$SavingsStateImpl>
    implements _$$SavingsStateImplCopyWith<$Res> {
  __$$SavingsStateImplCopyWithImpl(
      _$SavingsStateImpl _value, $Res Function(_$SavingsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SavingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fallingEmojis = null,
    Object? animatedSavingsValueTarget = null,
  }) {
    return _then(_$SavingsStateImpl(
      fallingEmojis: null == fallingEmojis
          ? _value._fallingEmojis
          : fallingEmojis // ignore: cast_nullable_to_non_nullable
              as List<FallingEmoji>,
      animatedSavingsValueTarget: null == animatedSavingsValueTarget
          ? _value.animatedSavingsValueTarget
          : animatedSavingsValueTarget // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$SavingsStateImpl implements _SavingsState {
  const _$SavingsStateImpl(
      {required final List<FallingEmoji> fallingEmojis,
      required this.animatedSavingsValueTarget})
      : _fallingEmojis = fallingEmojis;

// 画面上に表示されている落下中の絵文字リスト（位置はViewModelが更新）
  final List<FallingEmoji> _fallingEmojis;
// 画面上に表示されている落下中の絵文字リスト（位置はViewModelが更新）
  @override
  List<FallingEmoji> get fallingEmojis {
    if (_fallingEmojis is EqualUnmodifiableListView) return _fallingEmojis;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fallingEmojis);
  }

// 金額カウントアップアニメーションの最終目標値
  @override
  final double animatedSavingsValueTarget;

  @override
  String toString() {
    return 'SavingsState(fallingEmojis: $fallingEmojis, animatedSavingsValueTarget: $animatedSavingsValueTarget)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SavingsStateImpl &&
            const DeepCollectionEquality()
                .equals(other._fallingEmojis, _fallingEmojis) &&
            (identical(other.animatedSavingsValueTarget,
                    animatedSavingsValueTarget) ||
                other.animatedSavingsValueTarget ==
                    animatedSavingsValueTarget));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_fallingEmojis),
      animatedSavingsValueTarget);

  /// Create a copy of SavingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SavingsStateImplCopyWith<_$SavingsStateImpl> get copyWith =>
      __$$SavingsStateImplCopyWithImpl<_$SavingsStateImpl>(this, _$identity);
}

abstract class _SavingsState implements SavingsState {
  const factory _SavingsState(
      {required final List<FallingEmoji> fallingEmojis,
      required final double animatedSavingsValueTarget}) = _$SavingsStateImpl;

// 画面上に表示されている落下中の絵文字リスト（位置はViewModelが更新）
  @override
  List<FallingEmoji> get fallingEmojis; // 金額カウントアップアニメーションの最終目標値
  @override
  double get animatedSavingsValueTarget;

  /// Create a copy of SavingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SavingsStateImplCopyWith<_$SavingsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
