import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:testsweets/src/models/device_details.dart';

part 'widget_position.freezed.dart';
part 'widget_position.g.dart';

/// The position of the widget as we captured it on device
@freezed
class WidgetPosition with _$WidgetPosition {
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
}
