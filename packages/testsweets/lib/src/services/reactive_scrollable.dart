import 'package:flutter/material.dart';
import 'package:testsweets/src/constants/app_constants.dart';
import 'package:testsweets/src/extensions/widget_position_extension.dart';
import 'package:testsweets/src/ui/shared/utils.dart';
import 'package:testsweets/testsweets.dart';

import '../app/logger.dart';

class ReactiveScrollable {
  final log = getLogger('ReactiveScrollable');

  late ScrollableDescription currentScrollableDescription;

  Iterable<Interaction> filterAffectedInteractionsByScrollable(
    List<Interaction> viewDescription,
  ) {
    return viewDescription.where(InteractionUtils.notView).where(
      (interaction) {
        if (interaction.externalities == null) return false;

        /// This fixes the nested scrollables issue where the first scrollable
        /// deviate the second one's offset
        Offset offsetDeviation =
            calculateOffsetDeviation(currentScrollableDescription, interaction);
        return interaction.externalities!
            .where((sd) => sd.axis == currentScrollableDescription.axis)
            .any(
          (interacrionSd) {
            final distance = _distanceSquaredBetweenScrollableAndExternal(
                interacrionSd, offsetDeviation, currentScrollableDescription);

            final included = distance < SCROLLABLE_DETECTION_FORGIVENESS;
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
    ScrollableDescription scrollableDescription,
    Interaction interaction,
  ) {
    late Offset offsetDeviation;
    if (scrollableDescription.axis == Axis.vertical) {
      offsetDeviation = Offset(interaction.renderPosition.xDeviation ?? 0, 0);
    } else {
      offsetDeviation =
          Offset(0, -(interaction.renderPosition.yDeviation ?? 0));
    }
    return offsetDeviation;
  }

  Iterable<Interaction> moveInteractionsWithScrollable(
    Iterable<Interaction> affectedInteractions,
  ) {
    return affectedInteractions.map((interaction) => interaction.copyWith(
        position: interaction.renderPosition
            .applyScroll(currentScrollableDescription)));
  }
}
