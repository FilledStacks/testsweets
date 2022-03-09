import 'dart:core';

import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/extensions/widget_type_extension.dart';

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

    /// The orignal name of the view this widget was captured on before the prettify
    required String originalViewName,

    /// The name we want to use when referring to the widget in the scripts
    @Default('') String name,

    /// The type of the widget that's being added
    required WidgetType widgetType,

    /// The position we defined for he widget
    required WidgetPosition position,

    /// Whether the key will be visible to the driver or not
    @Default(true) bool visibility,

    /// Target widgets ids that will be affected when this widget activated
    @Default([]) List<String> targetIds,

    /// External widgets that affect this widget normally "ListView"
    /// where String is the list id and the double is scroll percentage
    @Default({}) Set<String> externalities,
  }) = _WidgetDescription;
  factory WidgetDescription.view(
          {required String viewName, required String originalViewName}) =>
      WidgetDescription(
        viewName: viewName,
        originalViewName: originalViewName,
        widgetType: WidgetType.view,
        position: WidgetPosition.empty(),
      );

  factory WidgetDescription.fromJson(Map<String, dynamic> json) =>
      _$WidgetDescriptionFromJson(json);

  String get automationKey => widgetType == WidgetType.view
      ? '$viewName\_${widgetType.shortName}'
      : '$viewName\_${widgetType.shortName}\_$name';
}

/// The position of the widget as we captured it on device
@freezed
class WidgetPosition with _$WidgetPosition {
  factory WidgetPosition({
    required double x,
    required double y,
    double? capturedDeviceWidth,
    double? capturedDeviceHeight,
    double? xTranlate,
    double? yTranlate,
  }) = _WidgetPosition;
  factory WidgetPosition.empty() => WidgetPosition(x: 0, y: 0);
  factory WidgetPosition.fromJson(Map<String, dynamic> json) =>
      _$WidgetPositionFromJson(json);
}

@freezed
class ScrollableDescription with _$ScrollableDescription {
  factory ScrollableDescription({
    required Axis axis,
    required Rect rect,
    required double scrollingPixelsOnCapture,
    required double maxScrollOffset,
  }) = _ScrollableDescription;
}
