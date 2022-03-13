import 'package:flutter_test/flutter_test.dart';
import 'package:testsweets/src/extensions/widgets_description_list_extensions.dart';
import 'package:testsweets/testsweets.dart';

import '../helpers/test_consts.dart';

void main() {
  group('WidgetsDescriptionListExtensionsTest -', () {
    group('replaceInteractions -', () {
      test('When called, Should replace passed interactions with the new ones',
          () {
        final interactions = [kWidgetDescription1, kWidgetDescription2];
        final result = interactions.replaceInteractions([
          kWidgetDescription2.copyWith(position: WidgetPosition(x: 2, y: 2))
        ]);
        expect(result[1].position, WidgetPosition(x: 2, y: 2));
      });
    });
  });
}
