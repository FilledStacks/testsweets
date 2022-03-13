import 'package:testsweets/src/extensions/widget_position_extension.dart';
import 'package:testsweets/testsweets.dart';

import '../app/logger.dart';

class ReactiveScrollable {
  final log = getLogger('ReactiveScrollable');
  WidgetDescription applyScrollableOnInteraction(
    Iterable<ScrollableDescription> scrollables,
    WidgetDescription widgetDescription,
  ) {
    log.v(widgetDescription);
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
          ...widgetDescription.externalities ?? {},
          scrollable.rect
        },
        position: widgetDescription.position.withScrollable(scrollable),
      );
    }

    return widgetDescription;
  }

  Iterable<WidgetDescription> filterAffectedInteractionsByScrollable(
      ScrollableDescription scrollableDescription,
      Iterable<WidgetDescription> viewDescription) {
    log.v(scrollableDescription);
    return viewDescription.where(
      (interaction) =>
          interaction.externalities?.any(
            (rect) => rect.topLeft == scrollableDescription.rect.topLeft,
          ) ??
          false,
    );
  }

  List<WidgetDescription> moveInteractionsWithScrollable(
    ScrollableDescription scrollableDescription,
    Iterable<WidgetDescription> affectedInteractions,
  ) {
    log.v(scrollableDescription);

    return affectedInteractions
        .map((interaction) => interaction.copyWith(
            position: interaction.position.applyScroll(scrollableDescription)))
        .toList();
  }
}
