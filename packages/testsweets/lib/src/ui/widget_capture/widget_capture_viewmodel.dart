import 'package:stacked/stacked.dart';
import 'package:testsweets/src/app/logger.dart';
import 'package:testsweets/src/constants/app_constants.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:testsweets/src/models/enums/widget_type.dart';
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
  bool _widgetContainerEnabled = false;
  bool _viewAlreadyCaptured = true;

  bool get viewAlreadyCaptured => _viewAlreadyCaptured;

  String _nameInputErrorMessage = '';

  String get nameInputErrorMessage => _nameInputErrorMessage;

  WidgetCaptureViewModel({required this.projectId});

  bool get captureViewEnabled => _captureViewEnabled;

  bool get hasWidgetNameFocus => _hasWidgetNameFocus;

  bool get widgetContainerEnabled => _widgetContainerEnabled;

  WidgetDescription get widgetDescription => _widgetDescription!;

  bool get hasWidgetDesription => _widgetDescription != null;

  double get descriptionTop =>
      _widgetDescription!.position.y - (WidgetDiscriptionVisualSize / 2);

  double get descriptionLeft =>
      _widgetDescription!.position.x - (WidgetDiscriptionVisualSize / 2);

  void toggleCaptureView() {
    _captureViewEnabled = !_captureViewEnabled;
    notifyListeners();
  }

  void updateDescriptionPosition(double x, double y) {
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
    if (widgetNameValue?.isNotEmpty ?? false) {
      _nameInputErrorMessage = '';
      setBusy(true);
      _widgetDescription = _widgetDescription?.copyWith(
        viewName: _testSweetsRouteTracker.currentRoute,
      );

      log.i('descriptionToSave:$_widgetDescription');

      await sendWidgetDescriptionToFirestore();

      setBusy(false);
    } else if (_widgetDescription?.widgetType == WidgetType.view) {
      setBusy(true);
      _widgetDescription = _widgetDescription?.copyWith(
        viewName: _testSweetsRouteTracker.currentRoute,
      );

      await sendWidgetDescriptionToFirestore();
      setBusy(false);
    } else {
      _nameInputErrorMessage = 'Widget name must not be empty';
      notifyListeners();
    }
  }

  Future<void> sendWidgetDescriptionToFirestore() async {
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
  }

  void setWidgetNameFocused(bool hasFocus) {
    _hasWidgetNameFocus = hasFocus;
    notifyListeners();
  }

  void closeWidgetsContainer() {
    _widgetContainerEnabled = false;
    notifyListeners();
  }

  void openWidgetsContainer() {
    _widgetContainerEnabled = true;
    notifyListeners();
  }

  void addNewWidget(WidgetType widgetType, {WidgetPosition? widgetPosition}) {
    if (widgetType == WidgetType.view) {
      _widgetDescription =
          WidgetDescription.addView(_testSweetsRouteTracker.currentRoute);
      saveWidgetDescription();
    } else {
      _widgetDescription = WidgetDescription.addAtPosition(
          widgetType: widgetType, widgetPosition: widgetPosition);
      closeWidgetsContainer();
    }
  }

  bool widgetNameInputPositionIsDown = true;
  void switchWidgetNameInputPosition() {
    widgetNameInputPositionIsDown = !widgetNameInputPositionIsDown;
    notifyListeners();
  }

  void closeWidgetNameInput() {
    _widgetContainerEnabled = true;
    _widgetDescription = null;
    notifyListeners();
  }
}
