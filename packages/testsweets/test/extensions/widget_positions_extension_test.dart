import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:testsweets/src/extensions/widget_positions_extension.dart';
import 'package:testsweets/testsweets.dart';

void main() {
  group('WidgetPositionsExtensionTest -', () {
    group('getClosestWidgetBasedOnScreenSize -', () {
      test(
          'When given list with (10,10), (20,20), and size 5,5, should return the first position ',
          () {
        final positions = [
          WidgetPosition(
            x: 10,
            y: 10,
            capturedDeviceWidth: 10,
            capturedDeviceHeight: 10,
          ),
          WidgetPosition(
            x: 10,
            y: 10,
            capturedDeviceWidth: 20,
            capturedDeviceHeight: 20,
          ),
        ];

        final result = positions.getClosestWidgetBasedOnScreeSize(Size(5, 5));

        expect(result, positions.first);
      });
    });
  });
}
