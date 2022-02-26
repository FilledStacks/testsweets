import 'package:flutter_test/flutter_test.dart';
import 'package:testsweets/src/services/sweetcore_command.dart';
import 'package:testsweets/src/services/widget_visibilty_changer_service.dart';

import '../helpers/test_consts.dart';
import '../helpers/test_helpers.dart';

void main() {
  group('WidgetVisibiltyChangerServiceTest -', () {
    setUp(registerServices);
    tearDown(unregisterServices);

    group('toggleVisibilty -', () {
      test('When the latestSweetcoreCommand is null, Should return null', () {
        final _service = WidgetVisibiltyChangerService();

        expect(_service.toggleVisibilty([kTestWidgetDescription]), null);
      });
      test(
          'When the latestSweetcoreCommand is not null, Should toggle visiabilty of the widget',
          () {
        final _service = WidgetVisibiltyChangerService();

        _service.sweetcoreCommand = ScrollableCommand(widgetName: 'widgetName');

        /// Sence default visibilty is true
        expect(_service.toggleVisibilty([kTestWidgetDescription]),
            [kTestWidgetDescription.copyWith(visibility: false)]);
      });
    });
    group('completeCompleter -', () {
      test('When completeCompleter is called, Should complete the completer',
          () {
        final _service = WidgetVisibiltyChangerService();

        _service.completeCompleter('');
        expect(_service.completer.isCompleted, true);
      });
    });
  });
}
