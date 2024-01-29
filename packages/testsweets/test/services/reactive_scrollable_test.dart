import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testsweets/src/services/reactive_scrollable.dart';
import 'package:testsweets/testsweets.dart';

import '../helpers/test_consts.dart';
import '../helpers/test_helpers.dart';

void main() {
  group('ReactiveInteractionTest -', () {
    setUp(registerServices);
    tearDown(unregisterServices);

    group('filterAffectedInteractionsByScrollable -', () {
      test(
          'When called, Should return any interaction that may affect by the scroll',
          () {
        final service = ReactiveScrollable();
        Interaction interactionWithExternalites = kScrollableInteraction
            .copyWith(externalities: {kTopLeftVerticalScrollableDescription});

        service.currentScrollableDescription =
            kTopLeftVerticalScrollableDescription;

        final result = service.filterAffectedInteractionsByScrollable([
          interactionWithExternalites,
          kScrollableInteraction2,
        ]).toList();

        expect(result, [interactionWithExternalites]);
      });

      test(
          '''An interaction located inside two scrollables one vertical(wraps the horizontal) and one horizontal,
           we scroll the vertical one that will lead the horizontal to be scrolled too,
           Should return the horizontal rect after adding the vertical scroll deviation to it''',
          () {
        final service = ReactiveScrollable();

        ///
        /// Capturing Interaction is happining in another
        /// function[applyScrollableOnInteraction]
        ///
        /// Here we are just mocking it manually by adding to [externalities]
        ///
        Interaction interactionWithExternalites =
            kScrollableInteraction.copyWith(externalities: {
          kFullScreenVerticalScrollableDescription,
          kTopLeftHorizontalScrollableDescription
        });

        service.currentScrollableDescription =
            kTopLeftVerticalScrollableDescription;
        final interactionsForView = service
            .moveInteractionsWithScrollable([interactionWithExternalites]);

        final interactionWithExternalitesAfterScrollingVerticalList =
            interactionsForView.firstWhere(
                (element) => element.id == interactionWithExternalites.id);
        expect(
            interactionWithExternalitesAfterScrollingVerticalList
                .externalities!.last,
            kTopLeftHorizontalScrollableDescription);
      });

      test(
          '''An interaction located inside two scrollables one vertical(wraps the horizontal) and one horizontal,
           We scroll the horizontal list, Should not affect the vertical list rect''',
          () {
        final service = ReactiveScrollable();

        /// Interaction that reacts to 2 scrollables this should happpen when capturing
        /// the interaction but here we tring to mock it
        Interaction interactionWithExternalites =
            kScrollableInteraction.copyWith(externalities: {
          kFullScreenVerticalScrollableDescription,
          kTopLeftHorizontalScrollableDescription
        });

        service.currentScrollableDescription =
            kTopLeftVerticalScrollableDescription;
        var interactionsForView = service
            .moveInteractionsWithScrollable([interactionWithExternalites]);

        service.currentScrollableDescription =
            kTopLeftHorizontalScrollableDescription;
        interactionsForView = service
            .moveInteractionsWithScrollable([interactionWithExternalites]);

        service.currentScrollableDescription =
            kTopLeftVerticalScrollableDescription;
        final affectedInteractions =
            service.filterAffectedInteractionsByScrollable(
                interactionsForView.toList());

        expect(affectedInteractions, isNotEmpty);
      });
      test(
          '''An interaction located inside two scrollables one horizontal(wraps the vertical) and one vertical,
           We scroll the vertical list, Should not affect the horizontal list rect''',
          () {
        final service = ReactiveScrollable();

        // Just switched the axis of each list to be the opposite
        final horizontalList = kFullScreenVerticalScrollableDescription
            .copyWith(axis: Axis.horizontal);
        final verticalList = kTopLeftHorizontalScrollableDescription.copyWith(
            axis: Axis.vertical);

        Interaction interactionWithExternalites =
            kScrollableInteraction.copyWith(externalities: {
          horizontalList,
          verticalList,
        });

        service.currentScrollableDescription = horizontalList;
        var interactionsForView = service
            .moveInteractionsWithScrollable([interactionWithExternalites]);

        service.currentScrollableDescription = verticalList;
        interactionsForView = service
            .moveInteractionsWithScrollable([interactionWithExternalites]);

        service.currentScrollableDescription = horizontalList;
        final affectedInteractions =
            service.filterAffectedInteractionsByScrollable(
                interactionsForView.toList());
        expect(affectedInteractions, isNotEmpty);
      });
      test(
          'When called and no interaction has externalities, Should return empty list',
          () {
        final service = ReactiveScrollable();

        service.currentScrollableDescription =
            kTopLeftVerticalScrollableDescription;
        final result = service.filterAffectedInteractionsByScrollable([
          kScrollableInteraction,
          kScrollableInteraction2,
        ]).toList();

        expect(result, isEmpty);
      });

      test(
          '''An interaction located inside two scrollables one vertical(wraps the horizontal) and one horizontal
          and both of them starts at the same point(top-left point is (0,0)),
           when scroll the horizontal list which doesn't overlap with our interaction
           , Should not affect scrollableDescription on the vertical list 
           (in fewer words chech for axis to roll out the case where two scrollables
           share the top-left point)
           ''', () {
        final service = ReactiveScrollable();

        final horizontalScrollable = kTopLeftHorizontalScrollableDescription
            .copyWith(rect: SerializableRect.fromLTWH(0, 0, 10, 10));
        Interaction interactionWithExternalites =
            kScrollableInteraction.copyWith(externalities: {
          kFullScreenVerticalScrollableDescription,
        });

        service.currentScrollableDescription = horizontalScrollable;
        final affectedInteractions = service
            .filterAffectedInteractionsByScrollable(
                [interactionWithExternalites]);

        expect(affectedInteractions, isEmpty);
      });
    });
    group('moveInteractionsWithScrollable -', () {
      test('''When add scrollDescription of 100px on vertical,
       Should add 100 to yTranslate of the interaction''', () {
        final service = ReactiveScrollable();

        service.currentScrollableDescription =
            kTopLeftVerticalScrollableDescription;
        final result = service.moveInteractionsWithScrollable([
          kScrollableInteraction,
        ]);
        expect(result.first.renderPosition.yDeviation, 100);
      });
    });
  });
}
