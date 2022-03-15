import 'dart:core';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/extensions/widget_type_extension.dart';

part 'application_models.freezed.dart';
part 'application_models.g.dart';

/// Describes a widget that we will use to driver the app with
@freezed
class Interaction with _$Interaction {
  const Interaction._();

  factory Interaction({
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

    /// Left-top offset for external widgets that affects this widget
    /// (normally ListViews)
    Set<SerializableRect>? externalities,
  }) = _Interaction;
  factory Interaction.view(
          {required String viewName, required String originalViewName}) =>
      Interaction(
        viewName: viewName,
        originalViewName: originalViewName,
        widgetType: WidgetType.view,
        position: WidgetPosition.empty(),
      );

  factory Interaction.fromJson(Map<String, dynamic> json) =>
      _$InteractionFromJson(json);

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
    required SerializableRect scrollableWidgetRect,
    required double scrollExtentByPixels,
    required double maxScrollExtent,
  }) = _ScrollableDescription;

  factory ScrollableDescription.fromNotification({
    required Offset globalPosition,
    required Offset localPosition,
    required ScrollDirection scrollDirection,
    required ScrollMetrics metrics,
  }) {
    final position = -metrics.extentBefore;
    final topLeftPointOfList = globalPosition - localPosition;

    return ScrollableDescription(
        axis: metrics.axis,
        scrollableWidgetRect: SerializableRect.fromLTWH(
            topLeftPointOfList.dx, topLeftPointOfList.dy, 0, 0),
        scrollExtentByPixels: position,
        maxScrollExtent: metrics.maxScrollExtent);
  }
}

class SerializableRect extends Rect {
  const SerializableRect.fromLTWH(
      double left, double top, double width, double height)
      : super.fromLTWH(left, top, width, height);
  const SerializableRect.fromLTRB(
      double left, double top, double right, double bottom)
      : super.fromLTRB(left, top, right, bottom);
  SerializableRect.fromPoints(Offset a, Offset b) : super.fromPoints(a, b);
  factory SerializableRect.fromJson(Map<String, double> json) {
    return SerializableRect.fromLTWH(
        json['left']!, json['top']!, json['width']!, json['height']!);
  }
  Map<String, double> toJson() {
    return {'left': left, 'top': top, 'width': width, 'height': height};
  }
}
