// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'outgoing_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OutgoingEvent _$OutgoingEventFromJson(Map<String, dynamic> json) {
  return _OutgoingEvent.fromJson(json);
}

/// @nodoc
mixin _$OutgoingEvent {
  String get name => throw _privateConstructorUsedError;
  Map<String, dynamic> get properties => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OutgoingEventCopyWith<OutgoingEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutgoingEventCopyWith<$Res> {
  factory $OutgoingEventCopyWith(
          OutgoingEvent value, $Res Function(OutgoingEvent) then) =
      _$OutgoingEventCopyWithImpl<$Res, OutgoingEvent>;
  @useResult
  $Res call({String name, Map<String, dynamic> properties});
}

/// @nodoc
class _$OutgoingEventCopyWithImpl<$Res, $Val extends OutgoingEvent>
    implements $OutgoingEventCopyWith<$Res> {
  _$OutgoingEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? properties = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      properties: null == properties
          ? _value.properties
          : properties // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OutgoingEventCopyWith<$Res>
    implements $OutgoingEventCopyWith<$Res> {
  factory _$$_OutgoingEventCopyWith(
          _$_OutgoingEvent value, $Res Function(_$_OutgoingEvent) then) =
      __$$_OutgoingEventCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, Map<String, dynamic> properties});
}

/// @nodoc
class __$$_OutgoingEventCopyWithImpl<$Res>
    extends _$OutgoingEventCopyWithImpl<$Res, _$_OutgoingEvent>
    implements _$$_OutgoingEventCopyWith<$Res> {
  __$$_OutgoingEventCopyWithImpl(
      _$_OutgoingEvent _value, $Res Function(_$_OutgoingEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? properties = null,
  }) {
    return _then(_$_OutgoingEvent(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      properties: null == properties
          ? _value._properties
          : properties // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_OutgoingEvent implements _OutgoingEvent {
  _$_OutgoingEvent(
      {required this.name, final Map<String, dynamic> properties = const {}})
      : _properties = properties;

  factory _$_OutgoingEvent.fromJson(Map<String, dynamic> json) =>
      _$$_OutgoingEventFromJson(json);

  @override
  final String name;
  final Map<String, dynamic> _properties;
  @override
  @JsonKey()
  Map<String, dynamic> get properties {
    if (_properties is EqualUnmodifiableMapView) return _properties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_properties);
  }

  @override
  String toString() {
    return 'OutgoingEvent(name: $name, properties: $properties)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OutgoingEvent &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._properties, _properties));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, const DeepCollectionEquality().hash(_properties));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OutgoingEventCopyWith<_$_OutgoingEvent> get copyWith =>
      __$$_OutgoingEventCopyWithImpl<_$_OutgoingEvent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OutgoingEventToJson(
      this,
    );
  }
}

abstract class _OutgoingEvent implements OutgoingEvent {
  factory _OutgoingEvent(
      {required final String name,
      final Map<String, dynamic> properties}) = _$_OutgoingEvent;

  factory _OutgoingEvent.fromJson(Map<String, dynamic> json) =
      _$_OutgoingEvent.fromJson;

  @override
  String get name;
  @override
  Map<String, dynamic> get properties;
  @override
  @JsonKey(ignore: true)
  _$$_OutgoingEventCopyWith<_$_OutgoingEvent> get copyWith =>
      throw _privateConstructorUsedError;
}
