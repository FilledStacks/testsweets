import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testsweets/src/models/device_details.dart';
import 'package:testsweets/src/models/widget_position.dart';

void main() {
  group('WidgetPositionTest -', () {
    group('jitMigrate -', () {
      test(
          'When called with model that has v1 capturedSizes, and no matching, should have deviceDetails with matching size after migrate',
          () {
        var position = WidgetPosition(
          x: 10,
          y: 10,
          capturedDeviceWidth: 10,
          capturedDeviceHeight: 20,
        );

        position = position.jitMigrate();

        expect(position.deviceBuckets.length, 1);
        expect(position.deviceBuckets.first.screenWidth, 10);
        expect(position.deviceBuckets.first.screenHeight, 20);
      });

      test(
          'When called with model that has v1 capturedSizes, and matching, should not add an additional device details entry',
          () {
        var position = WidgetPosition(
            x: 10,
            y: 10,
            capturedDeviceWidth: 10,
            capturedDeviceHeight: 20,
            deviceBuckets: [
              DeviceDetails(
                screenWidth: 10,
                screenHeight: 20,
                orientation: Orientation.portrait,
              )
            ]);

        position = position.jitMigrate();

        expect(position.deviceBuckets.length, 1);
      });

      test(
          'When called with model that has v1 capturedSizes, and non matching deiceBucket, should not add a new additional device details entry',
          () {
        var position = WidgetPosition(
            x: 10,
            y: 10,
            capturedDeviceWidth: 10,
            capturedDeviceHeight: 20,
            deviceBuckets: [
              DeviceDetails(
                screenWidth: 10,
                screenHeight: 20,
                orientation: Orientation.landscape,
              )
            ]);

        position = position.jitMigrate();

        expect(position.deviceBuckets.length, 2);
      });
    });
  });
}
