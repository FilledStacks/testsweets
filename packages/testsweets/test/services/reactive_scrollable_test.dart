import 'package:flutter_test/flutter_test.dart';
import 'package:testsweets/src/extensions/scrollable_description_extension.dart';
import 'package:testsweets/src/services/reactive_scrollable.dart';

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
          [kTopLeftScrollableDescription],
          kWidgetDescriptionTypeScroll1,
        );
        expect(
            result.position.y, kWidgetDescriptionTypeScroll1.position.y + 100);
      });
      test(
          'When we have one scrollable, Should add the hash to externalities Set',
          () {
        final service = ReactiveScrollable();
        final result = service.applyScrollableOnInteraction(
          [kTopLeftScrollableDescription],
          kWidgetDescriptionTypeScroll1,
        );
        expect(result.externalities.first,
            kTopLeftScrollableDescription.generateHash);
      });
      test('''When we have two scrollables that been scrolled 100px vertically
    and 50px horizontally, Should add the scroll to the y of
    widgetPosition of our interaction''', () {
        final service = ReactiveScrollable();
        final result = service.applyScrollableOnInteraction(
          [kTopLeftScrollableDescription, kAnotherTopLeftScrollableDescription],
          kWidgetDescriptionTypeScroll1,
        );
        expect(
            result.position.y, kWidgetDescriptionTypeScroll1.position.y + 100);
        expect(
            result.position.x, kWidgetDescriptionTypeScroll1.position.x + 50);
      });
    });
  });
}
