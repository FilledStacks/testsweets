import 'package:stacked/stacked.dart';
import 'package:testsweets/src/app/logger.dart';
import 'package:testsweets/src/constants/app_constants.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:testsweets/src/services/testsweets_route_tracker.dart';
import 'package:testsweets/src/services/widget_capture_service.dart';

import 'widget_capture_view.form.dart';

class WidgetCaptureViewModel extends FormViewModel {
  final log = getLogger('WidgetCaptureViewModel');

  final String projectId;

  final _testSweetsRouteTracker = locator<TestSweetsRouteTracker>();
  final _widgetCaptureService = locator<WidgetCaptureService>();

  WidgetDescription? _widgetDescription;
  bool _hasWidgetNameFocus = false;
  bool _captureViewEnabled = false;

  WidgetCaptureViewModel({required this.projectId});

  bool get captureViewEnabled => _captureViewEnabled;

  bool get hasWidgetNameFocus => _hasWidgetNameFocus;

  WidgetDescription get widgetDescription => _widgetDescription!;

  bool get hasWidgetDesription => _widgetDescription != null;

  double get descriptionTop =>
      _widgetDescription!.position.y - (WidgetDiscriptionVisualSize / 2);

  double get descriptionLeft =>
      _widgetDescription!.position.x - (WidgetDiscriptionVisualSize / 2);

  void addWidgetAtTap({required double x, required double y}) {
    log.i('x:$x y:$y');

    _widgetDescription =
        WidgetDescription.positionOnly(position: WidgetPosition(x: x, y: y));

    notifyListeners();
  }

  void toggleCaptureView() {
    _captureViewEnabled = !_captureViewEnabled;
    notifyListeners();
  }

  void updateDescriptionPosition(double x, double y) {
    // log.i('x:$x y:$y');
    _widgetDescription = _widgetDescription!.copyWith(
      position: WidgetPosition(
        x: _widgetDescription!.position.x + x,
        y: _widgetDescription!.position.y + y,
      ),
    );

    notifyListeners();
  }

  @override
  void setFormStatus() {
    _widgetDescription =
        _widgetDescription?.copyWith(name: widgetNameValue ?? '');
  }

  Future<void> saveWidgetDescription() async {
    setBusy(true);
    _widgetDescription = _widgetDescription?.copyWith(
      viewName: _testSweetsRouteTracker.currentRoute,
    );

    log.i('descriptionToSave:$_widgetDescription');

    try {
      await _widgetCaptureService.captureWidgetDescription(
        description: _widgetDescription!,
        projectId: projectId,
      );

      _widgetDescription = null;
      notifyListeners();
    } catch (e) {
      log.e('Couldn\'t save the widget. $e');
    }

    setBusy(false);
  }

  void setWidgetNameFocused(bool hasFocus) {
    _hasWidgetNameFocus = hasFocus;
    notifyListeners();
  }
}
