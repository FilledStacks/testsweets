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
      test('''When we have one scrollable that been scrolled 100px vertically, 
    Should add the scroll to the y of widgetPosition of our interaction''', () {
        final service = ScrollAppliance();
        final result = service.applyScrollableOnInteraction(
          [kTopLeftVerticalScrollableDescription],
          kScrollableInteraction,
        );
        expect(result.position.y, kScrollableInteraction.position.y + 100);
      });

      test(
          'When we have one scrollable, Should add the rect to externalities Set',
          () {
        final service = ScrollAppliance();
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
        final service = ScrollAppliance();
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
        final service = ScrollAppliance();
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
