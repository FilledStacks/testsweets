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
          'When we have one scrollable, Should add the hash to externalities Set',
          () {
        final service = ReactiveScrollable();
        final result = service.applyScrollableOnInteraction(
          [kTopLeftVerticalScrollableDescription],
          kScrollableInteraction,
        );
        expect(result.externalities!.first,
            kTopLeftVerticalScrollableDescription.scrollableWidgetRect);
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
    });
    group('filterAffectedInteractionsByScrollable -', () {
      test(
          'When called, Should return any interaction that may affect by the scroll',
          () {
        final service = ReactiveScrollable();
        Interaction interactionWithExternalites = kScrollableInteraction
            .copyWith(externalities: {
          kTopLeftVerticalScrollableDescription.scrollableWidgetRect
        });
        final result = service.filterAffectedInteractionsByScrollable(
            kTopLeftVerticalScrollableDescription, [
          interactionWithExternalites,
          kScrollableInteraction2,
        ]).toList();

        /// NOTE: the offset doesn't have any effect on this function cause that
        /// Should be sorted out when creating the widget
        expect(result, [interactionWithExternalites]);
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
  });
}
