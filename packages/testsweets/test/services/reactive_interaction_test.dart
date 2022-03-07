import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testsweets/src/models/capture_exception.dart';
import 'package:testsweets/src/services/reactive_interaction.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_viewmodel.dart';
import 'package:testsweets/testsweets.dart';

import '../helpers/test_consts.dart';
import '../helpers/test_helpers.dart';

void main() {
  group('ReactiveInteractionTest -', () {
    setUp(registerServices);
    tearDown(unregisterServices);
  });
  group('overlappingListWithWidget -', () {
    test('''When provide list of rects and widget position,
      Should filter out the non overlapping lists''', () {
      final service = ReactiveScrollable();

      Iterable<ScrollableDescription> listsRect = [
        kTopLeftScrollableDescription,
        kAnotherTopLeftScrollableDescription,
        kTopRightScrollableDescription,
        kBottomLeftScrollableDescription,
      ];
      final filteredLists = service.overlappingListWithWidget(
          listsRect, WidgetPosition(x: 0, y: 0));
      expect(filteredLists.length, 2);
    });
  });
  group('findAssociatedInteractionWithScrollable -', () {
    test('''When looping over the viewInteractions, 
           Should find the one that inside ScrollableDescription''', () {
      final service = ReactiveScrollable();
      final selectedId = service.findAssociatedInteractionWithScrollable(
          kTopLeftScrollableDescription, [
        kWidgetDescriptionTypeScroll1.copyWith(axis: Axis.vertical),
        kWidgetDescriptionTypeScroll2.copyWith(axis: Axis.vertical),
      ]);
      expect(selectedId, kWidgetDescriptionTypeScroll1.id);
    });
    test(
        '''When looping over the viewInteractions and two of the scrollInteraction
          is within the list coordinates one is vertical and one is horizontal, 
          Should take the one match the real list axis''', () {
      final service = ReactiveScrollable();
      final selectedId = service.findAssociatedInteractionWithScrollable(
          kAnotherTopLeftScrollableDescription, // This list has [Axis.vertical]
          [
            kWidgetDescriptionTypeScroll1.copyWith(axis: Axis.horizontal),
            kWidgetDescriptionTypeScroll2.copyWith(axis: Axis.vertical),
          ]);
      expect(selectedId, kWidgetDescriptionTypeScroll2.id);
    });
    test(
        '''When looping over the viewInteractions and two of the scrollInteraction
          is within the list coordinates both of them have axis.vertical, 
          Should throw an exception''', () {
      final service = ReactiveScrollable();

      expect(
          () => service.findAssociatedInteractionWithScrollable(
                  kAnotherTopLeftScrollableDescription, // This list has [Axis.vertical]
                  [
                    kWidgetDescriptionTypeScroll1.copyWith(axis: Axis.vertical),
                    kWidgetDescriptionTypeScroll2.copyWith(axis: Axis.vertical),
                  ]),
          throwsA(
              TypeMatcher<FoundMoreThanOneScrollInteractionPerScrollable>()));
    });
    test('''When looping over the viewInteractions and none of them
          match the requirment, 
          Should throw an exception''', () {
      final service = ReactiveScrollable();

      expect(
          () => service.findAssociatedInteractionWithScrollable(
                  kAnotherTopLeftScrollableDescription, // This list has [Axis.vertical]
                  [
                    kWidgetDescriptionTypeScroll1.copyWith(
                        axis: Axis.horizontal),
                    kWidgetDescriptionTypeScroll2.copyWith(
                        axis: Axis.horizontal),
                  ]),
          throwsA(TypeMatcher<
              NoScrollableInteractionsInsideThisScrollableWidget>()));
    });
  });
}
