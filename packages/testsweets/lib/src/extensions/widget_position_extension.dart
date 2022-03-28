import 'package:flutter/material.dart';
import 'package:testsweets/testsweets.dart';

extension WidgetPositionExtension on WidgetPosition {
  Offset get toOffset => Offset(x, y);
  WidgetPosition withScrollable(ScrollableDescription scrollable) {
    final scrollingPixels = scrollable.scrollExtentByPixels;

    if (scrollable.axis == Axis.vertical) {
      return this.copyWith(x: x, y: y + scrollingPixels);
    } else {
      return this.copyWith(x: x + scrollingPixels, y: y);
    }
  }

  Offset get offsetAfterScroll =>
      Offset(this.x + (this.xDeviation ?? 0), this.y + (this.yDeviation ?? 0));

  WidgetPosition applyScroll(ScrollableDescription scrollableDescription) {
    switch (scrollableDescription.axis) {
      case Axis.vertical:
        return this
            .copyWith(yDeviation: scrollableDescription.scrollExtentByPixels);
      case Axis.horizontal:
        return this
            .copyWith(xDeviation: scrollableDescription.scrollExtentByPixels);
    }
  }
}
