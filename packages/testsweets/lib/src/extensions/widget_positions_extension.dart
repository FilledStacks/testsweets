import 'dart:ui';

import 'package:testsweets/testsweets.dart';

extension WidgetPositionExtension on List<WidgetPosition> {
  WidgetPosition getClosestWidgetBasedOnScreeSize(Size size) {
    WidgetPosition? closestMatchingPosition;
    double closestDelta = 10000000;

    for (var widgetPosition in this) {
      final noMatchYet = closestMatchingPosition == null;
      if (noMatchYet) {
        closestMatchingPosition = widgetPosition;

        closestDelta = _calculateDeltaForPostition(
          currentSize: size,
          currentClosestPosition: closestMatchingPosition,
        );
        continue;
      }

      final totalDelta = _calculateDeltaForPostition(
        currentSize: size,
        currentClosestPosition: widgetPosition,
      );

      if (totalDelta < closestDelta) {
        closestMatchingPosition = widgetPosition;
        closestDelta = totalDelta;
      }
    }

    return closestMatchingPosition!;
  }

  double _calculateDeltaForPostition({
    required Size currentSize,
    required WidgetPosition currentClosestPosition,
  }) {
    final widthDelta =
        (currentSize.width - currentClosestPosition.capturedDeviceWidth).abs();

    final heightDelta =
        (currentSize.height - currentClosestPosition.capturedDeviceHeight)
            .abs();

    return widthDelta + heightDelta;
  }
}
