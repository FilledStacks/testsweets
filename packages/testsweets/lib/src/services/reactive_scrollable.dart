import 'package:flutter/material.dart';
import 'package:testsweets/src/extensions/scrollable_description_extension.dart';
import 'package:testsweets/src/extensions/serializable_rect_extension.dart';
import 'package:testsweets/src/extensions/interaction_extension.dart';
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
      (element) => element.rect.contains(
        interaction.position.toOffset,
      ),
    );

    /// If there is no overlapping with any scrollable
    /// Return the interaction without changing anything
    if (overlapScrollableWithInteraction.isEmpty) return interaction;

    interaction = _storeScrollablesRectInExternalities(
        overlapScrollableWithInteraction, interaction);

    return interaction;
  }

  Interaction _storeScrollablesRectInExternalities(
    Iterable<ScrollableDescription> overlapScrollableWithInteraction,
    Interaction interaction,
  ) {
    interaction.copyWith(externalities: null);
    ScrollableDescription? biggestScrollable;

    if (overlapScrollableWithInteraction.length > 1) {
      biggestScrollable =
          findBiggestScrollable(overlapScrollableWithInteraction);
    }

    for (var scrollable in overlapScrollableWithInteraction.toList()) {
      interaction = interaction.copyWith(
        externalities: {
          ...interaction.externalities ?? {},
          scrollable.transferBy(biggestScrollable),
        },
        position: interaction.position.withScrollable(scrollable),
      );
    }
    return interaction;
  }

  ScrollableDescription findBiggestScrollable(
          Iterable<ScrollableDescription> overlapScrollableWithInteraction) =>
      overlapScrollableWithInteraction.reduce((curr, next) {
        if (curr.rect.biggestThan(next.rect))
          return curr;
        else
          return next;
      });

  Iterable<Interaction> filterAffectedInteractionsByScrollable(
      ScrollableDescription scrollableDescription,
      List<Interaction> viewDescription) {
    log.v(scrollableDescription);

    return viewDescription.where((interaciton) => interaciton.notView).where(
      (interaction) {
        if (interaction.externalities == null) return false;

        /// This fixes the nested scrollables issue where the first scrollable
        /// deviate the second one's offset
        Offset offsetDeviation =
            calculateOffsetDeviation(scrollableDescription, interaction);
        return interaction.externalities!
            .where((sd) => sd.axis == scrollableDescription.axis)
            .any(
          (interacrionSd) {
            final distance = _distanceSquaredBetweenScrollableAndExternal(
                interacrionSd, offsetDeviation, scrollableDescription);

            final included = distance < 10;
            return included;
          },
        );
      },
    );
  }

  double _distanceSquaredBetweenScrollableAndExternal(
      ScrollableDescription interacrionSd,
      Offset offsetDeviation,
      ScrollableDescription sd) {
    final deviation = (interacrionSd.nested ? offsetDeviation : Offset.zero);
    final offset = interacrionSd.rect.topLeft - deviation;
    return (offset - sd.rect.topLeft).distanceSquared;
  }

  Offset calculateOffsetDeviation(
      ScrollableDescription scrollableDescription, Interaction interaction) {
    late Offset offsetDeviation;
    if (scrollableDescription.axis == Axis.vertical) {
      offsetDeviation = Offset(interaction.position.xDeviation ?? 0, 0);
    } else {
      offsetDeviation = Offset(0, -(interaction.position.yDeviation ?? 0));
    }
    return offsetDeviation;
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
