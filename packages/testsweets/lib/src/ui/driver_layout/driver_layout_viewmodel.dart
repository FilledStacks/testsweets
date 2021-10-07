import 'package:stacked/stacked.dart';
import 'package:testsweets/src/app/app.logger.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:testsweets/src/services/testsweets_route_tracker.dart';
import 'package:testsweets/src/services/widget_capture_service.dart';

class DriverLayoutViewModel extends BaseViewModel {
  final log = getLogger('DriverLayoutViewModel');

  final _widgetCaptureService = locator<WidgetCaptureService>();
  final _testSweetsRouteTracer = locator<TestSweetsRouteTracker>();

  final String projectId;

  DriverLayoutViewModel({required this.projectId});

  List<WidgetDescription> get descriptionsForView =>
      _widgetCaptureService.getDescriptionsForView(
        currentRoute: _testSweetsRouteTracer.currentRoute,
      );

  Future<void> initialise() async {
    setBusy(true);
    try {
      await _widgetCaptureService.loadWidgetDescriptionsForProject(
        projectId: projectId,
      );
    } catch (e) {
      log.e('Could not get widgetDescriptions: $e');
    }
    setBusy(false);

    notifyListeners();

    _testSweetsRouteTracer.addListener(() {
      for (var widgetDescription in descriptionsForView) {
        print('Automation key: ${widgetDescription.automationKey}');
      }
      notifyListeners();
    });
  }
}
