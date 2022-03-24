import 'package:testsweets/src/app/logger.dart';
import 'package:testsweets/src/extensions/scrollable_description_extension.dart';
import 'package:testsweets/src/extensions/serializable_rect_extension.dart';
import 'package:testsweets/src/extensions/widget_position_extension.dart';
import 'package:testsweets/testsweets.dart';

class ScrollAppliance {
  final log = getLogger('ScrollAppliance');

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

    interaction = storeScrollablesRectInExternalities(
        overlapScrollableWithInteraction, interaction);

    return interaction;
  }

  Interaction storeScrollablesRectInExternalities(
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
}
