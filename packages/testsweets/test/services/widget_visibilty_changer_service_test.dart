import 'package:flutter_test/flutter_test.dart';
import 'package:testsweets/src/services/sweetcore_command.dart';
import 'package:testsweets/src/services/widget_visibilty_changer_service.dart';

import '../helpers/test_consts.dart';
import '../helpers/test_helpers.dart';

final _service = WidgetVisibiltyChangerService();
void main() {
  group('WidgetVisibiltyChangerServiceTest -', () {
    setUp(registerServices);
    tearDown(unregisterServices);

    group('execute -', () {
      test('When the latestSweetcoreCommand is null, Should return null', () {
        expect(_service.execute(testWidgetDescription), null);
      });
      test(
          'When the latestSweetcoreCommand is not null, Should toggle visiabilty of the widget',
          () {
        _service.latestSweetcoreCommand =
            ScrollableCommand(widgetName: 'widgetName');

        /// Sence default visibilty is true
        expect(_service.execute(testWidgetDescription),
            testWidgetDescription.copyWith(visibility: false));
      });
    });
  });
}
