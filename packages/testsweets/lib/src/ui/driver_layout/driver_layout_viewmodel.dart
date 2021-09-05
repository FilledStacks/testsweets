import 'package:stacked/stacked.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:testsweets/src/services/testsweets_route_tracker.dart';
import 'package:testsweets/src/services/widget_capture_service.dart';

class DriverLayoutViewModel extends BaseViewModel {
  final _widgetCaptureService = locator<WidgetCaptureService>();
  final _testSweetsRouteTracer = locator<TestSweetsRouteTracker>();

  List<WidgetDescription> get descriptionsForView =>
      _widgetCaptureService.getDescriptionsForView(
        currentRoute: _testSweetsRouteTracer.currentRoute,
      );

  Future<void> initialise() async {
    // TODO:1. Fetch widget descriptions

    // TODO:2. Indicate busy until fetched
    // TODO:3. Draw descriptions for view when ready

    _testSweetsRouteTracer.addListener(() {
      notifyListeners();
    });
  }
}
