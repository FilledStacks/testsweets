import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:testsweets/src/app/logger.dart';
import 'package:testsweets/src/enums/toast_type.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/models/interaction.dart';
import 'package:testsweets/src/services/notification_extractor.dart';
import 'package:testsweets/src/services/snackbar_service.dart';
import 'package:testsweets/src/services/test_integrity.dart';
import 'package:testsweets/src/services/testsweets_route_tracker.dart';
import 'package:testsweets/src/services/widget_capture_service.dart';

class DriverLayoutViewModel extends BaseViewModel {
  final log = getLogger('DriverLayoutViewModel');
  final _snackbarService = locator<SnackbarService>();

  final _widgetCaptureService = locator<WidgetCaptureService>();
  final _testSweetsRouteTracker = locator<TestSweetsRouteTracker>();
  final _notificationExtractor = locator<NotificationExtractor>();

  final _notificationController = StreamController<Notification>.broadcast();
  final _testIntegrity = locator<TestIntegrity>();

  DriverLayoutViewModel({required projectId}) {
    _notificationController.stream
      ..listen(_testIntegrity.whenNotificationTypeMatchesConfirmCommand)
      ..where(_notificationExtractor.onlyScrollUpdateNotification)
          .map(_notificationExtractor.notificationToScrollableDescription)
          .listen((notification) => viewInteractions = _notificationExtractor
              .scrollInteractions(notification, viewInteractions));

    _widgetCaptureService.projectId = projectId;
  }

  ValueNotifier<List<Interaction>> descriptionsForViewNotifier =
      ValueNotifier([]);

  List<Interaction> get viewInteractions => descriptionsForViewNotifier.value;

  set viewInteractions(List<Interaction> widgetDescriptions) {
    descriptionsForViewNotifier.value = widgetDescriptions;
  }

  bool get currentViewCaptured => viewInteractions.any(
        (element) => element.widgetType == WidgetType.view,
      );

  // TODO (Refactor): This is absolutely terrible, I should not be doing this
  // but until Stacked gets a better snack bar implementation I can't do it any
  // other way.
  Future<void> initialise(BuildContext context) async {
    _snackbarService.setBuildContext(context);

    setBusy(true);
    try {
      await _widgetCaptureService.loadWidgetDescriptionsForProject(
        size: MediaQuery.of(context).size,
        orientation: MediaQuery.of(context).orientation,
      );
    } catch (e) {
      log.e('Could not get widgetDescriptions: $e');
    }
    getWidgetsForRoute();
    _testSweetsRouteTracker.addListener(getWidgetsForRoute);
    setBusy(false);
  }

  void getWidgetsForRoute() {
    viewInteractions = _widgetCaptureService.getDescriptionsForView(
      currentRoute: _testSweetsRouteTracker.currentRoute,
    );
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

  void interactionOnTap(Interaction widgetDescription) {
    notifyListeners();
    _snackbarService.showCustomSnackBar(
        message: widgetDescription.name, variant: SnackbarType.info);
  }
}
