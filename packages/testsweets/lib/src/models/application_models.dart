import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/extensions/widget_type_string_extension.dart';

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
    String? viewName,

    /// The orignal name of the view this widget was captured on before the prettify
    String? originalViewName,

    /// The name we want to use when referring to the widget in the scripts
    @Default('') String name,

    /// The type of the widget that's being added
    WidgetType? widgetType,

    /// The position we defined for he widget
    WidgetPosition? position,

    /// Whether the key will be visible to the driver or not
    @Default(true) bool visibility,
  }) = _WidgetDescription;
  factory WidgetDescription.addView(
          {required String viewName, required String originalViewName}) =>
      WidgetDescription(
        viewName: viewName,
        originalViewName: originalViewName,
        widgetType: WidgetType.view,
      );

  factory WidgetDescription.fromJson(Map<String, dynamic> json) =>
      _$WidgetDescriptionFromJson(json);

  String get automationKey => widgetType == WidgetType.view
      ? '$viewName\_${widgetType!.shortName}'
      : '$viewName\_${widgetType!.shortName}\_$name';
}

/// The position of the widget as we captured it on device
@freezed
class WidgetPosition with _$WidgetPosition {
  factory WidgetPosition({
    required double x,
    required double y,
    double? capturedDeviceWidth,
    double? capturedDeviceHeight,
  }) = _WidgetPosition;
  factory WidgetPosition.empty() => WidgetPosition(x: 0, y: 0);
  factory WidgetPosition.fromJson(Map<String, dynamic> json) =>
      _$WidgetPositionFromJson(json);
}
