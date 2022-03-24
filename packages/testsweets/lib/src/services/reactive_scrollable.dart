import 'package:flutter/material.dart';
import 'package:testsweets/src/extensions/interaction_extension.dart';
import 'package:testsweets/src/extensions/widget_position_extension.dart';
import 'package:testsweets/src/ui/shared/utils.dart';
import 'package:testsweets/testsweets.dart';

import '../app/logger.dart';

class ReactiveScrollable {
  final log = getLogger('ReactiveScrollable');

  late ScrollableDescription _currentScrollableDescription;

  set currentScrollableDescription(
      ScrollableDescription currentScrollableDescription) {
    _currentScrollableDescription = currentScrollableDescription;
  }

  Iterable<Interaction> filterAffectedInteractionsByScrollable(
      List<Interaction> viewDescription) {
    log.v(_currentScrollableDescription);

    return viewDescription.where(InteractionUtils.notView).where(
      (interaction) {
        if (interaction.externalities == null) return false;

        /// This fixes the nested scrollables issue where the first scrollable
        /// deviate the second one's offset
        Offset offsetDeviation = calculateOffsetDeviation(
            _currentScrollableDescription, interaction);
        return interaction.externalities!
            .where((sd) => sd.axis == _currentScrollableDescription.axis)
            .any(
          (interacrionSd) {
            final distance = _distanceSquaredBetweenScrollableAndExternal(
                interacrionSd, offsetDeviation, _currentScrollableDescription);

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
    Iterable<Interaction> affectedInteractions,
  ) {
    log.v(_currentScrollableDescription);

    return affectedInteractions.map((interaction) => interaction.copyWith(
        position:
            interaction.position.applyScroll(_currentScrollableDescription)));
  }
}
