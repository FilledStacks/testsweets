// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DeviceDetails _$DeviceDetailsFromJson(Map<String, dynamic> json) {
  return _DeviceDetails.fromJson(json);
}

/// @nodoc
mixin _$DeviceDetails {
  double get screenWidth => throw _privateConstructorUsedError;
  double get screenHeight => throw _privateConstructorUsedError;
  Orientation get orientation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeviceDetailsCopyWith<DeviceDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceDetailsCopyWith<$Res> {
  factory $DeviceDetailsCopyWith(
          DeviceDetails value, $Res Function(DeviceDetails) then) =
      _$DeviceDetailsCopyWithImpl<$Res, DeviceDetails>;
  @useResult
  $Res call({double screenWidth, double screenHeight, Orientation orientation});
}

/// @nodoc
class _$DeviceDetailsCopyWithImpl<$Res, $Val extends DeviceDetails>
    implements $DeviceDetailsCopyWith<$Res> {
  _$DeviceDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? screenWidth = null,
    Object? screenHeight = null,
    Object? orientation = null,
  }) {
    return _then(_value.copyWith(
      screenWidth: null == screenWidth
          ? _value.screenWidth
          : screenWidth // ignore: cast_nullable_to_non_nullable
              as double,
      screenHeight: null == screenHeight
          ? _value.screenHeight
          : screenHeight // ignore: cast_nullable_to_non_nullable
              as double,
      orientation: null == orientation
          ? _value.orientation
          : orientation // ignore: cast_nullable_to_non_nullable
              as Orientation,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DeviceDetailsCopyWith<$Res>
    implements $DeviceDetailsCopyWith<$Res> {
  factory _$$_DeviceDetailsCopyWith(
          _$_DeviceDetails value, $Res Function(_$_DeviceDetails) then) =
      __$$_DeviceDetailsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double screenWidth, double screenHeight, Orientation orientation});
}

/// @nodoc
class __$$_DeviceDetailsCopyWithImpl<$Res>
    extends _$DeviceDetailsCopyWithImpl<$Res, _$_DeviceDetails>
    implements _$$_DeviceDetailsCopyWith<$Res> {
  __$$_DeviceDetailsCopyWithImpl(
      _$_DeviceDetails _value, $Res Function(_$_DeviceDetails) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? screenWidth = null,
    Object? screenHeight = null,
    Object? orientation = null,
  }) {
    return _then(_$_DeviceDetails(
      screenWidth: null == screenWidth
          ? _value.screenWidth
          : screenWidth // ignore: cast_nullable_to_non_nullable
              as double,
      screenHeight: null == screenHeight
          ? _value.screenHeight
          : screenHeight // ignore: cast_nullable_to_non_nullable
              as double,
      orientation: null == orientation
          ? _value.orientation
          : orientation // ignore: cast_nullable_to_non_nullable
              as Orientation,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DeviceDetails implements _DeviceDetails {
  _$_DeviceDetails(
      {required this.screenWidth,
      required this.screenHeight,
      required this.orientation});

  factory _$_DeviceDetails.fromJson(Map<String, dynamic> json) =>
      _$$_DeviceDetailsFromJson(json);

  @override
  final double screenWidth;
  @override
  final double screenHeight;
  @override
  final Orientation orientation;

  @override
  String toString() {
    return 'DeviceDetails(screenWidth: $screenWidth, screenHeight: $screenHeight, orientation: $orientation)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DeviceDetails &&
            (identical(other.screenWidth, screenWidth) ||
                other.screenWidth == screenWidth) &&
            (identical(other.screenHeight, screenHeight) ||
                other.screenHeight == screenHeight) &&
            (identical(other.orientation, orientation) ||
                other.orientation == orientation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, screenWidth, screenHeight, orientation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DeviceDetailsCopyWith<_$_DeviceDetails> get copyWith =>
      __$$_DeviceDetailsCopyWithImpl<_$_DeviceDetails>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DeviceDetailsToJson(
      this,
    );
  }
}

abstract class _DeviceDetails implements DeviceDetails {
  factory _DeviceDetails(
      {required final double screenWidth,
      required final double screenHeight,
      required final Orientation orientation}) = _$_DeviceDetails;

  factory _DeviceDetails.fromJson(Map<String, dynamic> json) =
      _$_DeviceDetails.fromJson;

  @override
  double get screenWidth;
  @override
  double get screenHeight;
  @override
  Orientation get orientation;
  @override
  @JsonKey(ignore: true)
  _$$_DeviceDetailsCopyWith<_$_DeviceDetails> get copyWith =>
      throw _privateConstructorUsedError;
}
