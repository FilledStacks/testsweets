// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'application_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Interaction _$InteractionFromJson(Map<String, dynamic> json) {
  return _Interaction.fromJson(json);
}

/// @nodoc
mixin _$Interaction {
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

  /// Left-top offset for external widgets that affects this widget
  /// (normally ListViews)
  Set<ScrollableDescription>? get externalities =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InteractionCopyWith<Interaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InteractionCopyWith<$Res> {
  factory $InteractionCopyWith(
          Interaction value, $Res Function(Interaction) then) =
      _$InteractionCopyWithImpl<$Res, Interaction>;
  @useResult
  $Res call(
      {String? id,
      String viewName,
      String originalViewName,
      String name,
      WidgetType widgetType,
      WidgetPosition position,
      bool visibility,
      List<String> targetIds,
      Set<ScrollableDescription>? externalities});

  $WidgetPositionCopyWith<$Res> get position;
}

/// @nodoc
class _$InteractionCopyWithImpl<$Res, $Val extends Interaction>
    implements $InteractionCopyWith<$Res> {
  _$InteractionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? viewName = null,
    Object? originalViewName = null,
    Object? name = null,
    Object? widgetType = null,
    Object? position = null,
    Object? visibility = null,
    Object? targetIds = null,
    Object? externalities = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      viewName: null == viewName
          ? _value.viewName
          : viewName // ignore: cast_nullable_to_non_nullable
              as String,
      originalViewName: null == originalViewName
          ? _value.originalViewName
          : originalViewName // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      widgetType: null == widgetType
          ? _value.widgetType
          : widgetType // ignore: cast_nullable_to_non_nullable
              as WidgetType,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as WidgetPosition,
      visibility: null == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as bool,
      targetIds: null == targetIds
          ? _value.targetIds
          : targetIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      externalities: freezed == externalities
          ? _value.externalities
          : externalities // ignore: cast_nullable_to_non_nullable
              as Set<ScrollableDescription>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $WidgetPositionCopyWith<$Res> get position {
    return $WidgetPositionCopyWith<$Res>(_value.position, (value) {
      return _then(_value.copyWith(position: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_InteractionCopyWith<$Res>
    implements $InteractionCopyWith<$Res> {
  factory _$$_InteractionCopyWith(
          _$_Interaction value, $Res Function(_$_Interaction) then) =
      __$$_InteractionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String viewName,
      String originalViewName,
      String name,
      WidgetType widgetType,
      WidgetPosition position,
      bool visibility,
      List<String> targetIds,
      Set<ScrollableDescription>? externalities});

  @override
  $WidgetPositionCopyWith<$Res> get position;
}

/// @nodoc
class __$$_InteractionCopyWithImpl<$Res>
    extends _$InteractionCopyWithImpl<$Res, _$_Interaction>
    implements _$$_InteractionCopyWith<$Res> {
  __$$_InteractionCopyWithImpl(
      _$_Interaction _value, $Res Function(_$_Interaction) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? viewName = null,
    Object? originalViewName = null,
    Object? name = null,
    Object? widgetType = null,
    Object? position = null,
    Object? visibility = null,
    Object? targetIds = null,
    Object? externalities = freezed,
  }) {
    return _then(_$_Interaction(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      viewName: null == viewName
          ? _value.viewName
          : viewName // ignore: cast_nullable_to_non_nullable
              as String,
      originalViewName: null == originalViewName
          ? _value.originalViewName
          : originalViewName // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      widgetType: null == widgetType
          ? _value.widgetType
          : widgetType // ignore: cast_nullable_to_non_nullable
              as WidgetType,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as WidgetPosition,
      visibility: null == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as bool,
      targetIds: null == targetIds
          ? _value._targetIds
          : targetIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      externalities: freezed == externalities
          ? _value._externalities
          : externalities // ignore: cast_nullable_to_non_nullable
              as Set<ScrollableDescription>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Interaction extends _Interaction {
  _$_Interaction(
      {this.id,
      required this.viewName,
      required this.originalViewName,
      this.name = '',
      required this.widgetType,
      required this.position,
      this.visibility = true,
      final List<String> targetIds = const [],
      final Set<ScrollableDescription>? externalities})
      : _targetIds = targetIds,
        _externalities = externalities,
        super._();

  factory _$_Interaction.fromJson(Map<String, dynamic> json) =>
      _$$_InteractionFromJson(json);

  /// The Id from the firebase backend
  @override
  final String? id;

  /// The name of the view this widget was captured on
  @override
  final String viewName;

  /// The orignal name of the view this widget was captured on before the prettify
  @override
  final String originalViewName;

  /// The name we want to use when referring to the widget in the scripts
  @override
  @JsonKey()
  final String name;

  /// The type of the widget that's being added
  @override
  final WidgetType widgetType;

  /// The position we defined for he widget
  @override
  final WidgetPosition position;

  /// Whether the key will be visible to the driver or not
  @override
  @JsonKey()
  final bool visibility;

  /// Target widgets ids that will be affected when this widget activated
  final List<String> _targetIds;

  /// Target widgets ids that will be affected when this widget activated
  @override
  @JsonKey()
  List<String> get targetIds {
    if (_targetIds is EqualUnmodifiableListView) return _targetIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_targetIds);
  }

  /// Left-top offset for external widgets that affects this widget
  /// (normally ListViews)
  final Set<ScrollableDescription>? _externalities;

  /// Left-top offset for external widgets that affects this widget
  /// (normally ListViews)
  @override
  Set<ScrollableDescription>? get externalities {
    final value = _externalities;
    if (value == null) return null;
    if (_externalities is EqualUnmodifiableSetView) return _externalities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(value);
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Interaction &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.viewName, viewName) ||
                other.viewName == viewName) &&
            (identical(other.originalViewName, originalViewName) ||
                other.originalViewName == originalViewName) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.widgetType, widgetType) ||
                other.widgetType == widgetType) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.visibility, visibility) ||
                other.visibility == visibility) &&
            const DeepCollectionEquality()
                .equals(other._targetIds, _targetIds) &&
            const DeepCollectionEquality()
                .equals(other._externalities, _externalities));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      viewName,
      originalViewName,
      name,
      widgetType,
      position,
      visibility,
      const DeepCollectionEquality().hash(_targetIds),
      const DeepCollectionEquality().hash(_externalities));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InteractionCopyWith<_$_Interaction> get copyWith =>
      __$$_InteractionCopyWithImpl<_$_Interaction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InteractionToJson(
      this,
    );
  }
}

abstract class _Interaction extends Interaction {
  factory _Interaction(
      {final String? id,
      required final String viewName,
      required final String originalViewName,
      final String name,
      required final WidgetType widgetType,
      required final WidgetPosition position,
      final bool visibility,
      final List<String> targetIds,
      final Set<ScrollableDescription>? externalities}) = _$_Interaction;
  _Interaction._() : super._();

  factory _Interaction.fromJson(Map<String, dynamic> json) =
      _$_Interaction.fromJson;

  @override

  /// The Id from the firebase backend
  String? get id;
  @override

  /// The name of the view this widget was captured on
  String get viewName;
  @override

  /// The orignal name of the view this widget was captured on before the prettify
  String get originalViewName;
  @override

  /// The name we want to use when referring to the widget in the scripts
  String get name;
  @override

  /// The type of the widget that's being added
  WidgetType get widgetType;
  @override

  /// The position we defined for he widget
  WidgetPosition get position;
  @override

  /// Whether the key will be visible to the driver or not
  bool get visibility;
  @override

  /// Target widgets ids that will be affected when this widget activated
  List<String> get targetIds;
  @override

  /// Left-top offset for external widgets that affects this widget
  /// (normally ListViews)
  Set<ScrollableDescription>? get externalities;
  @override
  @JsonKey(ignore: true)
  _$$_InteractionCopyWith<_$_Interaction> get copyWith =>
      throw _privateConstructorUsedError;
}

WidgetPosition _$WidgetPositionFromJson(Map<String, dynamic> json) {
  return _WidgetPosition.fromJson(json);
}

/// @nodoc
mixin _$WidgetPosition {
  double get x => throw _privateConstructorUsedError;
  double get y => throw _privateConstructorUsedError;
  double? get capturedDeviceWidth => throw _privateConstructorUsedError;
  double? get capturedDeviceHeight => throw _privateConstructorUsedError;
  double? get xDeviation => throw _privateConstructorUsedError;
  double? get yDeviation => throw _privateConstructorUsedError;

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
      double? capturedDeviceWidth,
      double? capturedDeviceHeight,
      double? xDeviation,
      double? yDeviation});
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
    Object? capturedDeviceWidth = freezed,
    Object? capturedDeviceHeight = freezed,
    Object? xDeviation = freezed,
    Object? yDeviation = freezed,
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
      capturedDeviceWidth: freezed == capturedDeviceWidth
          ? _value.capturedDeviceWidth
          : capturedDeviceWidth // ignore: cast_nullable_to_non_nullable
              as double?,
      capturedDeviceHeight: freezed == capturedDeviceHeight
          ? _value.capturedDeviceHeight
          : capturedDeviceHeight // ignore: cast_nullable_to_non_nullable
              as double?,
      xDeviation: freezed == xDeviation
          ? _value.xDeviation
          : xDeviation // ignore: cast_nullable_to_non_nullable
              as double?,
      yDeviation: freezed == yDeviation
          ? _value.yDeviation
          : yDeviation // ignore: cast_nullable_to_non_nullable
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
      double? capturedDeviceWidth,
      double? capturedDeviceHeight,
      double? xDeviation,
      double? yDeviation});
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
    Object? capturedDeviceWidth = freezed,
    Object? capturedDeviceHeight = freezed,
    Object? xDeviation = freezed,
    Object? yDeviation = freezed,
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
      capturedDeviceWidth: freezed == capturedDeviceWidth
          ? _value.capturedDeviceWidth
          : capturedDeviceWidth // ignore: cast_nullable_to_non_nullable
              as double?,
      capturedDeviceHeight: freezed == capturedDeviceHeight
          ? _value.capturedDeviceHeight
          : capturedDeviceHeight // ignore: cast_nullable_to_non_nullable
              as double?,
      xDeviation: freezed == xDeviation
          ? _value.xDeviation
          : xDeviation // ignore: cast_nullable_to_non_nullable
              as double?,
      yDeviation: freezed == yDeviation
          ? _value.yDeviation
          : yDeviation // ignore: cast_nullable_to_non_nullable
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
      this.capturedDeviceHeight,
      this.xDeviation,
      this.yDeviation});

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
  final double? xDeviation;
  @override
  final double? yDeviation;

  @override
  String toString() {
    return 'WidgetPosition(x: $x, y: $y, capturedDeviceWidth: $capturedDeviceWidth, capturedDeviceHeight: $capturedDeviceHeight, xDeviation: $xDeviation, yDeviation: $yDeviation)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WidgetPosition &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y) &&
            (identical(other.capturedDeviceWidth, capturedDeviceWidth) ||
                other.capturedDeviceWidth == capturedDeviceWidth) &&
            (identical(other.capturedDeviceHeight, capturedDeviceHeight) ||
                other.capturedDeviceHeight == capturedDeviceHeight) &&
            (identical(other.xDeviation, xDeviation) ||
                other.xDeviation == xDeviation) &&
            (identical(other.yDeviation, yDeviation) ||
                other.yDeviation == yDeviation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, x, y, capturedDeviceWidth,
      capturedDeviceHeight, xDeviation, yDeviation);

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
      final double? capturedDeviceWidth,
      final double? capturedDeviceHeight,
      final double? xDeviation,
      final double? yDeviation}) = _$_WidgetPosition;

  factory _WidgetPosition.fromJson(Map<String, dynamic> json) =
      _$_WidgetPosition.fromJson;

  @override
  double get x;
  @override
  double get y;
  @override
  double? get capturedDeviceWidth;
  @override
  double? get capturedDeviceHeight;
  @override
  double? get xDeviation;
  @override
  double? get yDeviation;
  @override
  @JsonKey(ignore: true)
  _$$_WidgetPositionCopyWith<_$_WidgetPosition> get copyWith =>
      throw _privateConstructorUsedError;
}

ScrollableDescription _$ScrollableDescriptionFromJson(
    Map<String, dynamic> json) {
  return _ScrollableDescription.fromJson(json);
}

/// @nodoc
mixin _$ScrollableDescription {
  Axis get axis => throw _privateConstructorUsedError;
  SerializableRect get rect => throw _privateConstructorUsedError;
  double get scrollExtentByPixels => throw _privateConstructorUsedError;
  double get maxScrollExtentByPixels => throw _privateConstructorUsedError;
  bool get nested => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScrollableDescriptionCopyWith<ScrollableDescription> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScrollableDescriptionCopyWith<$Res> {
  factory $ScrollableDescriptionCopyWith(ScrollableDescription value,
          $Res Function(ScrollableDescription) then) =
      _$ScrollableDescriptionCopyWithImpl<$Res, ScrollableDescription>;
  @useResult
  $Res call(
      {Axis axis,
      SerializableRect rect,
      double scrollExtentByPixels,
      double maxScrollExtentByPixels,
      bool nested});
}

/// @nodoc
class _$ScrollableDescriptionCopyWithImpl<$Res,
        $Val extends ScrollableDescription>
    implements $ScrollableDescriptionCopyWith<$Res> {
  _$ScrollableDescriptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? axis = null,
    Object? rect = null,
    Object? scrollExtentByPixels = null,
    Object? maxScrollExtentByPixels = null,
    Object? nested = null,
  }) {
    return _then(_value.copyWith(
      axis: null == axis
          ? _value.axis
          : axis // ignore: cast_nullable_to_non_nullable
              as Axis,
      rect: null == rect
          ? _value.rect
          : rect // ignore: cast_nullable_to_non_nullable
              as SerializableRect,
      scrollExtentByPixels: null == scrollExtentByPixels
          ? _value.scrollExtentByPixels
          : scrollExtentByPixels // ignore: cast_nullable_to_non_nullable
              as double,
      maxScrollExtentByPixels: null == maxScrollExtentByPixels
          ? _value.maxScrollExtentByPixels
          : maxScrollExtentByPixels // ignore: cast_nullable_to_non_nullable
              as double,
      nested: null == nested
          ? _value.nested
          : nested // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ScrollableDescriptionCopyWith<$Res>
    implements $ScrollableDescriptionCopyWith<$Res> {
  factory _$$_ScrollableDescriptionCopyWith(_$_ScrollableDescription value,
          $Res Function(_$_ScrollableDescription) then) =
      __$$_ScrollableDescriptionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Axis axis,
      SerializableRect rect,
      double scrollExtentByPixels,
      double maxScrollExtentByPixels,
      bool nested});
}

/// @nodoc
class __$$_ScrollableDescriptionCopyWithImpl<$Res>
    extends _$ScrollableDescriptionCopyWithImpl<$Res, _$_ScrollableDescription>
    implements _$$_ScrollableDescriptionCopyWith<$Res> {
  __$$_ScrollableDescriptionCopyWithImpl(_$_ScrollableDescription _value,
      $Res Function(_$_ScrollableDescription) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? axis = null,
    Object? rect = null,
    Object? scrollExtentByPixels = null,
    Object? maxScrollExtentByPixels = null,
    Object? nested = null,
  }) {
    return _then(_$_ScrollableDescription(
      axis: null == axis
          ? _value.axis
          : axis // ignore: cast_nullable_to_non_nullable
              as Axis,
      rect: null == rect
          ? _value.rect
          : rect // ignore: cast_nullable_to_non_nullable
              as SerializableRect,
      scrollExtentByPixels: null == scrollExtentByPixels
          ? _value.scrollExtentByPixels
          : scrollExtentByPixels // ignore: cast_nullable_to_non_nullable
              as double,
      maxScrollExtentByPixels: null == maxScrollExtentByPixels
          ? _value.maxScrollExtentByPixels
          : maxScrollExtentByPixels // ignore: cast_nullable_to_non_nullable
              as double,
      nested: null == nested
          ? _value.nested
          : nested // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ScrollableDescription implements _ScrollableDescription {
  _$_ScrollableDescription(
      {required this.axis,
      required this.rect,
      required this.scrollExtentByPixels,
      required this.maxScrollExtentByPixels,
      this.nested = false});

  factory _$_ScrollableDescription.fromJson(Map<String, dynamic> json) =>
      _$$_ScrollableDescriptionFromJson(json);

  @override
  final Axis axis;
  @override
  final SerializableRect rect;
  @override
  final double scrollExtentByPixels;
  @override
  final double maxScrollExtentByPixels;
  @override
  @JsonKey()
  final bool nested;

  @override
  String toString() {
    return 'ScrollableDescription(axis: $axis, rect: $rect, scrollExtentByPixels: $scrollExtentByPixels, maxScrollExtentByPixels: $maxScrollExtentByPixels, nested: $nested)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ScrollableDescription &&
            (identical(other.axis, axis) || other.axis == axis) &&
            (identical(other.rect, rect) || other.rect == rect) &&
            (identical(other.scrollExtentByPixels, scrollExtentByPixels) ||
                other.scrollExtentByPixels == scrollExtentByPixels) &&
            (identical(
                    other.maxScrollExtentByPixels, maxScrollExtentByPixels) ||
                other.maxScrollExtentByPixels == maxScrollExtentByPixels) &&
            (identical(other.nested, nested) || other.nested == nested));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, axis, rect, scrollExtentByPixels,
      maxScrollExtentByPixels, nested);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ScrollableDescriptionCopyWith<_$_ScrollableDescription> get copyWith =>
      __$$_ScrollableDescriptionCopyWithImpl<_$_ScrollableDescription>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ScrollableDescriptionToJson(
      this,
    );
  }
}

abstract class _ScrollableDescription implements ScrollableDescription {
  factory _ScrollableDescription(
      {required final Axis axis,
      required final SerializableRect rect,
      required final double scrollExtentByPixels,
      required final double maxScrollExtentByPixels,
      final bool nested}) = _$_ScrollableDescription;

  factory _ScrollableDescription.fromJson(Map<String, dynamic> json) =
      _$_ScrollableDescription.fromJson;

  @override
  Axis get axis;
  @override
  SerializableRect get rect;
  @override
  double get scrollExtentByPixels;
  @override
  double get maxScrollExtentByPixels;
  @override
  bool get nested;
  @override
  @JsonKey(ignore: true)
  _$$_ScrollableDescriptionCopyWith<_$_ScrollableDescription> get copyWith =>
      throw _privateConstructorUsedError;
}
