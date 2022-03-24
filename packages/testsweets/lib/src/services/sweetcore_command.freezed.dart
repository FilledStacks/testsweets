// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'sweetcore_command.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$SweetcoreCommandTearOff {
  const _$SweetcoreCommandTearOff();

  ScrollableCommand scrollable({required String widgetName}) {
    return ScrollableCommand(
      widgetName: widgetName,
    );
  }
}

/// @nodoc
const $SweetcoreCommand = _$SweetcoreCommandTearOff();

/// @nodoc
mixin _$SweetcoreCommand {
  String get widgetName => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String widgetName) scrollable,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String widgetName)? scrollable,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String widgetName)? scrollable,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ScrollableCommand value) scrollable,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ScrollableCommand value)? scrollable,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ScrollableCommand value)? scrollable,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SweetcoreCommandCopyWith<SweetcoreCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SweetcoreCommandCopyWith<$Res> {
  factory $SweetcoreCommandCopyWith(
          SweetcoreCommand value, $Res Function(SweetcoreCommand) then) =
      _$SweetcoreCommandCopyWithImpl<$Res>;
  $Res call({String widgetName});
}

/// @nodoc
class _$SweetcoreCommandCopyWithImpl<$Res>
    implements $SweetcoreCommandCopyWith<$Res> {
  _$SweetcoreCommandCopyWithImpl(this._value, this._then);

  final SweetcoreCommand _value;
  // ignore: unused_field
  final $Res Function(SweetcoreCommand) _then;

  @override
  $Res call({
    Object? widgetName = freezed,
  }) {
    return _then(_value.copyWith(
      widgetName: widgetName == freezed
          ? _value.widgetName
          : widgetName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class $ScrollableCommandCopyWith<$Res>
    implements $SweetcoreCommandCopyWith<$Res> {
  factory $ScrollableCommandCopyWith(
          ScrollableCommand value, $Res Function(ScrollableCommand) then) =
      _$ScrollableCommandCopyWithImpl<$Res>;
  @override
  $Res call({String widgetName});
}

/// @nodoc
class _$ScrollableCommandCopyWithImpl<$Res>
    extends _$SweetcoreCommandCopyWithImpl<$Res>
    implements $ScrollableCommandCopyWith<$Res> {
  _$ScrollableCommandCopyWithImpl(
      ScrollableCommand _value, $Res Function(ScrollableCommand) _then)
      : super(_value, (v) => _then(v as ScrollableCommand));

  @override
  ScrollableCommand get _value => super._value as ScrollableCommand;

  @override
  $Res call({
    Object? widgetName = freezed,
  }) {
    return _then(ScrollableCommand(
      widgetName: widgetName == freezed
          ? _value.widgetName
          : widgetName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ScrollableCommand extends ScrollableCommand {
  _$ScrollableCommand({required this.widgetName}) : super._();

  @override
  final String widgetName;

  @override
  String toString() {
    return 'SweetcoreCommand.scrollable(widgetName: $widgetName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ScrollableCommand &&
            const DeepCollectionEquality()
                .equals(other.widgetName, widgetName));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(widgetName));

  @JsonKey(ignore: true)
  @override
  $ScrollableCommandCopyWith<ScrollableCommand> get copyWith =>
      _$ScrollableCommandCopyWithImpl<ScrollableCommand>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String widgetName) scrollable,
  }) {
    return scrollable(widgetName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String widgetName)? scrollable,
  }) {
    return scrollable?.call(widgetName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String widgetName)? scrollable,
    required TResult orElse(),
  }) {
    if (scrollable != null) {
      return scrollable(widgetName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ScrollableCommand value) scrollable,
  }) {
    return scrollable(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ScrollableCommand value)? scrollable,
  }) {
    return scrollable?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ScrollableCommand value)? scrollable,
    required TResult orElse(),
  }) {
    if (scrollable != null) {
      return scrollable(this);
    }
    return orElse();
  }
}

abstract class ScrollableCommand extends SweetcoreCommand {
  factory ScrollableCommand({required String widgetName}) = _$ScrollableCommand;
  ScrollableCommand._() : super._();

  @override
  String get widgetName;
  @override
  @JsonKey(ignore: true)
  $ScrollableCommandCopyWith<ScrollableCommand> get copyWith =>
      throw _privateConstructorUsedError;
}
