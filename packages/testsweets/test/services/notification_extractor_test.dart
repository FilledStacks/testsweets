import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testsweets/src/services/notification_extractor.dart';
import 'package:testsweets/src/services/reactive_scrollable.dart';
import 'package:testsweets/testsweets.dart';

import '../helpers/test_consts.dart';
import '../helpers/test_helpers.dart';

final _service = NotificationExtractorImp();

void main() {
  group('NotificationExtractorTest -', () {
    setUp(registerServices);
    tearDown(unregisterServices);

    group('reactToScroll -', () {
      test('''
        When called on multiple interactions,
        Should pick the overlapping one add the scrollExtent
        to the YTranslit if the scrollable is vertical
        ''', () async {
        registerServiceInsteadOfMockedOne(ReactiveScrollable());

        var viewInteraction = [
          kGeneralInteractionWithZeroOffset.copyWith(
            externalities: {
              ScrollableDescription(
                rect: SerializableRect.fromLTWH(0, 0, 0, 0),
                axis: Axis.vertical,
                maxScrollExtentByPixels: 0,
                scrollExtentByPixels: 0,
              ),
            },
          ),
          kGeneralInteraction
        ];

        final result = _service.scrollInteractions(
            kTopLeftVerticalScrollableDescription, viewInteraction);

        /// It should be the first item not the second but replaceing
        /// widget adds the widget at the end of the list
        expect(result[1].position.yDeviation, 100);
      });
      test('''
            When repeating the same scroll but now the interaction is already scrolled vertically
            So YTranslate not null
          ''', () async {
        registerServiceInsteadOfMockedOne(ReactiveScrollable());

        final viewInteraction = [
          kGeneralInteractionWithZeroOffset.copyWith(
              position: WidgetPosition(x: 0, y: 0, yDeviation: 100),
              externalities: {
                ScrollableDescription(
                  rect: SerializableRect.fromLTWH(0, 0, 0, 0),
                  axis: Axis.vertical,
                  maxScrollExtentByPixels: 0,
                  scrollExtentByPixels: 0,
                ),
              }),
          kGeneralInteraction
        ];

        final result = _service.scrollInteractions(
            kTopLeftVerticalScrollableDescription, viewInteraction);

        /// It should be the first item not the second but replaceing
        /// widget adds the widget at the end of the list
        expect(result[1].position.yDeviation, 100);
      });
      test('''
          When called two times(one vertical list and one horizontal) on one interaction,
          Should add the scrollExtent once for YTranslate and once for XTranslate
          ''', () async {
        registerServiceInsteadOfMockedOne(ReactiveScrollable());

        final viewInteraction = [
          kGeneralInteractionWithZeroOffset
              .copyWith(position: WidgetPosition(x: 21, y: 22), externalities: {
            // captured vertical list rect
            ScrollableDescription(
              rect: SerializableRect.fromLTWH(0, 0, 0, 0),
              axis: Axis.vertical,
              maxScrollExtentByPixels: 0,
              scrollExtentByPixels: 0,
            ),

            // captured horizontal list rect which is nested inside
            // the virtical one
            ScrollableDescription(
              nested: true,
              rect: SerializableRect.fromLTWH(0, 20, 0, 0),
              axis: Axis.horizontal,
              maxScrollExtentByPixels: 0,
              scrollExtentByPixels: 0,
            ),
          }),
          kGeneralInteraction
        ];

        final verticalScrollResult = _service.scrollInteractions(
            kTopLeftVerticalScrollableDescription, viewInteraction);

        /// Assumming that the horizontal list inside the vertical one
        /// it should move after the we scroll the vertical and that will change its rect
        /// so we will change it now manually to emulate the flutter scroll change
        final horizontalScrollableDescription =
            kTopLeftHorizontalScrollableDescription.copyWith(
          rect: SerializableRect.fromPoints(
            Offset(
              0,
              20 + 100, // where 100 is the scroll result from the vertical list
            ),
            Offset(
              40,
              40 + 100,
            ),
          ),
        );

        final horizontlScrollResult = _service.scrollInteractions(
            horizontalScrollableDescription, verticalScrollResult);

        /// It should be the first index(0) not the second(1) but when
        /// replacing an interaciton it adds it at the end of the list
        expect(horizontlScrollResult[1].position.yDeviation, 100);
        expect(horizontlScrollResult[1].position.xDeviation, 50);
      });
    });
  });
}
