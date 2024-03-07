// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'driver_command.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DriverCommand _$DriverCommandFromJson(Map<String, dynamic> json) {
  return _DriverCommand.fromJson(json);
}

/// @nodoc
mixin _$DriverCommand {
  DriverCommandType get type => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  dynamic get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DriverCommandCopyWith<DriverCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DriverCommandCopyWith<$Res> {
  factory $DriverCommandCopyWith(
          DriverCommand value, $Res Function(DriverCommand) then) =
      _$DriverCommandCopyWithImpl<$Res, DriverCommand>;
  @useResult
  $Res call({DriverCommandType type, String name, dynamic value});
}

/// @nodoc
class _$DriverCommandCopyWithImpl<$Res, $Val extends DriverCommand>
    implements $DriverCommandCopyWith<$Res> {
  _$DriverCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? name = null,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as DriverCommandType,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DriverCommandImplCopyWith<$Res>
    implements $DriverCommandCopyWith<$Res> {
  factory _$$DriverCommandImplCopyWith(
          _$DriverCommandImpl value, $Res Function(_$DriverCommandImpl) then) =
      __$$DriverCommandImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DriverCommandType type, String name, dynamic value});
}

/// @nodoc
class __$$DriverCommandImplCopyWithImpl<$Res>
    extends _$DriverCommandCopyWithImpl<$Res, _$DriverCommandImpl>
    implements _$$DriverCommandImplCopyWith<$Res> {
  __$$DriverCommandImplCopyWithImpl(
      _$DriverCommandImpl _value, $Res Function(_$DriverCommandImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? name = null,
    Object? value = freezed,
  }) {
    return _then(_$DriverCommandImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as DriverCommandType,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DriverCommandImpl implements _DriverCommand {
  _$DriverCommandImpl({required this.type, required this.name, this.value});

  factory _$DriverCommandImpl.fromJson(Map<String, dynamic> json) =>
      _$$DriverCommandImplFromJson(json);

  @override
  final DriverCommandType type;
  @override
  final String name;
  @override
  final dynamic value;

  @override
  String toString() {
    return 'DriverCommand(type: $type, name: $name, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DriverCommandImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, type, name, const DeepCollectionEquality().hash(value));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DriverCommandImplCopyWith<_$DriverCommandImpl> get copyWith =>
      __$$DriverCommandImplCopyWithImpl<_$DriverCommandImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DriverCommandImplToJson(
      this,
    );
  }
}

abstract class _DriverCommand implements DriverCommand {
  factory _DriverCommand(
      {required final DriverCommandType type,
      required final String name,
      final dynamic value}) = _$DriverCommandImpl;

  factory _DriverCommand.fromJson(Map<String, dynamic> json) =
      _$DriverCommandImpl.fromJson;

  @override
  DriverCommandType get type;
  @override
  String get name;
  @override
  dynamic get value;
  @override
  @JsonKey(ignore: true)
  _$$DriverCommandImplCopyWith<_$DriverCommandImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExpectEventDataModel _$ExpectEventDataModelFromJson(Map<String, dynamic> json) {
  return _ExpectEventDataModel.fromJson(json);
}

/// @nodoc
mixin _$ExpectEventDataModel {
  String get key => throw _privateConstructorUsedError;
  dynamic get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExpectEventDataModelCopyWith<ExpectEventDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpectEventDataModelCopyWith<$Res> {
  factory $ExpectEventDataModelCopyWith(ExpectEventDataModel value,
          $Res Function(ExpectEventDataModel) then) =
      _$ExpectEventDataModelCopyWithImpl<$Res, ExpectEventDataModel>;
  @useResult
  $Res call({String key, dynamic value});
}

/// @nodoc
class _$ExpectEventDataModelCopyWithImpl<$Res,
        $Val extends ExpectEventDataModel>
    implements $ExpectEventDataModelCopyWith<$Res> {
  _$ExpectEventDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExpectEventDataModelImplCopyWith<$Res>
    implements $ExpectEventDataModelCopyWith<$Res> {
  factory _$$ExpectEventDataModelImplCopyWith(_$ExpectEventDataModelImpl value,
          $Res Function(_$ExpectEventDataModelImpl) then) =
      __$$ExpectEventDataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String key, dynamic value});
}

/// @nodoc
class __$$ExpectEventDataModelImplCopyWithImpl<$Res>
    extends _$ExpectEventDataModelCopyWithImpl<$Res, _$ExpectEventDataModelImpl>
    implements _$$ExpectEventDataModelImplCopyWith<$Res> {
  __$$ExpectEventDataModelImplCopyWithImpl(_$ExpectEventDataModelImpl _value,
      $Res Function(_$ExpectEventDataModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? value = freezed,
  }) {
    return _then(_$ExpectEventDataModelImpl(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExpectEventDataModelImpl implements _ExpectEventDataModel {
  _$ExpectEventDataModelImpl({required this.key, required this.value});

  factory _$ExpectEventDataModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExpectEventDataModelImplFromJson(json);

  @override
  final String key;
  @override
  final dynamic value;

  @override
  String toString() {
    return 'ExpectEventDataModel(key: $key, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpectEventDataModelImpl &&
            (identical(other.key, key) || other.key == key) &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, key, const DeepCollectionEquality().hash(value));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpectEventDataModelImplCopyWith<_$ExpectEventDataModelImpl>
      get copyWith =>
          __$$ExpectEventDataModelImplCopyWithImpl<_$ExpectEventDataModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExpectEventDataModelImplToJson(
      this,
    );
  }
}

abstract class _ExpectEventDataModel implements ExpectEventDataModel {
  factory _ExpectEventDataModel(
      {required final String key,
      required final dynamic value}) = _$ExpectEventDataModelImpl;

  factory _ExpectEventDataModel.fromJson(Map<String, dynamic> json) =
      _$ExpectEventDataModelImpl.fromJson;

  @override
  String get key;
  @override
  dynamic get value;
  @override
  @JsonKey(ignore: true)
  _$$ExpectEventDataModelImplCopyWith<_$ExpectEventDataModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
