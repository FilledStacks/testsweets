// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'driver_command_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DriverCommandResult _$DriverCommandResultFromJson(Map<String, dynamic> json) {
  return _DriverCommandResult.fromJson(json);
}

/// @nodoc
mixin _$DriverCommandResult {
  DriverCommandType get type => throw _privateConstructorUsedError;
  bool get success => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DriverCommandResultCopyWith<DriverCommandResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DriverCommandResultCopyWith<$Res> {
  factory $DriverCommandResultCopyWith(
          DriverCommandResult value, $Res Function(DriverCommandResult) then) =
      _$DriverCommandResultCopyWithImpl<$Res, DriverCommandResult>;
  @useResult
  $Res call({DriverCommandType type, bool success});
}

/// @nodoc
class _$DriverCommandResultCopyWithImpl<$Res, $Val extends DriverCommandResult>
    implements $DriverCommandResultCopyWith<$Res> {
  _$DriverCommandResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? success = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as DriverCommandType,
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DriverCommandResultImplCopyWith<$Res>
    implements $DriverCommandResultCopyWith<$Res> {
  factory _$$DriverCommandResultImplCopyWith(_$DriverCommandResultImpl value,
          $Res Function(_$DriverCommandResultImpl) then) =
      __$$DriverCommandResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DriverCommandType type, bool success});
}

/// @nodoc
class __$$DriverCommandResultImplCopyWithImpl<$Res>
    extends _$DriverCommandResultCopyWithImpl<$Res, _$DriverCommandResultImpl>
    implements _$$DriverCommandResultImplCopyWith<$Res> {
  __$$DriverCommandResultImplCopyWithImpl(_$DriverCommandResultImpl _value,
      $Res Function(_$DriverCommandResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? success = null,
  }) {
    return _then(_$DriverCommandResultImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as DriverCommandType,
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DriverCommandResultImpl implements _DriverCommandResult {
  _$DriverCommandResultImpl({required this.type, required this.success});

  factory _$DriverCommandResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$DriverCommandResultImplFromJson(json);

  @override
  final DriverCommandType type;
  @override
  final bool success;

  @override
  String toString() {
    return 'DriverCommandResult(type: $type, success: $success)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DriverCommandResultImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.success, success) || other.success == success));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, success);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DriverCommandResultImplCopyWith<_$DriverCommandResultImpl> get copyWith =>
      __$$DriverCommandResultImplCopyWithImpl<_$DriverCommandResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DriverCommandResultImplToJson(
      this,
    );
  }
}

abstract class _DriverCommandResult implements DriverCommandResult {
  factory _DriverCommandResult(
      {required final DriverCommandType type,
      required final bool success}) = _$DriverCommandResultImpl;

  factory _DriverCommandResult.fromJson(Map<String, dynamic> json) =
      _$DriverCommandResultImpl.fromJson;

  @override
  DriverCommandType get type;
  @override
  bool get success;
  @override
  @JsonKey(ignore: true)
  _$$DriverCommandResultImplCopyWith<_$DriverCommandResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
