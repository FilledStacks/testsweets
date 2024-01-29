import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/extensions/widget_positions_extension.dart';
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
    @Deprecated('Prefer using the new responsive position functionality')
    @Default(const WidgetPosition(
      x: 0,
      y: 0,
      capturedDeviceHeight: 0,
      capturedDeviceWidth: 0,
    ))
    WidgetPosition position,

    /// The positions this interaction point can take up depending on the screen size.
    ///
    /// When adjustments are made on a screen size different than what is already in here
    /// a new position is created with the details of the new capture size.
    @Default([]) List<WidgetPosition> widgetPositions,

    /// Whether the key will be visible to the driver or not
    @Default(true) bool visibility,

    /// Target widgets ids that will be affected when this widget activated
    @Default([]) List<String> targetIds,

    /// Left-top offset for external widgets that affects this widget
    /// (normally ListViews)
    Set<ScrollableDescription>? externalities,
  }) = _Interaction;

  factory Interaction.view({
    required String viewName,
    required String originalViewName,
  }) =>
      Interaction(
        viewName: viewName,
        originalViewName: originalViewName,
        widgetType: WidgetType.view,
        widgetPositions: [WidgetPosition.empty()],
      );

  factory Interaction.fromJson(Map<String, dynamic> json) =>
      _interactionWithMigration(json);

  static Interaction _interactionWithMigration(Map<String, dynamic> json) {
    return _Interaction.fromJson(json).migrate();
  }

  String get automationKey => widgetType == WidgetType.view
      ? '$viewName\_${widgetType.name}'
      : '$viewName\_${widgetType.name}\_$name';

  WidgetPosition get renderPosition =>
      widgetPositions.firstWhere((element) => element.active);

  @override
  String toString() {
    if (widgetPositions.any((element) => element.active)) {
      return '$name (${widgetType.name}): (${renderPosition.x}, ${renderPosition.y})\n';
    } else {
      return '$name (${widgetType.name}): Active position not set yet';
    }
  }

  /// Performs a migration using the [capturedDeviceWidth] and [capturedDeviceHeight]
  /// and returns a new [WidgetPosition] to be used in the place of the original.
  Interaction migrate() {
    print(
        // ignore: deprecated_member_use_from_same_package
        'Migrate: ${position.x},${position.y} size:${position.capturedDeviceWidth}, ${position.capturedDeviceHeight}');

    // ignore: deprecated_member_use_from_same_package
    final width = position.capturedDeviceWidth;
    // ignore: deprecated_member_use_from_same_package
    final height = position.capturedDeviceHeight;
    // ignore: deprecated_member_use_from_same_package
    final x = position.x;
    // ignore: deprecated_member_use_from_same_package
    final y = position.y;

    final orientation = _getOrientationFromSize(width: width, height: height);

    final matchingDeviceDetails = _getMatchingPositionForSizeAndOrientation(
      width: width,
      height: height,
      orientation: orientation,
    );

    final noPositionBucketForOriginalSize = matchingDeviceDetails == null;

    print(
        'noDeviceBucketForOriginalSize: $noPositionBucketForOriginalSize\n Current Positions: $widgetPositions');
    if (noPositionBucketForOriginalSize) {
      return copyWith(widgetPositions: [
        ...widgetPositions,
        WidgetPosition(
          x: x,
          y: y,
          capturedDeviceWidth: width,
          capturedDeviceHeight: height,
          orientation: orientation,
        )
      ]);
    }

    return this;
  }

  bool hasDeviceDetailsForScreenSize({
    required double width,
    required double height,
    required Orientation orientation,
  }) {
    final matchingDeviceSize = _getMatchingPositionForSizeAndOrientation(
      width: width,
      height: height,
      orientation: orientation,
    );

    return matchingDeviceSize != null;
  }

  Interaction setActivePosition({
    required Size size,
    required Orientation orientation,
  }) {
    final savedPositions = List<WidgetPosition>.from(widgetPositions);

    List<WidgetPosition> listToReturn;

    final positionsForSpecificOrientation = savedPositions
        .where((widgetPosition) => widgetPosition.orientation == orientation);

    final hasPositionsForOrientation =
        positionsForSpecificOrientation.isNotEmpty;

    if (hasPositionsForOrientation) {
      listToReturn = _setActivePositionInList(
        positionsToModify: positionsForSpecificOrientation.toList(),
        size: size,
      );
    } else {
      listToReturn = _setActivePositionInList(
        positionsToModify: savedPositions,
        size: size,
      );
    }

    return copyWith(widgetPositions: listToReturn);
  }

  Interaction addNewScreenDetailsAndPosition({
    required double x,
    required double y,
    required double width,
    required double height,
    required Orientation orientation,
  }) {
    return copyWith(widgetPositions: [
      ...widgetPositions.map((e) => e.copyWith(active: false)),
      WidgetPosition(
        x: x,
        y: y,
        capturedDeviceWidth: width,
        capturedDeviceHeight: height,
        orientation: orientation,
        active: true,
      )
    ]);
  }

  Interaction updatePosition({
    required double x,
    required double y,
    required double currentWidth,
    required double currentHeight,
    required Orientation orientation,
  }) {
    final mutablePositions = List<WidgetPosition>.from(widgetPositions);
    final positionIndex = mutablePositions.indexOf(renderPosition);

    final bool hasDeviceDetailsForCurrentScreenSize =
        hasDeviceDetailsForScreenSize(
      width: currentWidth,
      height: currentHeight,
      orientation: orientation,
    );

    if (!hasDeviceDetailsForCurrentScreenSize) {
      for (int i = 0; i < mutablePositions.length; i++) {
        mutablePositions[i] = mutablePositions[i].copyWith(active: false);
      }

      mutablePositions.add(WidgetPosition(
        x: x,
        y: y,
        capturedDeviceWidth: currentWidth,
        capturedDeviceHeight: currentHeight,
        orientation: orientation,
        active: true,
      ));
    } else {
      mutablePositions[positionIndex] = renderPosition.copyWith(x: x, y: y);
    }

    return copyWith(widgetPositions: mutablePositions);
  }

  Orientation _getOrientationFromSize(
      {required double width, required double height}) {
    return height > width ? Orientation.portrait : Orientation.landscape;
  }

  WidgetPosition? _getMatchingPositionForSizeAndOrientation({
    required double width,
    required double height,
    required Orientation orientation,
  }) {
    final matchingDeviceDetails = widgetPositions.where(
      (details) =>
          details.capturedDeviceWidth == width &&
          details.capturedDeviceHeight == height &&
          details.orientation == orientation,
    );

    if (matchingDeviceDetails.isNotEmpty) {
      return matchingDeviceDetails.first;
    }

    return null;
  }

  List<WidgetPosition> _setActivePositionInList({
    required List<WidgetPosition> positionsToModify,
    required Size size,
  }) {
    final closestMatchingPosition =
        positionsToModify.getClosestWidgetBasedOnScreeSize(
      size,
    );

    final indexToUpdate = positionsToModify.indexOf(closestMatchingPosition);

    positionsToModify[indexToUpdate] = closestMatchingPosition.copyWith(
      active: true,
    );

    return positionsToModify;
  }
}
