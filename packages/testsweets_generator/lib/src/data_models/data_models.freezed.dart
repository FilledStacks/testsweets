// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'data_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
AutomationKey _$AutomationKeyFromJson(Map<String, dynamic> json) {
  return _AutomationKey.fromJson(json);
}

/// @nodoc
class _$AutomationKeyTearOff {
  const _$AutomationKeyTearOff();

// ignore: unused_element
  _AutomationKey call({String name, WidgetType type, String view}) {
    return _AutomationKey(
      name: name,
      type: type,
      view: view,
    );
  }

// ignore: unused_element
  AutomationKey fromJson(Map<String, Object> json) {
    return AutomationKey.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $AutomationKey = _$AutomationKeyTearOff();

/// @nodoc
mixin _$AutomationKey {
  String get name;
  WidgetType get type;
  String get view;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $AutomationKeyCopyWith<AutomationKey> get copyWith;
}

/// @nodoc
abstract class $AutomationKeyCopyWith<$Res> {
  factory $AutomationKeyCopyWith(
          AutomationKey value, $Res Function(AutomationKey) then) =
      _$AutomationKeyCopyWithImpl<$Res>;
  $Res call({String name, WidgetType type, String view});
}

/// @nodoc
class _$AutomationKeyCopyWithImpl<$Res>
    implements $AutomationKeyCopyWith<$Res> {
  _$AutomationKeyCopyWithImpl(this._value, this._then);

  final AutomationKey _value;
  // ignore: unused_field
  final $Res Function(AutomationKey) _then;

  @override
  $Res call({
    Object name = freezed,
    Object type = freezed,
    Object view = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed ? _value.name : name as String,
      type: type == freezed ? _value.type : type as WidgetType,
      view: view == freezed ? _value.view : view as String,
    ));
  }
}

/// @nodoc
abstract class _$AutomationKeyCopyWith<$Res>
    implements $AutomationKeyCopyWith<$Res> {
  factory _$AutomationKeyCopyWith(
          _AutomationKey value, $Res Function(_AutomationKey) then) =
      __$AutomationKeyCopyWithImpl<$Res>;
  @override
  $Res call({String name, WidgetType type, String view});
}

/// @nodoc
class __$AutomationKeyCopyWithImpl<$Res>
    extends _$AutomationKeyCopyWithImpl<$Res>
    implements _$AutomationKeyCopyWith<$Res> {
  __$AutomationKeyCopyWithImpl(
      _AutomationKey _value, $Res Function(_AutomationKey) _then)
      : super(_value, (v) => _then(v as _AutomationKey));

  @override
  _AutomationKey get _value => super._value as _AutomationKey;

  @override
  $Res call({
    Object name = freezed,
    Object type = freezed,
    Object view = freezed,
  }) {
    return _then(_AutomationKey(
      name: name == freezed ? _value.name : name as String,
      type: type == freezed ? _value.type : type as WidgetType,
      view: view == freezed ? _value.view : view as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_AutomationKey extends _AutomationKey {
  _$_AutomationKey({this.name, this.type, this.view}) : super._();

  factory _$_AutomationKey.fromJson(Map<String, dynamic> json) =>
      _$_$_AutomationKeyFromJson(json);

  @override
  final String name;
  @override
  final WidgetType type;
  @override
  final String view;

  @override
  String toString() {
    return 'AutomationKey(name: $name, type: $type, view: $view)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AutomationKey &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.view, view) ||
                const DeepCollectionEquality().equals(other.view, view)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(view);

  @JsonKey(ignore: true)
  @override
  _$AutomationKeyCopyWith<_AutomationKey> get copyWith =>
      __$AutomationKeyCopyWithImpl<_AutomationKey>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_AutomationKeyToJson(this);
  }
}

abstract class _AutomationKey extends AutomationKey {
  _AutomationKey._() : super._();
  factory _AutomationKey({String name, WidgetType type, String view}) =
      _$_AutomationKey;

  factory _AutomationKey.fromJson(Map<String, dynamic> json) =
      _$_AutomationKey.fromJson;

  @override
  String get name;
  @override
  WidgetType get type;
  @override
  String get view;
  @override
  @JsonKey(ignore: true)
  _$AutomationKeyCopyWith<_AutomationKey> get copyWith;
}
