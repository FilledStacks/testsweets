import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testsweets/src/extensions/widgets_description_list_extensions.dart';
import 'package:testsweets/testsweets.dart';

import '../helpers/test_consts.dart';

void main() {
  group('WidgetsDescriptionListExtensionsTest -', () {
    group('replaceInteractions -', () {
      test('When called, Should replace passed interactions with the new ones',
          () {
        final interactions = [
          kGeneralInteractionWithZeroOffset,
          kGeneralInteraction
        ];
        final result = interactions.replaceInteractions([
          kGeneralInteraction.updatePosition(
            x: 2,
            y: 2,
            currentWidth: 0,
            currentHeight: 0,
            orientation: Orientation.landscape,
          )
        ]);
        expect(
          result[1].renderPosition,
          WidgetPosition(
            x: 2,
            y: 2,
            capturedDeviceHeight: 0,
            capturedDeviceWidth: 0,
            orientation: Orientation.landscape,
            active: true,
          ),
        );
      });
    });
  });
}
