import 'package:flutter_test/flutter_test.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/extensions/widget_description_extension.dart';
import 'package:testsweets/testsweets.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('WidgetDescriptionExtensionTest -', () {
    setUp(registerServices);
    tearDown(unregisterServices);
    group('responsiveXPosition -', () {
      /// take into consideration the [WIDGET_DESCRIPTION_VISUAL_SIZE= 42]
      /// which is the key circle radius
      test('''When capture a key with position x=100 on screenWidth = 200
   and new screenWidth is 500, Should adjust the position to x=225
   ''', () {
        final description = WidgetDescription(
            name: 'name',
            originalViewName: '',
            viewName: '',
            widgetType: WidgetType.general,
            position: WidgetPosition(
              x: 100,
              y: 0,
              capturedDeviceWidth: 200,
              capturedDeviceHeight: 0,
            ));
        expect(description.responsiveXPosition(500), 229);
      });

      /// take into consideration the WIDGET_DESCRIPTION_VISUAL_SIZE= 50
      /// which is the key circle radius
      test('''When capture a key with position y=100 on screenWidth = 200
   and new screenWidth is 500, Should adjust the position to y=225
   ''', () {
        final description = WidgetDescription(
            name: 'name',
            originalViewName: '',
            viewName: '',
            widgetType: WidgetType.general,
            position: WidgetPosition(
              y: 100,
              x: 0,
              capturedDeviceWidth: 0,
              capturedDeviceHeight: 200,
            ));
        expect(description.responsiveYPosition(500), 229);
      });
    });
  });
}
