import 'dart:async';

import 'package:stacked/stacked.dart';
import 'package:testsweets/src/app/logger.dart';
import 'package:testsweets/src/enums/capture_widget_enum.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/extensions/capture_widget_status_enum_extension.dart';
import 'package:testsweets/src/extensions/string_extension.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:testsweets/src/models/widget_form_info_model.dart';
import 'package:testsweets/src/services/testsweets_route_tracker.dart';
import 'package:testsweets/src/services/widget_capture_service.dart';

class WidgetCaptureViewModel extends BaseViewModel {
  final log = getLogger('WidgetCaptureViewModel');

  final _testSweetsRouteTracker = locator<TestSweetsRouteTracker>();
  final _widgetCaptureService = locator<WidgetCaptureService>();
  CaptureWidgetStatusEnum _captureWidgetStatusEnum =
      CaptureWidgetStatusEnum.widgetTypeSelector;
  set captureWidgetStatusEnum(CaptureWidgetStatusEnum captureWidgetStatusEnum) {
    _captureWidgetStatusEnum = captureWidgetStatusEnum;
    notifyListeners();
  }

  WidgetCaptureViewModel({required String projectId}) {
    _widgetCaptureService.projectId = projectId;
  }

  WidgetDescription? _widgetDescription;
  WidgetDescription? get widgetDescription => _widgetDescription;

  List<WidgetDescription> get descriptionsForView =>
      _widgetCaptureService.getDescriptionsForView(
        currentRoute: _testSweetsRouteTracker.currentRoute,
      );

  Future<void> loadWidgetDescriptions() async {
    setBusy(true);
    try {
      await _widgetCaptureService.loadWidgetDescriptionsForProject();
    } catch (e) {
      log.e('Could not get widgetDescriptions: $e');
      setError('Could not get widgetDescriptions: $e');
    }
    setBusy(false);
  }

  void onWidgetTypeSelected(WidgetType widgetType) async {
    _widgetDescription = WidgetDescription(widgetType: widgetType);
    captureWidgetStatusEnum = CaptureWidgetStatusEnum.widgetInfoForm;
  }

  Future<void> saveWidget(
      {required String name, required bool visibilty}) async {
    setBusy(true);
    _widgetDescription = _widgetDescription?.copyWith(
        visibility: visibilty,
        viewName:
            _testSweetsRouteTracker.currentRoute.convertViewNameToValidFormat,
        originalViewName: _testSweetsRouteTracker.currentRoute,
        name: name.convertWidgetNameToValidFormat);

    log.i('descriptionToSave:$_widgetDescription');

    final result = await _widgetCaptureService.createWidgetDescription(
        description: widgetDescription!);

    if (result is String) {
      setError(result);
    } else {
      captureWidgetStatusEnum = CaptureWidgetStatusEnum.widgetTypeSelector;
      _widgetDescription = null;
    }

    setBusy(false);
  }

  void closeInfoForm() {
    captureWidgetStatusEnum = CaptureWidgetStatusEnum.widgetTypeSelector;
  }

  CaptureWidgetStatusEnum get captureWidgetStatusEnum =>
      _captureWidgetStatusEnum;

  void updateDescriptionPosition(
    double x,
    double y,
    double capturedDeviceWidth,
    double capturedDeviceHeight,
  ) {
    _widgetDescription = _widgetDescription!.copyWith(
      position: WidgetPosition(
        capturedDeviceHeight: capturedDeviceHeight,
        capturedDeviceWidth: capturedDeviceWidth,
        x: (_widgetDescription!.position?.x ?? capturedDeviceWidth / 2) + x,
        y: (_widgetDescription!.position?.y ?? capturedDeviceHeight / 2) + y,
      ),
    );
    notifyListeners();
  }
  // bool _hasWidgetNameFocus = false;
  // bool get hasWidgetNameFocus => _hasWidgetNameFocus;
  // void setWidgetNameFocused(bool hasFocus) {
  //   _hasWidgetNameFocus = hasFocus;
  //   notifyListeners();
  // }
  // String get rightViewName => _testSweetsRouteTracker.rightViewName;

  // String get leftViewName => _testSweetsRouteTracker.leftViewName;

  // bool get isNestedView => _testSweetsRouteTracker.isNestedView;
  // bool get isChildRouteActivated =>
  //     _testSweetsRouteTracker.isChildRouteActivated;

  // void toggleBetweenParentRouteAndChildRoute() =>
  //     _testSweetsRouteTracker.toggleActivatedRouteBetweenParentAndChild();

  /// the status enum that express the current state of the view

  // bool _widgetNameInputPositionIsDown = true;
  // bool get widgetNameInputPositionIsDown => _widgetNameInputPositionIsDown;

  // String _inputErrorMessage = '';
  // String get nameInputErrorMessage => _inputErrorMessage;

  // void toggleCaptureView() {
  //   if (captureWidgetStatusEnum.isAtCaptureMode)
  //     captureWidgetStatusEnum = CaptureWidgetStatusEnum.idle;
  //   else
  //     captureWidgetStatusEnum = CaptureWidgetStatusEnum.captureMode;
  // }

  // void toggleInspectLayout() {
  //   if (captureWidgetStatusEnum == CaptureWidgetStatusEnum.inspectMode)
  //     captureWidgetStatusEnum = CaptureWidgetStatusEnum.idle;
  //   else
  //     captureWidgetStatusEnum = CaptureWidgetStatusEnum.inspectMode;
  // }

  // Future<void> saveWidgetDescription() async {
  //   if (_isEmpty()) return;

  //   setBusy(true);
  //   _widgetDescription = _widgetDescription?.copyWith(
  //       viewName:
  //           _testSweetsRouteTracker.currentRoute.convertViewNameToValidFormat,
  //       originalViewName: _testSweetsRouteTracker.currentRoute,
  //       name: widgetNameValue!.convertWidgetNameToValidFormat);

  //   log.i('descriptionToSave:$_widgetDescription');

  //   await sendWidgetDescriptionToFirestore();

  //   setBusy(false);
  // }

  // bool _isEmpty() {
  //   if (widgetNameValue!.trim().isEmpty) {
  // _inputErrorMessage = ErrorMessages.widgetInputNameIsEmpty;
  //     notifyListeners();
  //     return true;
  //   } else {
  //     _inputErrorMessage = '';
  //     return false;
  //   }
  // }

  // void toggleWidgetsContainer() {
  //   if (captureWidgetStatusEnum ==
  //       CaptureWidgetStatusEnum.captureModeWidgetsContainerShow)
  //     captureWidgetStatusEnum = CaptureWidgetStatusEnum.captureModeAddWidget;
  //   else
  //     captureWidgetStatusEnum =
  //         CaptureWidgetStatusEnum.captureModeWidgetsContainerShow;
  // }

  // Future<void> addNewWidget(
  //     WidgetType widgetType, WidgetPosition widgetPosition) async {
  //   _widgetDescription = WidgetDescription.addAtPosition(
  //       widgetType: widgetType, widgetPosition: widgetPosition);

  //   if (!_widgetCaptureService.checkCurrentViewIfAlreadyCaptured(
  //       _testSweetsRouteTracker.currentRoute))
  //     _captureViewWhenItsNotAlreadyCaptured();

  //   _showInputTextField();
  // }

  // Future<void> _captureViewWhenItsNotAlreadyCaptured() async {
  //   try {
  //     _widgetCaptureService.captureWidgetDescription(
  //         description: WidgetDescription.addView(
  //             viewName: _testSweetsRouteTracker
  //                 .currentRoute.convertViewNameToValidFormat,
  //             originalViewName: _testSweetsRouteTracker.currentRoute),
  //         projectId: projectId);
  //     syncWithFirestoreWidgetKeys(projectId: projectId, enableBusy: false);
  //   } catch (e) {
  //     log.e("couldn't capture the view : $e");
  //     //should add a way to notify the user that something wrong happened
  //     captureWidgetStatusEnum = CaptureWidgetStatusEnum.captureMode;
  //   }
  // }

  // void _showInputTextField() {
  //   toggleWidgetsContainer();
  //   captureWidgetStatusEnum =
  //       CaptureWidgetStatusEnum.captureModeWidgetNameInputShow;
  // }

  // void switchWidgetNameInputPosition() {
  //   _widgetNameInputPositionIsDown = !widgetNameInputPositionIsDown;
  //   notifyListeners();
  // }

  // void closeWidgetNameInput() {
  //   _inputErrorMessage = '';
  //   if (captureWidgetStatusEnum == CaptureWidgetStatusEnum.inspectModeUpdate) {
  //     toggleUpdateMode();
  //   } else {
  //     _widgetDescription = null;
  //     toggleWidgetsContainer();
  //   }
  // }

  // void showWidgetDescription(WidgetDescription description) {
  //   _widgetDescription = description;
  //   captureWidgetStatusEnum = CaptureWidgetStatusEnum.inspectModeDialogShow;
  // }

  // void closeWidgetDescription() {
  //   _widgetDescription = null;
  //   captureWidgetStatusEnum = CaptureWidgetStatusEnum.inspectMode;
  // }

  // void toggleUpdateMode() {
  //   if (captureWidgetStatusEnum == CaptureWidgetStatusEnum.inspectModeUpdate)
  //     captureWidgetStatusEnum = CaptureWidgetStatusEnum.inspectMode;
  //   else
  //     captureWidgetStatusEnum = CaptureWidgetStatusEnum.inspectModeUpdate;
  // }

  // Future<void> deleteWidgetDescription() async {
  //   try {
  //     setBusy(true);

  //     log.i('descriptionToDelete:$_widgetDescription');

  //     await _widgetCaptureService.deleteWidgetDescription(
  //         projectId: projectId, description: _widgetDescription!);

  //     setBusy(false);

  //     await syncWithFirestoreWidgetKeys(
  //         projectId: projectId, enableBusy: false);

  //     closeWidgetDescription();
  //     setBusy(false);
  //   } catch (e) {
  //     setBusy(false);
  //     log.e('Couldn\'t delete the widget. $e');
  //   }
  // }

  // Future<void> updateWidgetDescription(
  //     WidgetDescription updatedWidgetDescription) async {
  //   if (_isEmpty()) return;

  //   _inputErrorMessage = '';

  //   try {
  //     setBusy(true);

  //     log.i('descriptionToUpdate:$_widgetDescription');

  //     await _widgetCaptureService.updateWidgetDescription(
  //         projectId: projectId,
  //         description:
  //             updatedWidgetDescription.copyWith(name: widgetNameValue!));

  //     toggleUpdateMode();
  //     await syncWithFirestoreWidgetKeys(
  //         projectId: projectId, enableBusy: false);
  //     setBusy(false);
  //   } catch (e) {
  //     setBusy(false);
  //     log.e('Couldn\'t update the widget. $e');
  //   }
  // }

  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///

}
