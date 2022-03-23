import 'package:flutter/widgets.dart';
import 'package:testsweets/testsweets.dart';

extension ScrollableDescriptionExtension on ScrollableDescription {
  ScrollableDescription transferBy(
      ScrollableDescription? scrollableDescription) {
    if (scrollableDescription == null || scrollableDescription == this)
      return this;
    switch (scrollableDescription.axis) {
      case Axis.vertical:
        return this.copyWith(
            nested: true,
            rect: SerializableRect.fromLTWH(
              this.rect.left,
              this.rect.top + scrollableDescription.scrollExtentByPixels,
              this.rect.width,
              this.rect.height,
            ));
      case Axis.horizontal:
        return this.copyWith(
            nested: true,
            rect: SerializableRect.fromLTWH(
              this.rect.left + scrollableDescription.scrollExtentByPixels,
              this.rect.top,
              this.rect.width,
              this.rect.height,
            ));
    }
  }
}
