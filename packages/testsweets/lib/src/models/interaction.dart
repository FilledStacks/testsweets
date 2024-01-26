import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/testsweets.dart';

part 'interaction.freezed.dart';
part 'interaction.g.dart';

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
    Set<ScrollableDescription>? externalities,
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
      ? '$viewName\_${widgetType.name}'
      : '$viewName\_${widgetType.name}\_$name';

  @override
  String toString() {
    return '$name (${widgetType.name}): (${position.x}, ${position.y}) onSrollable:${externalities != null}';
  }

  bool hasDeviceDetailsForScreenSize({
    required Size size,
    required Orientation orientation,
  }) =>
      position.hasDeviceDetailsForScreenSize(
        width: size.width,
        height: size.height,
        orientation: orientation,
      );

  Interaction storeDeviceDetails({
    required Size size,
    required Orientation orientation,
  }) {
    final positionWithDeviceDetails = position.storeDeviceDetails(
      size: size,
      orientation: orientation,
    );

    return copyWith(position: positionWithDeviceDetails);
  }
}
