import 'package:flutter/material.dart';
import 'package:testsweets/src/constants/app_constants.dart';
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

  Offset get offsetAfterScroll =>
      Offset(this.x + (this.xTranlate ?? 0), this.y + (this.yTranlate ?? 0));
  WidgetPosition applyScroll(AxisDirection axisDirection, double offset) {
    print(
        'applyScroll: y:' + this.y.toString() + "offset:" + offset.toString());
    switch (axisDirection) {
      case AxisDirection.up:
      case AxisDirection.down:
        return this.copyWith(yTranlate: offset);
      case AxisDirection.right:
      case AxisDirection.left:
        return this.copyWith(xTranlate: offset);
    }
  }
}
