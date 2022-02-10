import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/notification_listener.dart';
import 'package:stacked/stacked.dart';
import 'package:testsweets/src/app/logger.dart';
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

  List<WidgetDescription> get descriptionsForView =>
      _widgetCaptureService.getDescriptionsForView(
        currentRoute: _testSweetsRouteTracer.currentRoute,
      );

  Future<void> initialise() async {
    setBusy(true);
    try {
      await _widgetCaptureService.loadWidgetDescriptionsForProject();
    } catch (e) {
      log.e('Could not get widgetDescriptions: $e');
    }
    setBusy(false);

    notifyListeners();

    _testSweetsRouteTracer.addListener(() {
      notifyListeners();
    });
  }

  /// This will triggered when ever the client app
  /// populate a new event aka `notification`
  bool onClientAppEvent(Notification notification) {
    final latestSweetcoreCommandWidgetName =
        _widgetVisibiltyChangerService.latestSweetcoreCommand?.widgetName;
    try {
      if (notification is ScrollEndNotification &&
          latestSweetcoreCommandWidgetName != null) {
        final triggerWidget = descriptionsForView.firstWhere(
          (element) => element.name == latestSweetcoreCommandWidgetName,
        );
        final widgetAfterToggleVisibilty =
            _widgetVisibiltyChangerService.execute(triggerWidget);
        if (widgetAfterToggleVisibilty != null) {
          descriptionsForView.removeWhere(
              (element) => element.id == widgetAfterToggleVisibilty.id);
          descriptionsForView.add(widgetAfterToggleVisibilty);
        }
      }
    } on StateError catch (e) {
      log.e(
          'Coudn\'t find the widget name in the descriptionsForView list, $e');
    }

    /// By returning false we don't resolve the notification
    /// so it keeps populating up through the widget tree
    return false;
  }
}
