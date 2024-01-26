import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:testsweets/src/models/device_details.dart';

part 'widget_position.freezed.dart';
part 'widget_position.g.dart';

/// The position of the widget as we captured it on device
@freezed
class WidgetPosition with _$WidgetPosition {
  WidgetPosition._();

  factory WidgetPosition({
    required double x,
    required double y,
    double? yDeviation,
    double? xDeviation,
    @Default([]) List<DeviceDetails> deviceBuckets,

    // These values are old, but we keep it because we have a JIT migration for now
    double? capturedDeviceWidth,
    double? capturedDeviceHeight,
  }) = _WidgetPosition;

  factory WidgetPosition.empty() => WidgetPosition(x: 0, y: 0);

  factory WidgetPosition.fromJson(Map<String, dynamic> json) =>
      _$WidgetPositionFromJson(json);

  /// Performs a migration using the [capturedDeviceWidth] and [capturedDeviceHeight]
  /// and returns a new [WidgetPosition] to be used in the place of the original.
  WidgetPosition jitMigrate() {
    print('Migrate: $x,$y size:$capturedDeviceWidth, $capturedDeviceHeight');

    final width = capturedDeviceWidth ?? -1;
    final height = capturedDeviceHeight ?? -1;
    final orientation = _getOrientationFromSize(width: width, height: height);

    final matchingDeviceDetails = _getMatchingDeviceDetails(
      width: width,
      height: height,
      orientation: orientation,
    );

    final noDeviceBucketForOriginalSize = matchingDeviceDetails == null;

    print(
        'noDeviceBucketForOriginalSize: $noDeviceBucketForOriginalSize\n Current Buckets: $deviceBuckets');
    if (noDeviceBucketForOriginalSize) {
      return copyWith(deviceBuckets: [
        ...deviceBuckets,
        DeviceDetails(
          screenWidth: width,
          screenHeight: height,
          orientation: orientation,
        )
      ]);
    }

    return this;
  }

  Orientation _getOrientationFromSize(
      {required double width, required double height}) {
    return height > width ? Orientation.portrait : Orientation.landscape;
  }

  DeviceDetails? _getMatchingDeviceDetails({
    required double width,
    required double height,
    required Orientation orientation,
  }) {
    final matchingDeviceDetails = deviceBuckets.where(
      (details) =>
          details.screenWidth == width &&
          details.screenHeight == height &&
          details.orientation == orientation,
    );

    if (matchingDeviceDetails.isNotEmpty) {
      print(
          'Has match for $width $height $orientation in ${matchingDeviceDetails.first}');
      return matchingDeviceDetails.first;
    }

    return null;
  }

  bool hasDeviceDetailsForScreenSize({
    required double width,
    required double height,
    required Orientation orientation,
  }) {
    final matchingDeviceSize = _getMatchingDeviceDetails(
      width: width,
      height: height,
      orientation: orientation,
    );

    print('MatchingDeviceSize is: $matchingDeviceSize');

    return matchingDeviceSize != null;
  }

  WidgetPosition storeDeviceDetails({
    required Size size,
    required Orientation orientation,
  }) {
    return copyWith(deviceBuckets: [
      ...deviceBuckets,
      DeviceDetails(
        screenWidth: size.width,
        screenHeight: size.height,
        orientation: orientation,
      )
    ]);
  }
}
