import 'package:testsweets/src/app/logger.dart';
import 'package:testsweets/src/extensions/interaction_extension.dart';
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
    final scrollablesBelowInteraction = scrollables.where(
      (element) =>
          element.rect.contains(
            interaction.renderPosition.toOffset,
          ) &&
          element.maxScrollExtentByPixels != double.infinity,
    );

    log.v(
        '💡💡 Interaction at (${interaction.renderPosition.x}, ${interaction.renderPosition.y}) overlaps no scroll views.');
    log.v('👉 Scrollables are 👉 ---------- \n${scrollables.join('\n')}');

    interaction = interaction.copyWith(externalities: null);

    /// If there is no overlapping with any scrollable
    /// Return the interaction without changing anything
    if (scrollablesBelowInteraction.isEmpty) return interaction;

    if (interaction.isScrollable) {
      return storeDescriptionInScrollableExternalities(
        scrollablesBelowInteraction,
        interaction,
      );
    } else {
      return storeDescriptionInExternalities(
        scrollablesBelowInteraction,
        interaction,
      );
    }
  }

  Interaction storeDescriptionInScrollableExternalities(
    Iterable<ScrollableDescription> scrollablesBelowInteraction,
    Interaction interaction,
  ) {
    log.v(scrollablesBelowInteraction);

    /// When interaction type is scrollable and there is only one list below it,
    /// Shouldn't add the list to externalities of the interaction cause it will
    /// scroll itself
    if (interaction.isScrollable && scrollablesBelowInteraction.length == 1) {
      return interaction;
    }

    final biggestScrollable = findBiggestScrollable(
      scrollablesBelowInteraction,
    );

    interaction = interaction.copyWith(
      externalities: {
        biggestScrollable.transferBy(biggestScrollable),
      },
      widgetPositions: [
        interaction.renderPosition.withScrollable(biggestScrollable)
      ],
    );
    return interaction;
  }

  Interaction storeDescriptionInExternalities(
    Iterable<ScrollableDescription> scrollablesBelowInteraction,
    Interaction interaction,
  ) {
    final biggestScrollable =
        findBiggestScrollable(scrollablesBelowInteraction);

    for (var scrollable in scrollablesBelowInteraction.toList()) {
      interaction = interaction.copyWith(
        externalities: {
          ...interaction.externalities ?? {},
          scrollable.transferBy(biggestScrollable),
        },
        widgetPositions: [
          interaction.renderPosition.withScrollable(scrollable)
        ],
      );
    }
    return interaction;
  }

  ScrollableDescription findBiggestScrollable(
    Iterable<ScrollableDescription> scrollablesBelowInteraction,
  ) {
    return scrollablesBelowInteraction.reduce(
      (curr, next) => curr.rect.biggerThan(next.rect) ? curr : next,
    );
  }
}
