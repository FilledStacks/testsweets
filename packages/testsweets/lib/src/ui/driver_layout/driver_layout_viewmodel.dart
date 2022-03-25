import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:testsweets/src/app/logger.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:testsweets/src/services/notification_extractor.dart';
import 'package:testsweets/src/services/testsweets_route_tracker.dart';
import 'package:testsweets/src/services/widget_capture_service.dart';

class DriverLayoutViewModel extends BaseViewModel {
  final log = getLogger('DriverLayoutViewModel');

  final _widgetCaptureService = locator<WidgetCaptureService>();
  final _testSweetsRouteTracer = locator<TestSweetsRouteTracker>();
  final _notiExtr = locator<NotificationExtractor>();

  final _notificationController = StreamController<Notification>.broadcast();

  DriverLayoutViewModel({required projectId}) {
    _notificationController.stream
        .where(_notiExtr.onlyScrollUpdateNotification)
        .map(_notiExtr.notificationToScrollableDescription)
        .listen((notification) =>
            _notiExtr.scrollInteractions(notification, viewInteractions));

    _widgetCaptureService.projectId = projectId;
  }

  List<Interaction> viewInteractions = [];

  Future<void> initialise() async {
    setBusy(true);
    try {
      await _widgetCaptureService.loadWidgetDescriptionsForProject();
    } catch (e) {
      log.e('Could not get widgetDescriptions: $e');
    }
    getWidgetsForRoute();
    _testSweetsRouteTracer.addListener(getWidgetsForRoute);
    setBusy(false);
  }

  void getWidgetsForRoute() {
    viewInteractions = _widgetCaptureService.getDescriptionsForView(
        currentRoute: _testSweetsRouteTracer.currentRoute);
    notifyListeners();
  }

  bool automationKeyOnScreen(String automationKeyName) => viewInteractions.any(
        (element) => element.automationKey == automationKeyName,
      );

  bool onClientNotifiaction(Notification notification) {
    _notificationController.add(notification);

    /// We return false to keep the notification bubbling in the widget tree
    return false;
  }
}
