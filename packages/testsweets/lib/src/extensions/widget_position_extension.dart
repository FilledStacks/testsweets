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
  WidgetPosition applyScroll(Axis axis, double extent) {
    print(
        'applyScroll: y:' + this.y.toString() + "offset:" + extent.toString());
    switch (axis) {
      case Axis.vertical:
        return this.copyWith(yTranlate: extent);
      case Axis.horizontal:
        return this.copyWith(xTranlate: extent);
    }
  }
}
