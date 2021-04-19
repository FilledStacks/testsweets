// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'data_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AutomationKey _$AutomationKeyFromJson(Map<String, dynamic> json) {
  return _AutomationKey.fromJson(json);
}

/// @nodoc
class _$AutomationKeyTearOff {
  const _$AutomationKeyTearOff();

  _AutomationKey call(
      {required String name, required WidgetType type, required String view}) {
    return _AutomationKey(
      name: name,
      type: type,
      view: view,
    );
  }

  AutomationKey fromJson(Map<String, Object> json) {
    return AutomationKey.fromJson(json);
  }
}

/// @nodoc
const $AutomationKey = _$AutomationKeyTearOff();

/// @nodoc
mixin _$AutomationKey {
  String get name => throw _privateConstructorUsedError;
  WidgetType get type => throw _privateConstructorUsedError;
  String get view => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AutomationKeyCopyWith<AutomationKey> get copyWith =>
      throw _privateConstructorUsedError;
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
    Object? name = freezed,
    Object? type = freezed,
    Object? view = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as WidgetType,
      view: view == freezed
          ? _value.view
          : view // ignore: cast_nullable_to_non_nullable
              as String,
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
    Object? name = freezed,
    Object? type = freezed,
    Object? view = freezed,
  }) {
    return _then(_AutomationKey(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as WidgetType,
      view: view == freezed
          ? _value.view
          : view // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_AutomationKey extends _AutomationKey {
  _$_AutomationKey({required this.name, required this.type, required this.view})
      : super._();

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
  factory _AutomationKey(
      {required String name,
      required WidgetType type,
      required String view}) = _$_AutomationKey;
  _AutomationKey._() : super._();

  factory _AutomationKey.fromJson(Map<String, dynamic> json) =
      _$_AutomationKey.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  WidgetType get type => throw _privateConstructorUsedError;
  @override
  String get view => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$AutomationKeyCopyWith<_AutomationKey> get copyWith =>
      throw _privateConstructorUsedError;
}
