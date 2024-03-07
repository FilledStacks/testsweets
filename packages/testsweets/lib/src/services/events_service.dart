import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/models/outgoing_event.dart';
import 'package:testsweets/src/services/http_service.dart';
import 'package:testsweets/src/services/run_configuration_service.dart';
import 'package:testsweets/src/services/widget_capture_service.dart';

class EventsService {
  final httpService = locator<HttpService>();
  final widgetCaptureService = locator<WidgetCaptureService>();
  final runConfigurationService = locator<RunConfigurationService>();

  List<OutgoingEvent> events = [];
  List<OutgoingEvent> eventsForTestSweets = [];

  void captureEvent({
    required String name,
    required Map<String, dynamic> properties,
  }) {
    if (kReleaseMode) {
      return;
    }

    if (runConfigurationService.driveModeActive) {
    } else {
      _captureEventsForBackend(name: name, properties: properties);
    }
  }

  void _captureEventsForTestSweetsApp({
    required String name,
    required Map<String, dynamic> properties,
  }) {}

  void _captureEventsForBackend({
    required String name,
    required Map<String, dynamic> properties,
  }) {
    Timer _batchTimer = Timer(Duration(milliseconds: 500), _submitBatch);

    events.add(OutgoingEvent(
      name: name,
      properties: properties,
    ));

    if (events.length > 4) {
      _batchTimer.cancel();
      _submitBatch();
    }
  }

  void _submitBatch() {
    final eventsToSubmit = List<OutgoingEvent>.from(events.take(5));
    final endRange = events.length > 4 ? 5 : events.length;
    events.removeRange(0, endRange);

    httpService.captureEvents(
      projectId: widgetCaptureService.projectId,
      events: eventsToSubmit,
    );
  }
}
