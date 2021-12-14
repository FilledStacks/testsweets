// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'application_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WidgetDescription _$WidgetDescriptionFromJson(Map<String, dynamic> json) {
  return _WidgetDescription.fromJson(json);
}

/// @nodoc
class _$WidgetDescriptionTearOff {
  const _$WidgetDescriptionTearOff();

  _WidgetDescription call(
      {String? id,
      required String viewName,
      required String originalViewName,
      required String name,
      required WidgetType widgetType,
      required WidgetPosition position}) {
    return _WidgetDescription(
      id: id,
      viewName: viewName,
      originalViewName: originalViewName,
      name: name,
      widgetType: widgetType,
      position: position,
    );
  }

  WidgetDescription fromJson(Map<String, Object> json) {
    return WidgetDescription.fromJson(json);
  }
}

/// @nodoc
const $WidgetDescription = _$WidgetDescriptionTearOff();

/// @nodoc
mixin _$WidgetDescription {
  /// The Id from the firebase backend
  String? get id => throw _privateConstructorUsedError;

  /// The name of the view this widget was captured on
  String get viewName => throw _privateConstructorUsedError;

  /// The orignal name of the view this widget was captured on before the prettify
  String get originalViewName => throw _privateConstructorUsedError;

  /// The name we want to use when referring to the widget in the scripts
  String get name => throw _privateConstructorUsedError;

  /// The type of the widget that's being added
  WidgetType get widgetType => throw _privateConstructorUsedError;

  /// The position we defined for he widget
  WidgetPosition get position => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WidgetDescriptionCopyWith<WidgetDescription> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WidgetDescriptionCopyWith<$Res> {
  factory $WidgetDescriptionCopyWith(
          WidgetDescription value, $Res Function(WidgetDescription) then) =
      _$WidgetDescriptionCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String viewName,
      String originalViewName,
      String name,
      WidgetType widgetType,
      WidgetPosition position});

  $WidgetPositionCopyWith<$Res> get position;
}

/// @nodoc
class _$WidgetDescriptionCopyWithImpl<$Res>
    implements $WidgetDescriptionCopyWith<$Res> {
  _$WidgetDescriptionCopyWithImpl(this._value, this._then);

  final WidgetDescription _value;
  // ignore: unused_field
  final $Res Function(WidgetDescription) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? viewName = freezed,
    Object? originalViewName = freezed,
    Object? name = freezed,
    Object? widgetType = freezed,
    Object? position = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      viewName: viewName == freezed
          ? _value.viewName
          : viewName // ignore: cast_nullable_to_non_nullable
              as String,
      originalViewName: originalViewName == freezed
          ? _value.originalViewName
          : originalViewName // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      widgetType: widgetType == freezed
          ? _value.widgetType
          : widgetType // ignore: cast_nullable_to_non_nullable
              as WidgetType,
      position: position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as WidgetPosition,
    ));
  }

  @override
  $WidgetPositionCopyWith<$Res> get position {
    return $WidgetPositionCopyWith<$Res>(_value.position, (value) {
      return _then(_value.copyWith(position: value));
    });
  }
}

/// @nodoc
abstract class _$WidgetDescriptionCopyWith<$Res>
    implements $WidgetDescriptionCopyWith<$Res> {
  factory _$WidgetDescriptionCopyWith(
          _WidgetDescription value, $Res Function(_WidgetDescription) then) =
      __$WidgetDescriptionCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String viewName,
      String originalViewName,
      String name,
      WidgetType widgetType,
      WidgetPosition position});

  @override
  $WidgetPositionCopyWith<$Res> get position;
}

/// @nodoc
class __$WidgetDescriptionCopyWithImpl<$Res>
    extends _$WidgetDescriptionCopyWithImpl<$Res>
    implements _$WidgetDescriptionCopyWith<$Res> {
  __$WidgetDescriptionCopyWithImpl(
      _WidgetDescription _value, $Res Function(_WidgetDescription) _then)
      : super(_value, (v) => _then(v as _WidgetDescription));

  @override
  _WidgetDescription get _value => super._value as _WidgetDescription;

  @override
  $Res call({
    Object? id = freezed,
    Object? viewName = freezed,
    Object? originalViewName = freezed,
    Object? name = freezed,
    Object? widgetType = freezed,
    Object? position = freezed,
  }) {
    return _then(_WidgetDescription(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      viewName: viewName == freezed
          ? _value.viewName
          : viewName // ignore: cast_nullable_to_non_nullable
              as String,
      originalViewName: originalViewName == freezed
          ? _value.originalViewName
          : originalViewName // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      widgetType: widgetType == freezed
          ? _value.widgetType
          : widgetType // ignore: cast_nullable_to_non_nullable
              as WidgetType,
      position: position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as WidgetPosition,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WidgetDescription extends _WidgetDescription {
  _$_WidgetDescription(
      {this.id,
      required this.viewName,
      required this.originalViewName,
      required this.name,
      required this.widgetType,
      required this.position})
      : super._();

  factory _$_WidgetDescription.fromJson(Map<String, dynamic> json) =>
      _$$_WidgetDescriptionFromJson(json);

  @override

  /// The Id from the firebase backend
  final String? id;
  @override

  /// The name of the view this widget was captured on
  final String viewName;
  @override

  /// The orignal name of the view this widget was captured on before the prettify
  final String originalViewName;
  @override

  /// The name we want to use when referring to the widget in the scripts
  final String name;
  @override

  /// The type of the widget that's being added
  final WidgetType widgetType;
  @override

  /// The position we defined for he widget
  final WidgetPosition position;

  @override
  String toString() {
    return 'WidgetDescription(id: $id, viewName: $viewName, originalViewName: $originalViewName, name: $name, widgetType: $widgetType, position: $position)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _WidgetDescription &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.viewName, viewName) ||
                const DeepCollectionEquality()
                    .equals(other.viewName, viewName)) &&
            (identical(other.originalViewName, originalViewName) ||
                const DeepCollectionEquality()
                    .equals(other.originalViewName, originalViewName)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.widgetType, widgetType) ||
                const DeepCollectionEquality()
                    .equals(other.widgetType, widgetType)) &&
            (identical(other.position, position) ||
                const DeepCollectionEquality()
                    .equals(other.position, position)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(viewName) ^
      const DeepCollectionEquality().hash(originalViewName) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(widgetType) ^
      const DeepCollectionEquality().hash(position);

  @JsonKey(ignore: true)
  @override
  _$WidgetDescriptionCopyWith<_WidgetDescription> get copyWith =>
      __$WidgetDescriptionCopyWithImpl<_WidgetDescription>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WidgetDescriptionToJson(this);
  }
}

abstract class _WidgetDescription extends WidgetDescription {
  factory _WidgetDescription(
      {String? id,
      required String viewName,
      required String originalViewName,
      required String name,
      required WidgetType widgetType,
      required WidgetPosition position}) = _$_WidgetDescription;
  _WidgetDescription._() : super._();

  factory _WidgetDescription.fromJson(Map<String, dynamic> json) =
      _$_WidgetDescription.fromJson;

  @override

  /// The Id from the firebase backend
  String? get id => throw _privateConstructorUsedError;
  @override

  /// The name of the view this widget was captured on
  String get viewName => throw _privateConstructorUsedError;
  @override

  /// The orignal name of the view this widget was captured on before the prettify
  String get originalViewName => throw _privateConstructorUsedError;
  @override

  /// The name we want to use when referring to the widget in the scripts
  String get name => throw _privateConstructorUsedError;
  @override

  /// The type of the widget that's being added
  WidgetType get widgetType => throw _privateConstructorUsedError;
  @override

  /// The position we defined for he widget
  WidgetPosition get position => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$WidgetDescriptionCopyWith<_WidgetDescription> get copyWith =>
      throw _privateConstructorUsedError;
}

WidgetPosition _$WidgetPositionFromJson(Map<String, dynamic> json) {
  return _WidgetPosition.fromJson(json);
}

/// @nodoc
class _$WidgetPositionTearOff {
  const _$WidgetPositionTearOff();

  _WidgetPosition call(
      {required double capturedDeviceWidth,
      required double capturedDeviceHeight,
      required double x,
      required double y,
      bool isPortraitMode = true}) {
    return _WidgetPosition(
      capturedDeviceWidth: capturedDeviceWidth,
      capturedDeviceHeight: capturedDeviceHeight,
      x: x,
      y: y,
      isPortraitMode: isPortraitMode,
    );
  }

  WidgetPosition fromJson(Map<String, Object> json) {
    return WidgetPosition.fromJson(json);
  }
}

/// @nodoc
const $WidgetPosition = _$WidgetPositionTearOff();

/// @nodoc
mixin _$WidgetPosition {
  double get capturedDeviceWidth => throw _privateConstructorUsedError;
  double get capturedDeviceHeight => throw _privateConstructorUsedError;
  double get x => throw _privateConstructorUsedError;
  double get y => throw _privateConstructorUsedError;
  bool get isPortraitMode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WidgetPositionCopyWith<WidgetPosition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WidgetPositionCopyWith<$Res> {
  factory $WidgetPositionCopyWith(
          WidgetPosition value, $Res Function(WidgetPosition) then) =
      _$WidgetPositionCopyWithImpl<$Res>;
  $Res call(
      {double capturedDeviceWidth,
      double capturedDeviceHeight,
      double x,
      double y,
      bool isPortraitMode});
}

/// @nodoc
class _$WidgetPositionCopyWithImpl<$Res>
    implements $WidgetPositionCopyWith<$Res> {
  _$WidgetPositionCopyWithImpl(this._value, this._then);

  final WidgetPosition _value;
  // ignore: unused_field
  final $Res Function(WidgetPosition) _then;

  @override
  $Res call({
    Object? capturedDeviceWidth = freezed,
    Object? capturedDeviceHeight = freezed,
    Object? x = freezed,
    Object? y = freezed,
    Object? isPortraitMode = freezed,
  }) {
    return _then(_value.copyWith(
      capturedDeviceWidth: capturedDeviceWidth == freezed
          ? _value.capturedDeviceWidth
          : capturedDeviceWidth // ignore: cast_nullable_to_non_nullable
              as double,
      capturedDeviceHeight: capturedDeviceHeight == freezed
          ? _value.capturedDeviceHeight
          : capturedDeviceHeight // ignore: cast_nullable_to_non_nullable
              as double,
      x: x == freezed
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      y: y == freezed
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
      isPortraitMode: isPortraitMode == freezed
          ? _value.isPortraitMode
          : isPortraitMode // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$WidgetPositionCopyWith<$Res>
    implements $WidgetPositionCopyWith<$Res> {
  factory _$WidgetPositionCopyWith(
          _WidgetPosition value, $Res Function(_WidgetPosition) then) =
      __$WidgetPositionCopyWithImpl<$Res>;
  @override
  $Res call(
      {double capturedDeviceWidth,
      double capturedDeviceHeight,
      double x,
      double y,
      bool isPortraitMode});
}

/// @nodoc
class __$WidgetPositionCopyWithImpl<$Res>
    extends _$WidgetPositionCopyWithImpl<$Res>
    implements _$WidgetPositionCopyWith<$Res> {
  __$WidgetPositionCopyWithImpl(
      _WidgetPosition _value, $Res Function(_WidgetPosition) _then)
      : super(_value, (v) => _then(v as _WidgetPosition));

  @override
  _WidgetPosition get _value => super._value as _WidgetPosition;

  @override
  $Res call({
    Object? capturedDeviceWidth = freezed,
    Object? capturedDeviceHeight = freezed,
    Object? x = freezed,
    Object? y = freezed,
    Object? isPortraitMode = freezed,
  }) {
    return _then(_WidgetPosition(
      capturedDeviceWidth: capturedDeviceWidth == freezed
          ? _value.capturedDeviceWidth
          : capturedDeviceWidth // ignore: cast_nullable_to_non_nullable
              as double,
      capturedDeviceHeight: capturedDeviceHeight == freezed
          ? _value.capturedDeviceHeight
          : capturedDeviceHeight // ignore: cast_nullable_to_non_nullable
              as double,
      x: x == freezed
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      y: y == freezed
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
      isPortraitMode: isPortraitMode == freezed
          ? _value.isPortraitMode
          : isPortraitMode // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WidgetPosition implements _WidgetPosition {
  _$_WidgetPosition(
      {required this.capturedDeviceWidth,
      required this.capturedDeviceHeight,
      required this.x,
      required this.y,
      this.isPortraitMode = true});

  factory _$_WidgetPosition.fromJson(Map<String, dynamic> json) =>
      _$$_WidgetPositionFromJson(json);

  @override
  final double capturedDeviceWidth;
  @override
  final double capturedDeviceHeight;
  @override
  final double x;
  @override
  final double y;
  @JsonKey(defaultValue: true)
  @override
  final bool isPortraitMode;

  @override
  String toString() {
    return 'WidgetPosition(capturedDeviceWidth: $capturedDeviceWidth, capturedDeviceHeight: $capturedDeviceHeight, x: $x, y: $y, isPortraitMode: $isPortraitMode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _WidgetPosition &&
            (identical(other.capturedDeviceWidth, capturedDeviceWidth) ||
                const DeepCollectionEquality()
                    .equals(other.capturedDeviceWidth, capturedDeviceWidth)) &&
            (identical(other.capturedDeviceHeight, capturedDeviceHeight) ||
                const DeepCollectionEquality().equals(
                    other.capturedDeviceHeight, capturedDeviceHeight)) &&
            (identical(other.x, x) ||
                const DeepCollectionEquality().equals(other.x, x)) &&
            (identical(other.y, y) ||
                const DeepCollectionEquality().equals(other.y, y)) &&
            (identical(other.isPortraitMode, isPortraitMode) ||
                const DeepCollectionEquality()
                    .equals(other.isPortraitMode, isPortraitMode)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(capturedDeviceWidth) ^
      const DeepCollectionEquality().hash(capturedDeviceHeight) ^
      const DeepCollectionEquality().hash(x) ^
      const DeepCollectionEquality().hash(y) ^
      const DeepCollectionEquality().hash(isPortraitMode);

  @JsonKey(ignore: true)
  @override
  _$WidgetPositionCopyWith<_WidgetPosition> get copyWith =>
      __$WidgetPositionCopyWithImpl<_WidgetPosition>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WidgetPositionToJson(this);
  }
}

abstract class _WidgetPosition implements WidgetPosition {
  factory _WidgetPosition(
      {required double capturedDeviceWidth,
      required double capturedDeviceHeight,
      required double x,
      required double y,
      bool isPortraitMode}) = _$_WidgetPosition;

  factory _WidgetPosition.fromJson(Map<String, dynamic> json) =
      _$_WidgetPosition.fromJson;

  @override
  double get capturedDeviceWidth => throw _privateConstructorUsedError;
  @override
  double get capturedDeviceHeight => throw _privateConstructorUsedError;
  @override
  double get x => throw _privateConstructorUsedError;
  @override
  double get y => throw _privateConstructorUsedError;
  @override
  bool get isPortraitMode => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$WidgetPositionCopyWith<_WidgetPosition> get copyWith =>
      throw _privateConstructorUsedError;
}
