import 'package:flutter/material.dart';
import 'package:testsweets/testsweets.dart';

extension WidgetPositionExtension on WidgetPosition {
  Offset get toOffset => Offset(x, y);
  WidgetPosition withScrollable(ScrollableDescription scrollable) {
    final scrollingPixels = scrollable.scrollingPixelsOnCapture;

    if (scrollable.axis == Axis.vertical) {
      return WidgetPosition(x: x, y: y + scrollingPixels);
    } else {
      return WidgetPosition(x: x + scrollingPixels, y: y);
    }
  }
}
