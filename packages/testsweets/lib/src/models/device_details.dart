import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_details.freezed.dart';
part 'device_details.g.dart';

@freezed
class DeviceDetails with _$DeviceDetails {
  factory DeviceDetails({
    required double screenWidth,
    required double screenHeight,
    required Orientation orientation,
  }) = _DeviceDetails;

  factory DeviceDetails.fromJson(Map<String, dynamic> json) =>
      _$DeviceDetailsFromJson(json);
}
