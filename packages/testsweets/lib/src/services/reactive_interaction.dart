import 'package:flutter/widgets.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/extensions/scrollable_description_extension.dart';
import 'package:testsweets/src/extensions/widget_position_extension.dart';
import 'package:testsweets/testsweets.dart';
import 'package:collection/collection.dart';

import '../models/capture_exception.dart';

abstract class ReactiveInteraction {
  /// After you confirm a list is overlapping with the newly created widget
  /// You should check if the list is accually captured previously by comparing all the
  /// scrollable interactions in this view if they overlap with our list
  WidgetDescription applyScrollableOnInteraction(
      Iterable<ScrollableDescription> scrollableDescription,
      WidgetDescription widgetDescription);
}

class ReactiveScrollable extends ReactiveInteraction {
  @override
  WidgetDescription applyScrollableOnInteraction(
    Iterable<ScrollableDescription> scrollables,
    WidgetDescription widgetDescription,
  ) {
    final overlapScrollableWithInteraction = scrollables.where(
      (element) => element.rect.contains(
        widgetDescription.position.toOffset,
      ),
    );

    /// If there is no overlapping with any scrollable
    /// Return WidgetDescription without changing anything
    if (overlapScrollableWithInteraction.isEmpty) return widgetDescription;

    for (var scrollable in overlapScrollableWithInteraction.toList()) {
      widgetDescription = widgetDescription.copyWith(
        externalities: {
          ...widgetDescription.externalities,
          scrollable.generateHash
        },
        position: widgetDescription.position.withScrollable(scrollable),
      );
    }

    return widgetDescription;
  }
}
