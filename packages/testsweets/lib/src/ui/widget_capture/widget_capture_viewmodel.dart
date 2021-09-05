import 'package:stacked/stacked.dart';
import 'package:testsweets/src/app/app.logger.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:testsweets/src/services/testsweets_route_tracker.dart';

import 'widget_capture_view.form.dart';

const double WidgetDiscriptionVisualSize = 40;

class WidgetCaptureViewModel extends FormViewModel {
  final log = getLogger('WidgetCaptureViewModel');

  final _testSweetsRouteTracker = locator<TestSweetsRouteTracker>();

  WidgetDescription? _widgetDescription;

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

  void updateDescriptionPosition(double x, double y) {
    log.i('x:$x y:$y');
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
    final descriptionToSave = _widgetDescription?.copyWith(
      viewName: _testSweetsRouteTracker.currentRoute,
    );

    log.i('descriptionToSave:$descriptionToSave');
  }
}
