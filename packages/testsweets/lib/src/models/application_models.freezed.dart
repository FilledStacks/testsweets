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
      String name = '',
      required WidgetType widgetType,
      required WidgetPosition position,
      bool visibility = true,
      List<String> targetIds = const [],
      Map<String, double>? externalities,
      Axis? axis}) {
    return _WidgetDescription(
      id: id,
      viewName: viewName,
      originalViewName: originalViewName,
      name: name,
      widgetType: widgetType,
      position: position,
      visibility: visibility,
      targetIds: targetIds,
      externalities: externalities,
      axis: axis,
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

  /// Whether the key will be visible to the driver or not
  bool get visibility => throw _privateConstructorUsedError;

  /// Target widgets ids that will be affected when this widget activated
  List<String> get targetIds => throw _privateConstructorUsedError;

  /// External widgets that affect this widget normally "ListView"
  /// where String is the list id and the double is scroll percentage
  Map<String, double>? get externalities => throw _privateConstructorUsedError;

  /// When WidgetType is [view]
  Axis? get axis => throw _privateConstructorUsedError;

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
      WidgetPosition position,
      bool visibility,
      List<String> targetIds,
      Map<String, double>? externalities,
      Axis? axis});

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
    Object? visibility = freezed,
    Object? targetIds = freezed,
    Object? externalities = freezed,
    Object? axis = freezed,
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
      visibility: visibility == freezed
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as bool,
      targetIds: targetIds == freezed
          ? _value.targetIds
          : targetIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      externalities: externalities == freezed
          ? _value.externalities
          : externalities // ignore: cast_nullable_to_non_nullable
              as Map<String, double>?,
      axis: axis == freezed
          ? _value.axis
          : axis // ignore: cast_nullable_to_non_nullable
              as Axis?,
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
      WidgetPosition position,
      bool visibility,
      List<String> targetIds,
      Map<String, double>? externalities,
      Axis? axis});

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
    Object? visibility = freezed,
    Object? targetIds = freezed,
    Object? externalities = freezed,
    Object? axis = freezed,
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
      visibility: visibility == freezed
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as bool,
      targetIds: targetIds == freezed
          ? _value.targetIds
          : targetIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      externalities: externalities == freezed
          ? _value.externalities
          : externalities // ignore: cast_nullable_to_non_nullable
              as Map<String, double>?,
      axis: axis == freezed
          ? _value.axis
          : axis // ignore: cast_nullable_to_non_nullable
              as Axis?,
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
      this.name = '',
      required this.widgetType,
      required this.position,
      this.visibility = true,
      this.targetIds = const [],
      this.externalities,
      this.axis})
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
  @JsonKey(defaultValue: '')
  @override

  /// The name we want to use when referring to the widget in the scripts
  final String name;
  @override

  /// The type of the widget that's being added
  final WidgetType widgetType;
  @override

  /// The position we defined for he widget
  final WidgetPosition position;
  @JsonKey(defaultValue: true)
  @override

  /// Whether the key will be visible to the driver or not
  final bool visibility;
  @JsonKey(defaultValue: const [])
  @override

  /// Target widgets ids that will be affected when this widget activated
  final List<String> targetIds;
  @override

  /// External widgets that affect this widget normally "ListView"
  /// where String is the list id and the double is scroll percentage
  final Map<String, double>? externalities;
  @override

  /// When WidgetType is [view]
  final Axis? axis;

  @override
  String toString() {
    return 'WidgetDescription(id: $id, viewName: $viewName, originalViewName: $originalViewName, name: $name, widgetType: $widgetType, position: $position, visibility: $visibility, targetIds: $targetIds, externalities: $externalities, axis: $axis)';
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
                    .equals(other.position, position)) &&
            (identical(other.visibility, visibility) ||
                const DeepCollectionEquality()
                    .equals(other.visibility, visibility)) &&
            (identical(other.targetIds, targetIds) ||
                const DeepCollectionEquality()
                    .equals(other.targetIds, targetIds)) &&
            (identical(other.externalities, externalities) ||
                const DeepCollectionEquality()
                    .equals(other.externalities, externalities)) &&
            (identical(other.axis, axis) ||
                const DeepCollectionEquality().equals(other.axis, axis)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(viewName) ^
      const DeepCollectionEquality().hash(originalViewName) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(widgetType) ^
      const DeepCollectionEquality().hash(position) ^
      const DeepCollectionEquality().hash(visibility) ^
      const DeepCollectionEquality().hash(targetIds) ^
      const DeepCollectionEquality().hash(externalities) ^
      const DeepCollectionEquality().hash(axis);

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
      String name,
      required WidgetType widgetType,
      required WidgetPosition position,
      bool visibility,
      List<String> targetIds,
      Map<String, double>? externalities,
      Axis? axis}) = _$_WidgetDescription;
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

  /// Whether the key will be visible to the driver or not
  bool get visibility => throw _privateConstructorUsedError;
  @override

  /// Target widgets ids that will be affected when this widget activated
  List<String> get targetIds => throw _privateConstructorUsedError;
  @override

  /// External widgets that affect this widget normally "ListView"
  /// where String is the list id and the double is scroll percentage
  Map<String, double>? get externalities => throw _privateConstructorUsedError;
  @override

  /// When WidgetType is [view]
  Axis? get axis => throw _privateConstructorUsedError;
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
      {required double x,
      required double y,
      double? capturedDeviceWidth,
      double? capturedDeviceHeight}) {
    return _WidgetPosition(
      x: x,
      y: y,
      capturedDeviceWidth: capturedDeviceWidth,
      capturedDeviceHeight: capturedDeviceHeight,
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
  double get x => throw _privateConstructorUsedError;
  double get y => throw _privateConstructorUsedError;
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
      _$WidgetPositionCopyWithImpl<$Res>;
  $Res call(
      {double x,
      double y,
      double? capturedDeviceWidth,
      double? capturedDeviceHeight});
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
    Object? x = freezed,
    Object? y = freezed,
    Object? capturedDeviceWidth = freezed,
    Object? capturedDeviceHeight = freezed,
  }) {
    return _then(_value.copyWith(
      x: x == freezed
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      y: y == freezed
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
      capturedDeviceWidth: capturedDeviceWidth == freezed
          ? _value.capturedDeviceWidth
          : capturedDeviceWidth // ignore: cast_nullable_to_non_nullable
              as double?,
      capturedDeviceHeight: capturedDeviceHeight == freezed
          ? _value.capturedDeviceHeight
          : capturedDeviceHeight // ignore: cast_nullable_to_non_nullable
              as double?,
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
      {double x,
      double y,
      double? capturedDeviceWidth,
      double? capturedDeviceHeight});
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
    Object? x = freezed,
    Object? y = freezed,
    Object? capturedDeviceWidth = freezed,
    Object? capturedDeviceHeight = freezed,
  }) {
    return _then(_WidgetPosition(
      x: x == freezed
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      y: y == freezed
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
      capturedDeviceWidth: capturedDeviceWidth == freezed
          ? _value.capturedDeviceWidth
          : capturedDeviceWidth // ignore: cast_nullable_to_non_nullable
              as double?,
      capturedDeviceHeight: capturedDeviceHeight == freezed
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
      this.capturedDeviceWidth,
      this.capturedDeviceHeight});

  factory _$_WidgetPosition.fromJson(Map<String, dynamic> json) =>
      _$$_WidgetPositionFromJson(json);

  @override
  final double x;
  @override
  final double y;
  @override
  final double? capturedDeviceWidth;
  @override
  final double? capturedDeviceHeight;

  @override
  String toString() {
    return 'WidgetPosition(x: $x, y: $y, capturedDeviceWidth: $capturedDeviceWidth, capturedDeviceHeight: $capturedDeviceHeight)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _WidgetPosition &&
            (identical(other.x, x) ||
                const DeepCollectionEquality().equals(other.x, x)) &&
            (identical(other.y, y) ||
                const DeepCollectionEquality().equals(other.y, y)) &&
            (identical(other.capturedDeviceWidth, capturedDeviceWidth) ||
                const DeepCollectionEquality()
                    .equals(other.capturedDeviceWidth, capturedDeviceWidth)) &&
            (identical(other.capturedDeviceHeight, capturedDeviceHeight) ||
                const DeepCollectionEquality()
                    .equals(other.capturedDeviceHeight, capturedDeviceHeight)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(x) ^
      const DeepCollectionEquality().hash(y) ^
      const DeepCollectionEquality().hash(capturedDeviceWidth) ^
      const DeepCollectionEquality().hash(capturedDeviceHeight);

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
      {required double x,
      required double y,
      double? capturedDeviceWidth,
      double? capturedDeviceHeight}) = _$_WidgetPosition;

  factory _WidgetPosition.fromJson(Map<String, dynamic> json) =
      _$_WidgetPosition.fromJson;

  @override
  double get x => throw _privateConstructorUsedError;
  @override
  double get y => throw _privateConstructorUsedError;
  @override
  double? get capturedDeviceWidth => throw _privateConstructorUsedError;
  @override
  double? get capturedDeviceHeight => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$WidgetPositionCopyWith<_WidgetPosition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$ScrollableDescriptionTearOff {
  const _$ScrollableDescriptionTearOff();

  _ScrollableDescription call(
      {required Axis axis,
      required Rect rect,
      required double scrollOffsetOnCapture,
      required double maxScrollOffset}) {
    return _ScrollableDescription(
      axis: axis,
      rect: rect,
      scrollOffsetOnCapture: scrollOffsetOnCapture,
      maxScrollOffset: maxScrollOffset,
    );
  }
}

/// @nodoc
const $ScrollableDescription = _$ScrollableDescriptionTearOff();

/// @nodoc
mixin _$ScrollableDescription {
  Axis get axis => throw _privateConstructorUsedError;
  Rect get rect => throw _privateConstructorUsedError;
  double get scrollOffsetOnCapture => throw _privateConstructorUsedError;
  double get maxScrollOffset => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ScrollableDescriptionCopyWith<ScrollableDescription> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScrollableDescriptionCopyWith<$Res> {
  factory $ScrollableDescriptionCopyWith(ScrollableDescription value,
          $Res Function(ScrollableDescription) then) =
      _$ScrollableDescriptionCopyWithImpl<$Res>;
  $Res call(
      {Axis axis,
      Rect rect,
      double scrollOffsetOnCapture,
      double maxScrollOffset});
}

/// @nodoc
class _$ScrollableDescriptionCopyWithImpl<$Res>
    implements $ScrollableDescriptionCopyWith<$Res> {
  _$ScrollableDescriptionCopyWithImpl(this._value, this._then);

  final ScrollableDescription _value;
  // ignore: unused_field
  final $Res Function(ScrollableDescription) _then;

  @override
  $Res call({
    Object? axis = freezed,
    Object? rect = freezed,
    Object? scrollOffsetOnCapture = freezed,
    Object? maxScrollOffset = freezed,
  }) {
    return _then(_value.copyWith(
      axis: axis == freezed
          ? _value.axis
          : axis // ignore: cast_nullable_to_non_nullable
              as Axis,
      rect: rect == freezed
          ? _value.rect
          : rect // ignore: cast_nullable_to_non_nullable
              as Rect,
      scrollOffsetOnCapture: scrollOffsetOnCapture == freezed
          ? _value.scrollOffsetOnCapture
          : scrollOffsetOnCapture // ignore: cast_nullable_to_non_nullable
              as double,
      maxScrollOffset: maxScrollOffset == freezed
          ? _value.maxScrollOffset
          : maxScrollOffset // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
abstract class _$ScrollableDescriptionCopyWith<$Res>
    implements $ScrollableDescriptionCopyWith<$Res> {
  factory _$ScrollableDescriptionCopyWith(_ScrollableDescription value,
          $Res Function(_ScrollableDescription) then) =
      __$ScrollableDescriptionCopyWithImpl<$Res>;
  @override
  $Res call(
      {Axis axis,
      Rect rect,
      double scrollOffsetOnCapture,
      double maxScrollOffset});
}

/// @nodoc
class __$ScrollableDescriptionCopyWithImpl<$Res>
    extends _$ScrollableDescriptionCopyWithImpl<$Res>
    implements _$ScrollableDescriptionCopyWith<$Res> {
  __$ScrollableDescriptionCopyWithImpl(_ScrollableDescription _value,
      $Res Function(_ScrollableDescription) _then)
      : super(_value, (v) => _then(v as _ScrollableDescription));

  @override
  _ScrollableDescription get _value => super._value as _ScrollableDescription;

  @override
  $Res call({
    Object? axis = freezed,
    Object? rect = freezed,
    Object? scrollOffsetOnCapture = freezed,
    Object? maxScrollOffset = freezed,
  }) {
    return _then(_ScrollableDescription(
      axis: axis == freezed
          ? _value.axis
          : axis // ignore: cast_nullable_to_non_nullable
              as Axis,
      rect: rect == freezed
          ? _value.rect
          : rect // ignore: cast_nullable_to_non_nullable
              as Rect,
      scrollOffsetOnCapture: scrollOffsetOnCapture == freezed
          ? _value.scrollOffsetOnCapture
          : scrollOffsetOnCapture // ignore: cast_nullable_to_non_nullable
              as double,
      maxScrollOffset: maxScrollOffset == freezed
          ? _value.maxScrollOffset
          : maxScrollOffset // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$_ScrollableDescription implements _ScrollableDescription {
  _$_ScrollableDescription(
      {required this.axis,
      required this.rect,
      required this.scrollOffsetOnCapture,
      required this.maxScrollOffset});

  @override
  final Axis axis;
  @override
  final Rect rect;
  @override
  final double scrollOffsetOnCapture;
  @override
  final double maxScrollOffset;

  @override
  String toString() {
    return 'ScrollableDescription(axis: $axis, rect: $rect, scrollOffsetOnCapture: $scrollOffsetOnCapture, maxScrollOffset: $maxScrollOffset)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ScrollableDescription &&
            (identical(other.axis, axis) ||
                const DeepCollectionEquality().equals(other.axis, axis)) &&
            (identical(other.rect, rect) ||
                const DeepCollectionEquality().equals(other.rect, rect)) &&
            (identical(other.scrollOffsetOnCapture, scrollOffsetOnCapture) ||
                const DeepCollectionEquality().equals(
                    other.scrollOffsetOnCapture, scrollOffsetOnCapture)) &&
            (identical(other.maxScrollOffset, maxScrollOffset) ||
                const DeepCollectionEquality()
                    .equals(other.maxScrollOffset, maxScrollOffset)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(axis) ^
      const DeepCollectionEquality().hash(rect) ^
      const DeepCollectionEquality().hash(scrollOffsetOnCapture) ^
      const DeepCollectionEquality().hash(maxScrollOffset);

  @JsonKey(ignore: true)
  @override
  _$ScrollableDescriptionCopyWith<_ScrollableDescription> get copyWith =>
      __$ScrollableDescriptionCopyWithImpl<_ScrollableDescription>(
          this, _$identity);
}

abstract class _ScrollableDescription implements ScrollableDescription {
  factory _ScrollableDescription(
      {required Axis axis,
      required Rect rect,
      required double scrollOffsetOnCapture,
      required double maxScrollOffset}) = _$_ScrollableDescription;

  @override
  Axis get axis => throw _privateConstructorUsedError;
  @override
  Rect get rect => throw _privateConstructorUsedError;
  @override
  double get scrollOffsetOnCapture => throw _privateConstructorUsedError;
  @override
  double get maxScrollOffset => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ScrollableDescriptionCopyWith<_ScrollableDescription> get copyWith =>
      throw _privateConstructorUsedError;
}
