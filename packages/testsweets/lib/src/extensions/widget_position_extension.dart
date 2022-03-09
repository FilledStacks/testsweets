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

  WidgetPosition applyScroll(AxisDirection axisDirection, double offset) {
    print(
        'applyScroll: y:' + this.y.toString() + "offset:" + offset.toString());
    switch (axisDirection) {
      case AxisDirection.up:
        return this.copyWith(yTranlate: offset);
      case AxisDirection.down:
        return this.copyWith(yTranlate: offset);
      case AxisDirection.right:
        return this.copyWith(xTranlate: this.x + offset);
      case AxisDirection.left:
        return this.copyWith(xTranlate: this.x - offset);
    }
  }
}
