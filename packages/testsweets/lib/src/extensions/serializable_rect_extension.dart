import 'package:flutter/widgets.dart';
import 'package:testsweets/testsweets.dart';

extension SerializableRectExtension on SerializableRect {
  bool biggestThan(SerializableRect anotherRect) {
    if ((this.size.width * this.size.height) >
        (anotherRect.size.width * anotherRect.size.height))
      return true;
    else
      return false;
  }

  SerializableRect offsetByScrollable(
      ScrollableDescription? scrollableDescription) {
    if (scrollableDescription == null || scrollableDescription.rect == this)
      return this;
    switch (scrollableDescription.axis) {
      case Axis.vertical:
        return SerializableRect.fromLTWH(left,
            top + scrollableDescription.scrollExtentByPixels, width, height,
            nested: true);
      case Axis.horizontal:
        return SerializableRect.fromLTWH(
            left + scrollableDescription.scrollExtentByPixels,
            top,
            width,
            height,
            nested: true);
    }
  }
}
