import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/models/outgoing_event.dart';
import 'package:testsweets/src/services/http_service.dart';
import 'package:testsweets/src/services/run_configuration_service.dart';
import 'package:testsweets/src/services/widget_capture_service.dart';
import 'package:testsweets/src/utils/batch_processing/batch_processors.dart';

class EventsService {
  final httpService = locator<HttpService>();
  final widgetCaptureService = locator<WidgetCaptureService>();
  final runConfigurationService = locator<RunConfigurationService>();
  final eventsProcessor = locator<EventsProcessor>();

  List<OutgoingEvent> events = [];
  Queue<OutgoingEvent> eventsForTestSweets = Queue<OutgoingEvent>();

  EventsService() {
    if (!kReleaseMode) {
      eventsProcessor.batchProcessingStream.listen((eventsToProcess) {
        httpService.captureEvents(
          projectId: widgetCaptureService.projectId,
          events: eventsToProcess,
        );
      });
    }
  }

  void captureEvent({
    required String name,
    required Map<String, dynamic> properties,
  }) {
    if (kReleaseMode) {
      return;
    }

    // print(
    //     '🍬 TESTSWEETS :: captureEvent driveMode: ${runConfigurationService.driveModeActive}');

    if (runConfigurationService.driveModeActive) {
      _captureEventsForTestSweetsApp(name: name, properties: properties);
    } else {
      _captureEventsForBackend(name: name, properties: properties);
    }
  }

  void _captureEventsForTestSweetsApp({
    required String name,
    required Map<String, dynamic> properties,
  }) {
    eventsForTestSweets.add(OutgoingEvent(
      name: name,
      properties: properties,
    ));
  }

  void _captureEventsForBackend({
    required String name,
    required Map<String, dynamic> properties,
  }) {
    // print(
    //     '🍬 TESTSWEETS :: _captureEventsForBackend name:$name properties:$properties');

    eventsProcessor.addItem(OutgoingEvent(
      name: name,
      properties: properties,
    ));
  }

  bool matchEvent({
    required String name,
    required String key,
    required String value,
  }) {
    // print(
    //     '🍬🍬🍬🍬🍬🍬 TESTSWEETS :: matchEvent name:$name, key:$key, value:$value');
    // print(
    //     '🍬🍬🍬🍬🍬🍬 TESTSWEETS :: eventsForTestSweets ${eventsForTestSweets.join('\n')}');
    while (eventsForTestSweets.isNotEmpty) {
      final item = eventsForTestSweets.removeFirst();

      // print('🍬🍬🍬🍬🍬🍬 TESTSWEETS :: matchEvent - item:${item}');
      if (item.name == name &&
          item.properties.containsKey(key) &&
          item.properties[key].toString() == value) {
        return true;
      }
    }

    // print(
    //     '🍬🍬🍬🍬🍬🍬 TESTSWEETS :: matchEvent failed. no match for name:$name, key:$key, value:$value');

    return false;
  }
}
