// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'interaction.dart';

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
