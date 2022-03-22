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

    group('applyScrollableOnInteraction -', () {
      test('''When we have one scrollable that been scrolled 100px vertically, 
    Should add the scroll to the y of widgetPosition of our interaction''', () {
        final service = ReactiveScrollable();
        final result = service.applyScrollableOnInteraction(
          [kTopLeftVerticalScrollableDescription],
          kScrollableInteraction,
        );
        expect(result.position.y, kScrollableInteraction.position.y + 100);
      });

      test(
          'When we have one scrollable, Should add the rect to externalities Set',
          () {
        final service = ReactiveScrollable();
        final result = service.applyScrollableOnInteraction(
          [kTopLeftVerticalScrollableDescription],
          kScrollableInteraction,
        );
        expect(
            result.externalities!.first, kTopLeftVerticalScrollableDescription);
      });
      test('''When we have two scrollables that been scrolled 100px vertically
    and 50px horizontally, Should add the scroll to the y of
    widgetPosition of our interaction''', () {
        final service = ReactiveScrollable();
        final result = service.applyScrollableOnInteraction(
          [
            kTopLeftVerticalScrollableDescription,
            kTopLeftHorizontalScrollableDescription
          ],
          kScrollableInteraction,
        );
        expect(result.position.y, kScrollableInteraction.position.y + 100);
        expect(result.position.x, kScrollableInteraction.position.x + 50);
      });
      test('''When we capture an interaction located inside a horizontal  
      list which also located inside a bigger vertical list,
      Should add the scroll extent of the bigger list(vertical) 
      to the rect of the smaller list(horizontal)

      |           |
      |           |
      |-----------|
      |   (T)     | <---- The Interaction 
      |-----------|
      |           |

       ''', () {
        final service = ReactiveScrollable();
        final result = service.applyScrollableOnInteraction(
          [
            kFullScreenVerticalScrollableDescription,
            kTopLeftHorizontalScrollableDescription
          ],
          kScrollableInteraction,
        );
        final largestSd = result.externalities!.reduce(
            (curr, next) => curr.rect.size > next.rect.size ? curr : next);
        final smallestSd = result.externalities!.reduce(
            (curr, next) => curr.rect.size < next.rect.size ? curr : next);

        expect(largestSd.rect.topLeft,
            kTopLeftVerticalScrollableDescription.rect.topLeft);
        expect(smallestSd.rect.top, 170);
      });
    });
    group('filterAffectedInteractionsByScrollable -', () {
      test(
          'When called, Should return any interaction that may affect by the scroll',
          () {
        final service = ReactiveScrollable();
        Interaction interactionWithExternalites = kScrollableInteraction
            .copyWith(externalities: {kTopLeftVerticalScrollableDescription});
        final result = service.filterAffectedInteractionsByScrollable(
            kTopLeftVerticalScrollableDescription, [
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

        final interactionsForView = service.moveInteractionsWithScrollable(
            kTopLeftVerticalScrollableDescription,
            [interactionWithExternalites]);

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
        var interactionsForView = service.moveInteractionsWithScrollable(
            kTopLeftVerticalScrollableDescription,
            [interactionWithExternalites]);
        interactionsForView = service.moveInteractionsWithScrollable(
            kTopLeftHorizontalScrollableDescription,
            [interactionWithExternalites]);

        final affectedInteractions =
            service.filterAffectedInteractionsByScrollable(
                kTopLeftVerticalScrollableDescription,
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

        var interactionsForView = service.moveInteractionsWithScrollable(
            horizontalList, [interactionWithExternalites]);
        interactionsForView = service.moveInteractionsWithScrollable(
            verticalList, [interactionWithExternalites]);

        final affectedInteractions =
            service.filterAffectedInteractionsByScrollable(
                horizontalList, interactionsForView.toList());
        expect(affectedInteractions, isNotEmpty);
      });
      test(
          'When called and no interaction has externalities, Should return empty list',
          () {
        final service = ReactiveScrollable();

        final result = service.filterAffectedInteractionsByScrollable(
            kTopLeftVerticalScrollableDescription, [
          kScrollableInteraction,
          kScrollableInteraction2,
        ]).toList();

        expect(result, isEmpty);
      });
    });
    group('reactToScrollEvent -', () {
      test('''When add scrollDescription of 100px on vertical,
       Should add 100 to yTranslate of the interaction''', () {
        final service = ReactiveScrollable();
        final result = service.moveInteractionsWithScrollable(
            kTopLeftVerticalScrollableDescription, [
          kScrollableInteraction,
        ]);
        expect(result.first.position.yDeviation, 100);
      });
    });
    group('findBiggestScrollable -', () {
      test('When provide two list, should return the biggest one', () {
        final service = ReactiveScrollable();
        final biggestScroll = service.findBiggestScrollable([
          kFullScreenVerticalScrollableDescription,
          kTopLeftHorizontalScrollableDescription,
        ]);

        expect(biggestScroll, kFullScreenVerticalScrollableDescription);
      });
      test('''When provide two scrollables that shares the same horizontal long,
       should return the tallest one''', () {
        final service = ReactiveScrollable();
        final biggestScroll = service.findBiggestScrollable([
          kFullScreenVerticalScrollableDescription,
          kTopLeftHorizontalScrollableDescription.copyWith(
              rect:
                  SerializableRect.fromPoints(Offset(0, 0), Offset(400, 200))),
        ]);

        expect(biggestScroll, kFullScreenVerticalScrollableDescription);
      });
    });
  });
}
