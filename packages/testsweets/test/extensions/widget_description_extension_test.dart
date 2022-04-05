import 'package:flutter_test/flutter_test.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/extensions/widget_position_extension.dart';
import 'package:testsweets/testsweets.dart';

void main() {
  group('WidgetDescriptionExtensionTest -', () {
    group('responsiveXPosition -', () {
      test('''When capture a key with position x=100 on screenWidth = 200
   and new screenWidth is 500, Should adjust the position to x=250
   ''', () {
        final description = Interaction(
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
        expect(description.position.responsiveXPosition(500), 229);
      });
    });
    group('responsiveYPosition -', () {
      test('''When capture a key with position y=100 on screenWidth = 200
   and new screenWidth is 500, Should adjust the position to y=250
   ''', () {
        final description = Interaction(
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
        expect(description.position.responsiveYPosition(500), 229);
      });
    });
  });
}
