// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scrollable_description.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
