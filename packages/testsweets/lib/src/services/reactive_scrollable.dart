import 'package:flutter/material.dart';
import 'package:testsweets/src/extensions/widget_position_extension.dart';
import 'package:testsweets/testsweets.dart';

import '../app/logger.dart';

class ReactiveScrollable {
  final log = getLogger('ReactiveScrollable');
  Interaction applyScrollableOnInteraction(
    Iterable<ScrollableDescription> scrollables,
    Interaction interaction,
  ) {
    log.v(interaction);
    final overlapScrollableWithInteraction = scrollables.where(
      (element) => element.scrollableWidgetRect.contains(
        interaction.position.toOffset,
      ),
    );

    /// If there is no overlapping with any scrollable
    /// Return WidgetDescription without changing anything
    if (overlapScrollableWithInteraction.isEmpty) return interaction;

    for (var scrollable in overlapScrollableWithInteraction.toList()) {
      interaction = interaction.copyWith(
        externalities: {
          ...interaction.externalities ?? {},
          scrollable.scrollableWidgetRect
        },
        position: interaction.position.withScrollable(scrollable),
      );
    }

    return interaction;
  }

  Iterable<Interaction> filterAffectedInteractionsByScrollable(
      ScrollableDescription scrollableDescription,
      List<Interaction> viewDescription) {
    log.v(scrollableDescription);

    return viewDescription.where(
      (interaction) {
        /// This fixes the nested scrollables issue where the first scrollable
        /// deviate the second one's offset
        final offsetDeviation = Offset(
            scrollableDescription.axis == Axis.vertical
                ? interaction.position.xDeviation ?? 0
                : 0,
            scrollableDescription.axis == Axis.horizontal
                ? -(interaction.position.yDeviation ?? 0)
                : 0);
        return interaction.externalities?.any(
              (externalRect) =>
                  externalRect.topLeft + offsetDeviation ==
                  scrollableDescription.scrollableWidgetRect.topLeft,
            ) ??
            false;
      },
    );
  }

  Iterable<Interaction> moveInteractionsWithScrollable(
    ScrollableDescription scrollableDescription,
    Iterable<Interaction> affectedInteractions,
  ) {
    log.v(scrollableDescription);

    return affectedInteractions.map((interaction) => interaction.copyWith(
        position: interaction.position.applyScroll(scrollableDescription)));
  }
}
