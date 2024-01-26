// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'widget_position.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WidgetPosition _$WidgetPositionFromJson(Map<String, dynamic> json) {
  return _WidgetPosition.fromJson(json);
}

/// @nodoc
mixin _$WidgetPosition {
  double get x => throw _privateConstructorUsedError;
  double get y => throw _privateConstructorUsedError;
  double? get yDeviation => throw _privateConstructorUsedError;
  double? get xDeviation => throw _privateConstructorUsedError;
  List<DeviceDetails> get deviceBuckets =>
      throw _privateConstructorUsedError; // These values are old, but we keep it because we have a JIT migration for now
  double? get capturedDeviceWidth => throw _privateConstructorUsedError;
  double? get capturedDeviceHeight => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WidgetPositionCopyWith<WidgetPosition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WidgetPositionCopyWith<$Res> {
  factory $WidgetPositionCopyWith(
          WidgetPosition value, $Res Function(WidgetPosition) then) =
      _$WidgetPositionCopyWithImpl<$Res, WidgetPosition>;
  @useResult
  $Res call(
      {double x,
      double y,
      double? yDeviation,
      double? xDeviation,
      List<DeviceDetails> deviceBuckets,
      double? capturedDeviceWidth,
      double? capturedDeviceHeight});
}

/// @nodoc
class _$WidgetPositionCopyWithImpl<$Res, $Val extends WidgetPosition>
    implements $WidgetPositionCopyWith<$Res> {
  _$WidgetPositionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
    Object? yDeviation = freezed,
    Object? xDeviation = freezed,
    Object? deviceBuckets = null,
    Object? capturedDeviceWidth = freezed,
    Object? capturedDeviceHeight = freezed,
  }) {
    return _then(_value.copyWith(
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
      yDeviation: freezed == yDeviation
          ? _value.yDeviation
          : yDeviation // ignore: cast_nullable_to_non_nullable
              as double?,
      xDeviation: freezed == xDeviation
          ? _value.xDeviation
          : xDeviation // ignore: cast_nullable_to_non_nullable
              as double?,
      deviceBuckets: null == deviceBuckets
          ? _value.deviceBuckets
          : deviceBuckets // ignore: cast_nullable_to_non_nullable
              as List<DeviceDetails>,
      capturedDeviceWidth: freezed == capturedDeviceWidth
          ? _value.capturedDeviceWidth
          : capturedDeviceWidth // ignore: cast_nullable_to_non_nullable
              as double?,
      capturedDeviceHeight: freezed == capturedDeviceHeight
          ? _value.capturedDeviceHeight
          : capturedDeviceHeight // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WidgetPositionCopyWith<$Res>
    implements $WidgetPositionCopyWith<$Res> {
  factory _$$_WidgetPositionCopyWith(
          _$_WidgetPosition value, $Res Function(_$_WidgetPosition) then) =
      __$$_WidgetPositionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double x,
      double y,
      double? yDeviation,
      double? xDeviation,
      List<DeviceDetails> deviceBuckets,
      double? capturedDeviceWidth,
      double? capturedDeviceHeight});
}

/// @nodoc
class __$$_WidgetPositionCopyWithImpl<$Res>
    extends _$WidgetPositionCopyWithImpl<$Res, _$_WidgetPosition>
    implements _$$_WidgetPositionCopyWith<$Res> {
  __$$_WidgetPositionCopyWithImpl(
      _$_WidgetPosition _value, $Res Function(_$_WidgetPosition) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
    Object? yDeviation = freezed,
    Object? xDeviation = freezed,
    Object? deviceBuckets = null,
    Object? capturedDeviceWidth = freezed,
    Object? capturedDeviceHeight = freezed,
  }) {
    return _then(_$_WidgetPosition(
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
      yDeviation: freezed == yDeviation
          ? _value.yDeviation
          : yDeviation // ignore: cast_nullable_to_non_nullable
              as double?,
      xDeviation: freezed == xDeviation
          ? _value.xDeviation
          : xDeviation // ignore: cast_nullable_to_non_nullable
              as double?,
      deviceBuckets: null == deviceBuckets
          ? _value._deviceBuckets
          : deviceBuckets // ignore: cast_nullable_to_non_nullable
              as List<DeviceDetails>,
      capturedDeviceWidth: freezed == capturedDeviceWidth
          ? _value.capturedDeviceWidth
          : capturedDeviceWidth // ignore: cast_nullable_to_non_nullable
              as double?,
      capturedDeviceHeight: freezed == capturedDeviceHeight
          ? _value.capturedDeviceHeight
          : capturedDeviceHeight // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WidgetPosition implements _WidgetPosition {
  _$_WidgetPosition(
      {required this.x,
      required this.y,
      this.yDeviation,
      this.xDeviation,
      final List<DeviceDetails> deviceBuckets = const [],
      this.capturedDeviceWidth,
      this.capturedDeviceHeight})
      : _deviceBuckets = deviceBuckets;

  factory _$_WidgetPosition.fromJson(Map<String, dynamic> json) =>
      _$$_WidgetPositionFromJson(json);

  @override
  final double x;
  @override
  final double y;
  @override
  final double? yDeviation;
  @override
  final double? xDeviation;
  final List<DeviceDetails> _deviceBuckets;
  @override
  @JsonKey()
  List<DeviceDetails> get deviceBuckets {
    if (_deviceBuckets is EqualUnmodifiableListView) return _deviceBuckets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deviceBuckets);
  }

// These values are old, but we keep it because we have a JIT migration for now
  @override
  final double? capturedDeviceWidth;
  @override
  final double? capturedDeviceHeight;

  @override
  String toString() {
    return 'WidgetPosition(x: $x, y: $y, yDeviation: $yDeviation, xDeviation: $xDeviation, deviceBuckets: $deviceBuckets, capturedDeviceWidth: $capturedDeviceWidth, capturedDeviceHeight: $capturedDeviceHeight)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WidgetPosition &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y) &&
            (identical(other.yDeviation, yDeviation) ||
                other.yDeviation == yDeviation) &&
            (identical(other.xDeviation, xDeviation) ||
                other.xDeviation == xDeviation) &&
            const DeepCollectionEquality()
                .equals(other._deviceBuckets, _deviceBuckets) &&
            (identical(other.capturedDeviceWidth, capturedDeviceWidth) ||
                other.capturedDeviceWidth == capturedDeviceWidth) &&
            (identical(other.capturedDeviceHeight, capturedDeviceHeight) ||
                other.capturedDeviceHeight == capturedDeviceHeight));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      x,
      y,
      yDeviation,
      xDeviation,
      const DeepCollectionEquality().hash(_deviceBuckets),
      capturedDeviceWidth,
      capturedDeviceHeight);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WidgetPositionCopyWith<_$_WidgetPosition> get copyWith =>
      __$$_WidgetPositionCopyWithImpl<_$_WidgetPosition>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WidgetPositionToJson(
      this,
    );
  }
}

abstract class _WidgetPosition implements WidgetPosition {
  factory _WidgetPosition(
      {required final double x,
      required final double y,
      final double? yDeviation,
      final double? xDeviation,
      final List<DeviceDetails> deviceBuckets,
      final double? capturedDeviceWidth,
      final double? capturedDeviceHeight}) = _$_WidgetPosition;

  factory _WidgetPosition.fromJson(Map<String, dynamic> json) =
      _$_WidgetPosition.fromJson;

  @override
  double get x;
  @override
  double get y;
  @override
  double? get yDeviation;
  @override
  double? get xDeviation;
  @override
  List<DeviceDetails> get deviceBuckets;
  @override // These values are old, but we keep it because we have a JIT migration for now
  double? get capturedDeviceWidth;
  @override
  double? get capturedDeviceHeight;
  @override
  @JsonKey(ignore: true)
  _$$_WidgetPositionCopyWith<_$_WidgetPosition> get copyWith =>
      throw _privateConstructorUsedError;
}
