import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:testsweets/src/models/enums/widget_type.dart';

part 'application_models.freezed.dart';
part 'application_models.g.dart';

/// Describes a widget that we will use to driver the app with
@freezed
class WidgetDescription with _$WidgetDescription {
  const WidgetDescription._();

  factory WidgetDescription({
    /// The Id from the firebase backend
    String? id,

    /// The name of the view this widget was captured on
    required String viewName,

    /// The name we want to use when referring to the widget in the scripts
    required String name,

    /// The type of the widget that's being added
    required WidgetType widgetType,

    /// The position we defined for he widget
    required WidgetPosition position,
  }) = _WidgetDescription;

  factory WidgetDescription.positionOnly({required WidgetPosition position}) {
    return WidgetDescription(
        viewName: '',
        name: '',
        widgetType: WidgetType.touchable,
        position: position);
  }

  factory WidgetDescription.fromJson(Map<String, dynamic> json) =>
      _$WidgetDescriptionFromJson(json);

  String get automationKey => '$viewName\_$widgetType\_$name';
}

/// The position of the widget as we captured it on device
@freezed
class WidgetPosition with _$WidgetPosition {
  factory WidgetPosition({
    required double x,
    required double y,
  }) = _WidgetPosition;

  factory WidgetPosition.fromJson(Map<String, dynamic> json) =>
      _$WidgetPositionFromJson(json);
}
