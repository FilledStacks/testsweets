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

  List<WidgetDescription> get descriptionsForView =>
      _widgetCaptureService.getDescriptionsForView(
        currentRoute: _testSweetsRouteTracker.currentRoute,
      );

  Future<void> initialise({required String projectId}) async {
    setBusy(true);
    try {
      await _widgetCaptureService.loadWidgetDescriptionsForProject(
        projectId: projectId,
      );
    } catch (e) {
      log.e('Could not get widgetDescriptions: $e');
    }
    setBusy(false);
  }

  WidgetDescription? _widgetDescription;
  bool _hasWidgetNameFocus = false;
  bool _captureViewEnabled = false;
  bool _widgetContainerEnabled = false;

  bool get viewAlreadyCaptured => _widgetCaptureService
      .checkCurrentViewIfAlreadyCaptured(_testSweetsRouteTracker.currentRoute);

  String _nameInputErrorMessage = '';

  String get nameInputErrorMessage => _nameInputErrorMessage;

  WidgetCaptureViewModel({required this.projectId}) {
    _widgetCaptureService.loadWidgetDescriptionsForProject(
        projectId: projectId);
    notifyListeners();
  }

  bool get captureViewEnabled => _captureViewEnabled;

  bool get hasWidgetNameFocus => _hasWidgetNameFocus;

  bool get widgetContainerEnabled => _widgetContainerEnabled;

  WidgetDescription get widgetDescription => _widgetDescription!;

  bool get hasWidgetDescription => _widgetDescription != null;

  double get descriptionTop =>
      _widgetDescription!.position.y - (WidgetDescriptionVisualSize / 2);

  double get descriptionLeft =>
      _widgetDescription!.position.x - (WidgetDescriptionVisualSize / 2);

  void toggleCaptureView() {
    _captureViewEnabled = !_captureViewEnabled;
    _inspectLayoutEnable = false;
    notifyListeners();
  }

  bool _inspectLayoutEnable = false;
  bool get inspectLayoutEnable => _inspectLayoutEnable;

  void toggleInspectLayout() {
    _inspectLayoutEnable = !_inspectLayoutEnable;
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
    openWidgetsContainer();
  }

  bool widgetNameInputPositionIsDown = true;
  void switchWidgetNameInputPosition() {
    widgetNameInputPositionIsDown = !widgetNameInputPositionIsDown;
    notifyListeners();
  }

  void closeWidgetNameInput() {
    _widgetContainerEnabled = true;
    _widgetDescription = null;
  }

  bool _showDescription = false;
  bool get showDescription => _showDescription;

  String _activeWidgetId = '';
  String get activeWidgetId => _activeWidgetId;

  bool _ignorePointer = false;
  bool get ignorePointer => _ignorePointer;

  WidgetDescription _activeWidgetDescription = WidgetDescription(
    name: '',
    position: WidgetPosition(x: 0, y: 0),
    viewName: '',
    widgetType: WidgetType.touchable,
  );
  WidgetDescription get activeWidgetDescription => _activeWidgetDescription;

  void showWidgetDescription(WidgetDescription description) {
    _activeWidgetDescription = description;
    _activeWidgetId = description.id ?? '';
    _showDescription = !_showDescription;
    _ignorePointer = !_ignorePointer;
    notifyListeners();
  }

  void closeWidgetDescription() {
    _activeWidgetId = '';
    _showDescription = false;
    _ignorePointer = false;
    notifyListeners();
  }
}
