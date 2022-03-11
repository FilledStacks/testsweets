import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:testsweets/src/extensions/widget_position_extension.dart';
import 'package:testsweets/testsweets.dart';

class ReactiveScrollable {
  WidgetDescription applyScrollableOnInteraction(
    Iterable<ScrollableDescription> scrollables,
    WidgetDescription widgetDescription,
  ) {
    final overlapScrollableWithInteraction = scrollables.where(
      (element) {
        return element.rect.contains(
          widgetDescription.position.toOffset,
        );
      },
    );

    /// If there is no overlapping with any scrollable
    /// Return WidgetDescription without changing anything
    if (overlapScrollableWithInteraction.isEmpty) return widgetDescription;

    for (var scrollable in overlapScrollableWithInteraction.toList()) {
      widgetDescription = widgetDescription.copyWith(
        externalities: {
          ...widgetDescription.externalities ?? {},
          scrollable.rect
        },
        position: widgetDescription.position.withScrollable(scrollable),
      );
    }

    return widgetDescription;
  }

  ScrollableDescription? calculateScrollDescriptionFromNotification({
    required Offset globalPosition,
    required Offset localPosition,
    required ScrollDirection scrollDirection,
    required ScrollMetrics metrics,
  }) {
    if (scrollDirection == ScrollDirection.idle) return null;

    final position = -metrics.extentBefore;
    final topLeftPointOfList = globalPosition - localPosition;

    return ScrollableDescription(
        axis: metrics.axis,
        rect: ModularRect(topLeftPointOfList.dx, topLeftPointOfList.dy, 0, 0),
        scrollingPixelsOnCapture: position,
        maxScrollOffset: metrics.maxScrollExtent);
  }
}
