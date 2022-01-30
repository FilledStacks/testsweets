// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'widget_form_info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WidgetFormInfoModel _$WidgetFormInfoModelFromJson(Map<String, dynamic> json) {
  return _WidgetFormInfoModel.fromJson(json);
}

/// @nodoc
class _$WidgetFormInfoModelTearOff {
  const _$WidgetFormInfoModelTearOff();

  _WidgetFormInfoModel call({required String name, bool visibilty = true}) {
    return _WidgetFormInfoModel(
      name: name,
      visibilty: visibilty,
    );
  }

  WidgetFormInfoModel fromJson(Map<String, Object> json) {
    return WidgetFormInfoModel.fromJson(json);
  }
}

/// @nodoc
const $WidgetFormInfoModel = _$WidgetFormInfoModelTearOff();

/// @nodoc
mixin _$WidgetFormInfoModel {
  String get name => throw _privateConstructorUsedError;
  bool get visibilty => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WidgetFormInfoModelCopyWith<WidgetFormInfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WidgetFormInfoModelCopyWith<$Res> {
  factory $WidgetFormInfoModelCopyWith(
          WidgetFormInfoModel value, $Res Function(WidgetFormInfoModel) then) =
      _$WidgetFormInfoModelCopyWithImpl<$Res>;
  $Res call({String name, bool visibilty});
}

/// @nodoc
class _$WidgetFormInfoModelCopyWithImpl<$Res>
    implements $WidgetFormInfoModelCopyWith<$Res> {
  _$WidgetFormInfoModelCopyWithImpl(this._value, this._then);

  final WidgetFormInfoModel _value;
  // ignore: unused_field
  final $Res Function(WidgetFormInfoModel) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? visibilty = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      visibilty: visibilty == freezed
          ? _value.visibilty
          : visibilty // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$WidgetFormInfoModelCopyWith<$Res>
    implements $WidgetFormInfoModelCopyWith<$Res> {
  factory _$WidgetFormInfoModelCopyWith(_WidgetFormInfoModel value,
          $Res Function(_WidgetFormInfoModel) then) =
      __$WidgetFormInfoModelCopyWithImpl<$Res>;
  @override
  $Res call({String name, bool visibilty});
}

/// @nodoc
class __$WidgetFormInfoModelCopyWithImpl<$Res>
    extends _$WidgetFormInfoModelCopyWithImpl<$Res>
    implements _$WidgetFormInfoModelCopyWith<$Res> {
  __$WidgetFormInfoModelCopyWithImpl(
      _WidgetFormInfoModel _value, $Res Function(_WidgetFormInfoModel) _then)
      : super(_value, (v) => _then(v as _WidgetFormInfoModel));

  @override
  _WidgetFormInfoModel get _value => super._value as _WidgetFormInfoModel;

  @override
  $Res call({
    Object? name = freezed,
    Object? visibilty = freezed,
  }) {
    return _then(_WidgetFormInfoModel(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      visibilty: visibilty == freezed
          ? _value.visibilty
          : visibilty // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WidgetFormInfoModel implements _WidgetFormInfoModel {
  _$_WidgetFormInfoModel({required this.name, this.visibilty = true});

  factory _$_WidgetFormInfoModel.fromJson(Map<String, dynamic> json) =>
      _$$_WidgetFormInfoModelFromJson(json);

  @override
  final String name;
  @JsonKey(defaultValue: true)
  @override
  final bool visibilty;

  @override
  String toString() {
    return 'WidgetFormInfoModel(name: $name, visibilty: $visibilty)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _WidgetFormInfoModel &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.visibilty, visibilty) ||
                const DeepCollectionEquality()
                    .equals(other.visibilty, visibilty)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(visibilty);

  @JsonKey(ignore: true)
  @override
  _$WidgetFormInfoModelCopyWith<_WidgetFormInfoModel> get copyWith =>
      __$WidgetFormInfoModelCopyWithImpl<_WidgetFormInfoModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WidgetFormInfoModelToJson(this);
  }
}

abstract class _WidgetFormInfoModel implements WidgetFormInfoModel {
  factory _WidgetFormInfoModel({required String name, bool visibilty}) =
      _$_WidgetFormInfoModel;

  factory _WidgetFormInfoModel.fromJson(Map<String, dynamic> json) =
      _$_WidgetFormInfoModel.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  bool get visibilty => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$WidgetFormInfoModelCopyWith<_WidgetFormInfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}
