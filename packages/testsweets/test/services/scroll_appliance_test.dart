import 'package:flutter_test/flutter_test.dart';
import 'package:testsweets/src/services/scroll_appliance.dart';
import 'package:testsweets/testsweets.dart';

import '../helpers/test_consts.dart';
import '../helpers/test_helpers.dart';

void main() {
  group('ScrollApplianceTest -', () {
    setUp(registerServices);
    tearDown(unregisterServices);

    group('applyScrollableOnInteraction -', () {
      test('''When we have one list that been scrolled 100px vertically, 
    Should add the scroll to the y of widgetPosition of our interaction''', () {
        final service = ScrollAppliance();
        final result = service.applyScrollableOnInteraction(
          [kTopLeftVerticalScrollableDescription],
          kTouchableInteraction,
        );
        expect(result.position.y, kTouchableInteraction.position.y + 100);
      });

      test('''
          When scroll a list on interaction,
          Should add its ScrollableDescription to interaction externalities ''',
          () {
        final service = ScrollAppliance();
        final result = service.applyScrollableOnInteraction(
          [kTopLeftVerticalScrollableDescription],
          kTouchableInteraction,
        );
        expect(
            result.externalities!.first, kTopLeftVerticalScrollableDescription);
      });
      test('''When we have two lists that been scrolled 100px vertically
    and 50px horizontally respectivily, Should add the scroll to the y of
    widgetPosition of our interaction''', () {
        final service = ScrollAppliance();
        final result = service.applyScrollableOnInteraction(
          [
            kTopLeftVerticalScrollableDescription,
            kTopLeftHorizontalScrollableDescription
          ],
          kTouchableInteraction,
        );
        expect(result.position.y, kTouchableInteraction.position.y + 100);
        expect(result.position.x, kTouchableInteraction.position.x + 50);
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
        final service = ScrollAppliance();
        final result = service.applyScrollableOnInteraction(
          [
            kFullScreenVerticalScrollableDescription,
            kTopLeftHorizontalScrollableDescription
          ],
          kTouchableInteraction,
        );
        final largestSd = result.externalities!.reduce(
            (curr, next) => curr.rect.size > next.rect.size ? curr : next);
        final smallestSd = result.externalities!.reduce(
            (curr, next) => curr.rect.size < next.rect.size ? curr : next);

        expect(largestSd.rect.topLeft,
            kTopLeftVerticalScrollableDescription.rect.topLeft);
        expect(smallestSd.rect.top, 170);
      });
      test(
          '''When interaction type is scrollable and there is only one list below it,
            Shouldn't add the list to externalities of the interaction''', () {
        final service = ScrollAppliance();

        final result = service.applyScrollableOnInteraction(
          [kTopLeftVerticalScrollableDescription],
          kScrollableInteraction,
        );
        expect(result.externalities, isNull);
      });
      test(
          '''When interaction type is scrollable and there is two list below it,
            Should capture just the biggest one''', () {
        final service = ScrollAppliance();
        final biggestList = kTopLeftVerticalScrollableDescription.copyWith(
            rect: SerializableRect.fromLTWH(0, 0, 1000, 1000));

        final result = service.applyScrollableOnInteraction(
          [kTopLeftHorizontalScrollableDescription, biggestList],
          kScrollableInteraction,
        );
        expect(result.externalities!.length, 1);
        expect(result.externalities!.first, biggestList);
      });
    });

    group('findBiggestScrollable -', () {
      test('When provide two list, should return the biggest one', () {
        final service = ScrollAppliance();
        final biggestScroll = service.findBiggestScrollable([
          kFullScreenVerticalScrollableDescription,
          kTopLeftHorizontalScrollableDescription,
        ]);

        expect(biggestScroll, kFullScreenVerticalScrollableDescription);
      });
      test('''When provide two scrollables that shares the same horizontal long,
       should return the tallest one''', () {
        final service = ScrollAppliance();
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
