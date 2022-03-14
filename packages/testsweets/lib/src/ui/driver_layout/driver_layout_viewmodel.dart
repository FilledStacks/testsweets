import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:testsweets/src/app/logger.dart';
import 'package:testsweets/src/enums/handler_message_response.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:testsweets/src/services/testsweets_route_tracker.dart';
import 'package:testsweets/src/services/widget_capture_service.dart';
import 'package:testsweets/src/services/widget_visibilty_changer_service.dart';

class DriverLayoutViewModel extends BaseViewModel {
  final log = getLogger('DriverLayoutViewModel');

  final _widgetCaptureService = locator<WidgetCaptureService>();
  final _testSweetsRouteTracer = locator<TestSweetsRouteTracker>();
  final _widgetVisibiltyChangerService =
      locator<WidgetVisibiltyChangerService>();

  DriverLayoutViewModel({required projectId}) {
    _widgetCaptureService.projectId = projectId;
  }

  List<Interaction> descriptionsForView = [];

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
    descriptionsForView = _widgetCaptureService.getDescriptionsForView(
        currentRoute: _testSweetsRouteTracer.currentRoute);
    notifyListeners();
  }

  /// This will triggered whenever the client app
  /// populate a new event aka `notification`
  ///
  /// By returning false we don't resolve the notification
  /// so it keeps populating up through the widget tree
  bool onClientAppEvent(Notification notification) {
    final automationKeyName =
        _widgetVisibiltyChangerService.sweetcoreCommand?.widgetName;

    // When widget name is null abort
    if (automationKeyName == null) return false;

    if (notification is ScrollEndNotification &&
        automationKeyOnScreen(automationKeyName)) {
      final newDescriptionsForView = _widgetVisibiltyChangerService
          .runToggleVisibiltyChecker(
              notification, automationKeyName, descriptionsForView)
          ?.toList();
      if (newDescriptionsForView != null)
        descriptionsForView = newDescriptionsForView;
    } else {
      _widgetVisibiltyChangerService
          .completeCompleter(HandlerMessageResponse.couldnotFindAutomationKey);
    }
    notifyListeners();

    return false;
  }

  bool automationKeyOnScreen(String automationKeyName) =>
      descriptionsForView.any(
        (element) => element.automationKey == automationKeyName,
      );
}
