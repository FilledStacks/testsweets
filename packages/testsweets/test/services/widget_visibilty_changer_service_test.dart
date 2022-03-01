import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:testsweets/src/enums/handler_message_response.dart';
import 'package:testsweets/src/services/sweetcore_command.dart';
import 'package:testsweets/src/services/widget_visibilty_changer_service.dart';

import '../helpers/test_consts.dart';
import '../helpers/test_helpers.dart';

void main() {
  group('WidgetVisibiltyChangerServiceTest -', () {
    setUp(registerServices);
    tearDown(unregisterServices);

    group('toggleVisibilty -', () {
      test(
          'When the latestSweetcoreCommand is not null, Should toggle visiabilty of the widget',
          () {
        final _service = WidgetVisibiltyChangerService();

        _service.sweetcoreCommand = ScrollableCommand(widgetName: 'widgetName');

        /// Sence default visibilty is true
        expect(
            _service
                .toggleVisibilty([kWidgetDescription1], [kWidgetDescription1]),
            [kWidgetDescription1.copyWith(visibility: false)]);
      });
    });
    group('completeCompleter -', () {
      test('When completeCompleter is called, Should complete the completer',
          () {
        final _service = WidgetVisibiltyChangerService();
        _service.completer = Completer();
        _service.completeCompleter(
            HandlerMessageResponse.foundAutomationKeyWithTargets);
        expect(_service.completer!.isCompleted, true);
      });
    });
    group('updateViewWidgetsList -', () {
      test('''When changing any proberty of some widget, Should be abe to
       replace it in descriptionsForView list''', () {
        final _service = WidgetVisibiltyChangerService();

        final result = _service.updateViewWidgetsList([
          kWidgetDescription2.copyWith(visibility: true)
        ], [
          kWidgetDescription1,
          kWidgetDescription2.copyWith(visibility: false)
        ]);
        expect(result.elementAt(1),
            kWidgetDescription2.copyWith(visibility: true));
      });
    });
  });

  group('filterTargetedWidgets -', () {
    test('When call, Should extract the targeted widgets by id', () {
      final _service = WidgetVisibiltyChangerService();
      final targetedWidgets =
          _service.filterTargetedWidgets(kWidgetDescription1.automationKey, [
        kWidgetDescription1.copyWith(targetIds: [kWidgetDescription2.id!]),
        kWidgetDescription2
      ]);
      expect(targetedWidgets.first, kWidgetDescription2);
    });
    test('When targetIds is empty, Should return empty list', () {
      final _service = WidgetVisibiltyChangerService();

      final targetedWidgets = _service.filterTargetedWidgets(
          kWidgetDescription1.automationKey, [kWidgetDescription1]);
      expect(targetedWidgets, isEmpty);
    });
  });
}
