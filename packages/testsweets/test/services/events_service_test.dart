import 'package:flutter_test/flutter_test.dart';
import 'package:testsweets/src/services/events_service.dart';

import '../helpers/test_helpers.dart';

EventsService _getService() => EventsService();

void main() {
  group('EventsServiceTest -', () {
    setUp(registerServices);
    tearDown(unregisterServices);

    group('captureEvent -', () {
      group('In capture mode -', () {});

      group('In drive mode -', () {
        test(
            'When called, should add the events to the eventsForTestSweets queue',
            () {
          getAndRegisterRunConfigurationService(
            driveModeActive: true,
          );
          final service = _getService();
          service.captureEvent(name: 'Button Tap', properties: {});
          expect(service.eventsForTestSweets.length, 1);
        });
      });
    });

    group('matchEvent -', () {
      test('When called, with no events, should return false', () {
        final service = _getService();
        final result = service.matchEvent(
          name: 'Button Tap',
          key: 'route',
          value: 'login',
        );
        expect(result, false);
      });

      test(
          'When called, with matching event, should return true and event list should be empty',
          () {
        getAndRegisterRunConfigurationService(driveModeActive: true);

        final service = _getService();

        service.captureEvent(
          name: 'Button Tap',
          properties: {
            'route': 'login',
          },
        );

        final result = service.matchEvent(
          name: 'Button Tap',
          key: 'route',
          value: 'login',
        );

        expect(result, true);
        expect(service.eventsForTestSweets.length, 0);
      });

      test(
          'When called and queue has matching event in 2nd position should return true and event list should have 1 item left',
          () {
        getAndRegisterRunConfigurationService(driveModeActive: true);

        final service = _getService();

        service.captureEvent(
          name: 'Navigate',
          properties: {
            'route': 'login',
          },
        );
        service.captureEvent(
          name: 'Button Tap',
          properties: {
            'route': 'login',
          },
        );
        service.captureEvent(
          name: 'Scroll',
          properties: {
            'route': 'login',
          },
        );

        final result = service.matchEvent(
          name: 'Button Tap',
          key: 'route',
          value: 'login',
        );

        expect(result, true);
        expect(service.eventsForTestSweets.length, 1);
      });
    });
  });
}
