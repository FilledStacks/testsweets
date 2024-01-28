import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'widget_position.freezed.dart';
part 'widget_position.g.dart';

/// The position of the widget as we captured it on device
@freezed
class WidgetPosition with _$WidgetPosition {
  const WidgetPosition._();

  const factory WidgetPosition({
    required double x,
    required double y,
    required double capturedDeviceWidth,
    required double capturedDeviceHeight,
    @Default(Orientation.portrait) Orientation orientation,
    double? yDeviation,
    double? xDeviation,
    @JsonKey(includeToJson: false, includeFromJson: false)
    @Default(false)
    bool active,
  }) = _WidgetPosition;

  factory WidgetPosition.empty() => const WidgetPosition(
        x: 0,
        y: 0,
        capturedDeviceWidth: 0,
        capturedDeviceHeight: 0,
      );

  factory WidgetPosition.fromJson(Map<String, dynamic> json) =>
      _$WidgetPositionFromJson(json);
}
