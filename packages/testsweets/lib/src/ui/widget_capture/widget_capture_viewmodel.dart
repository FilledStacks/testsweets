import 'package:stacked/stacked.dart';
import 'package:testsweets/src/app/logger.dart';
import 'package:testsweets/src/constants/app_constants.dart';
import 'package:testsweets/src/enums/capture_widget_enum.dart';
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

  CaptureWidgetStatusEnum _captureWidgetStatusEnum =
      CaptureWidgetStatusEnum.idle;

  CaptureWidgetStatusEnum get captureWidgetStatusEnum =>
      _captureWidgetStatusEnum;

  set captureWidgetStatusEnum(CaptureWidgetStatusEnum captureWidgetStatusEnum) {
    _captureWidgetStatusEnum = captureWidgetStatusEnum;
    notifyListeners();
  }

  WidgetDescription? _widgetDescription;
  bool _hasWidgetNameFocus = false;
  String _activeWidgetId = '';
  bool _ignorePointer = false;
  bool widgetNameInputPositionIsDown = true;
  String _nameInputErrorMessage = '';

  WidgetDescription _activeWidgetDescription = WidgetDescription(
    name: '',
    position: WidgetPosition(x: 0, y: 0),
    viewName: '',
    widgetType: WidgetType.touchable,
  );

  List<WidgetDescription> get descriptionsForView =>
      _widgetCaptureService.getDescriptionsForView(
        currentRoute: _testSweetsRouteTracker.currentRoute,
      );
  WidgetDescription get activeWidgetDescription => _activeWidgetDescription;

  String get activeWidgetId => _activeWidgetId;

  bool get ignorePointer => _ignorePointer;
  bool get viewAlreadyCaptured => _widgetCaptureService
      .checkCurrentViewIfAlreadyCaptured(_testSweetsRouteTracker.currentRoute);

  bool get hasWidgetNameFocus => _hasWidgetNameFocus;

  WidgetDescription get widgetDescription => _widgetDescription!;

  // bool get hasWidgetDescription => _widgetDescription != null;

  double get descriptionTop =>
      _widgetDescription!.position.y - (WIDGET_DESCRIPTION_VISUAL_SIZE / 2);

  double get descriptionLeft =>
      _widgetDescription!.position.x - (WIDGET_DESCRIPTION_VISUAL_SIZE / 2);

  String get nameInputErrorMessage => _nameInputErrorMessage;

  WidgetCaptureViewModel({required this.projectId}) {
    initialise(projectId: projectId);
  }

  void toggleCaptureView() {
    if (captureWidgetStatusEnum.isAtCaptureMode())
      captureWidgetStatusEnum = CaptureWidgetStatusEnum.idle;
    else
      captureWidgetStatusEnum = CaptureWidgetStatusEnum.captureMode;
  }

  void toggleInspectLayout() {
    if (captureWidgetStatusEnum == CaptureWidgetStatusEnum.inspectMode)
      captureWidgetStatusEnum = CaptureWidgetStatusEnum.idle;
    else
      captureWidgetStatusEnum = CaptureWidgetStatusEnum.inspectMode;
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
      captureWidgetStatusEnum =
          CaptureWidgetStatusEnum.captureModeWidgetsContainerShow;
      _widgetDescription = null;
    } catch (e) {
      log.e('Couldn\'t save the widget. $e');
    }
  }

  void setWidgetNameFocused(bool hasFocus) {
    _hasWidgetNameFocus = hasFocus;
    notifyListeners();
  }

  void toggleWidgetsContainer() {
    if (captureWidgetStatusEnum ==
        CaptureWidgetStatusEnum.captureModeWidgetsContainerShow)
      captureWidgetStatusEnum = CaptureWidgetStatusEnum.captureModeAddWidget;
    else
      captureWidgetStatusEnum =
          CaptureWidgetStatusEnum.captureModeWidgetsContainerShow;
  }

  void addNewWidget(WidgetType widgetType, {WidgetPosition? widgetPosition}) {
    if (widgetType == WidgetType.view) {
      _widgetDescription =
          WidgetDescription.addView(_testSweetsRouteTracker.currentRoute);
      saveWidgetDescription();
    } else {
      _widgetDescription = WidgetDescription.addAtPosition(
          widgetType: widgetType, widgetPosition: widgetPosition);

      toggleWidgetsContainer();
      captureWidgetStatusEnum =
          CaptureWidgetStatusEnum.captureModeWidgetNameInputShow;
    }
  }

  void switchWidgetNameInputPosition() {
    widgetNameInputPositionIsDown = !widgetNameInputPositionIsDown;
    notifyListeners();
  }

  void closeWidgetNameInput() {
    _widgetDescription = null;
    toggleWidgetsContainer();
  }

  void showWidgetDescription(WidgetDescription description) {
    _activeWidgetDescription = description;
    _activeWidgetId = description.id ?? '';
    _ignorePointer = !_ignorePointer;
    captureWidgetStatusEnum = CaptureWidgetStatusEnum.inspectModeDialogShow;
  }

  void closeWidgetDescription() {
    _activeWidgetId = '';
    _ignorePointer = false;
    captureWidgetStatusEnum = CaptureWidgetStatusEnum.inspectMode;
  }
}
