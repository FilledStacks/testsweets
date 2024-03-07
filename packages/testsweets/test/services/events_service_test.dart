import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:testsweets/src/models/outgoing_event.dart';
import 'package:testsweets/src/services/events_service.dart';

import '../helpers/test_helpers.dart';

EventsService _getService() => EventsService();

void main() {
  group('EventsServiceTest -', () {
    setUp(registerServices);
    tearDown(unregisterServices);

    group('captureEvent -', () {
      group('In capture mode -', () {
        test(
            'When given event with name and properties, should add it to list of events',
            () {
          final service = _getService();
          service.captureEvent(name: 'Button Tap', properties: {});
          expect(service.events.length, 1);
        });

        test(
            'When called 6 times, should submit the events to the backend only once',
            () async {
          getAndRegisterWidgetCaptureService(
            projectId: 'projectId',
          );
          final httpService = getAndRegisterHttpService();
          final service = _getService();

          for (var i = 0; i < 6; i++) {
            service.captureEvent(name: 'Button Tap $i', properties: {});
          }

          await Future.delayed(Duration(milliseconds: 5));

          verify(httpService.captureEvents(
            projectId: 'projectId',
            events: [
              OutgoingEvent(name: 'Button Tap 0', properties: {}),
              OutgoingEvent(name: 'Button Tap 1', properties: {}),
              OutgoingEvent(name: 'Button Tap 2', properties: {}),
              OutgoingEvent(name: 'Button Tap 3', properties: {}),
              OutgoingEvent(name: 'Button Tap 4', properties: {})
            ],
          ));

          expect(service.events.length, 1);
        });

        test(
            'When called 4 times, and we wait 500ms, should call the captureEvents function',
            () async {
          getAndRegisterWidgetCaptureService(
            projectId: 'projectId',
          );
          final httpService = getAndRegisterHttpService();
          final service = _getService();

          for (var i = 0; i < 4; i++) {
            service.captureEvent(name: 'Button Tap $i', properties: {});
          }

          await Future.delayed(Duration(milliseconds: 500));

          verify(httpService.captureEvents(
            projectId: 'projectId',
            events: [
              OutgoingEvent(name: 'Button Tap 0', properties: {}),
              OutgoingEvent(name: 'Button Tap 1', properties: {}),
              OutgoingEvent(name: 'Button Tap 2', properties: {}),
              OutgoingEvent(name: 'Button Tap 3', properties: {}),
            ],
          ));

          expect(service.events.length, 0);
        });

        test(
            'When called 6 times, should call submit the captureEvents function twice, once after 5th call, and another after 500ms',
            () async {
          getAndRegisterWidgetCaptureService(
            projectId: 'projectId',
          );
          final httpService = getAndRegisterHttpService();
          final service = _getService();

          for (var i = 0; i < 6; i++) {
            service.captureEvent(name: 'Button Tap $i', properties: {});
          }

          await Future.delayed(Duration(milliseconds: 5));

          verify(httpService.captureEvents(
            projectId: 'projectId',
            events: [
              OutgoingEvent(name: 'Button Tap 0', properties: {}),
              OutgoingEvent(name: 'Button Tap 1', properties: {}),
              OutgoingEvent(name: 'Button Tap 2', properties: {}),
              OutgoingEvent(name: 'Button Tap 3', properties: {}),
              OutgoingEvent(name: 'Button Tap 4', properties: {}),
            ],
          ));
          expect(service.events.length, 1);

          await Future.delayed(Duration(milliseconds: 500));

          verify(httpService.captureEvents(
            projectId: 'projectId',
            events: [
              OutgoingEvent(name: 'Button Tap 5', properties: {}),
            ],
          ));

          expect(service.events.length, 0);
        });
      });

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
