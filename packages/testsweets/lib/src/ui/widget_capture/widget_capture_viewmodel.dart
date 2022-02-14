import 'dart:async';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:testsweets/src/app/logger.dart';
import 'package:testsweets/src/enums/capture_widget_enum.dart';
import 'package:testsweets/src/enums/popup_menu_action.dart';
import 'package:testsweets/src/enums/toast_type.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/extensions/string_extension.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:testsweets/src/services/testsweets_route_tracker.dart';
import 'package:testsweets/src/services/widget_capture_service.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_view.form.dart';

class WidgetCaptureViewModel extends FormViewModel {
  final log = getLogger('WidgetCaptureViewModel');

  final _testSweetsRouteTracker = locator<TestSweetsRouteTracker>();
  final _widgetCaptureService = locator<WidgetCaptureService>();
  final _snackbarService = locator<SnackbarService>();

  CaptureWidgetStatusEnum _captureWidgetStatusEnum =
      CaptureWidgetStatusEnum.idle;

  /// We use this position as the starter point of any new widget
  late WidgetPosition screenCenterPosition;

  Future<String?> addNewTarget(String targetId) async {
    log.v(
        'already added ids: ${widgetDescription?.targetIds} , new id: $targetId');

    final List<String> targetsList = [
      ...widgetDescription!.targetIds,
      targetId,
    ];
    widgetDescription = widgetDescription!.copyWith(targetIds: targetsList);

    final response = await updateWidgetDescription();

    if (response is String) {
      log.e(response);
      widgetDescription = null;
    }

    captureWidgetStatusEnum = CaptureWidgetStatusEnum.idle;
  }

  Future<String?> removeTarget(String targetId) async {
    log.v(
        'Existing ids: ${widgetDescription?.targetIds} , Will remove id: $targetId');

    bool targetExists = widgetDescription!.targetIds.contains(targetId);
    if (!targetExists) {
      log.e('Target doesn\'t exist');
      return 'Target doesn\'t exist';
    }

    // Remove the selected target from [widgetDescription]
    final targetsWithoutTheRemovedOne = widgetDescription!.targetIds
        .where((element) => element != targetId)
        .toList();

    widgetDescription =
        widgetDescription!.copyWith(targetIds: targetsWithoutTheRemovedOne);

    final response = await updateWidgetDescription();

    if (response is String) {
      log.e(response);
      widgetDescription = null;
    }

    captureWidgetStatusEnum = CaptureWidgetStatusEnum.idle;
  }

  set setWidgetType(WidgetType widgetType) {
    log.v(widgetType);
    widgetDescription = widgetDescription!.copyWith(widgetType: widgetType);
    notifyListeners();
  }

  set setVisibilty(bool visible) {
    log.v(visible);
    widgetDescription = widgetDescription!.copyWith(visibility: visible);
    notifyListeners();
  }

  set captureWidgetStatusEnum(CaptureWidgetStatusEnum captureWidgetStatusEnum) {
    log.i(captureWidgetStatusEnum);
    _captureWidgetStatusEnum = captureWidgetStatusEnum;
    notifyListeners();
  }

  CaptureWidgetStatusEnum get captureWidgetStatusEnum =>
      _captureWidgetStatusEnum;

  WidgetCaptureViewModel({required String projectId}) {
    _widgetCaptureService.projectId = projectId;
    _testSweetsRouteTracker.addListener(notifyListeners);
  }

  WidgetDescription? widgetDescription;

  List<WidgetDescription> get descriptionsForView =>
      _widgetCaptureService.getDescriptionsForView(
        currentRoute: _testSweetsRouteTracker.currentRoute,
      );
  bool get currentViewIsCaptured => descriptionsForView.any(
        (element) => element.widgetType == WidgetType.view,
      );
  String get currentViewName => _testSweetsRouteTracker.formatedCurrentRoute;
  Future<void> loadWidgetDescriptions() async {
    log.v('');
    setBusy(true);
    try {
      await _widgetCaptureService.loadWidgetDescriptionsForProject();
      setBusy(false);
    } catch (e) {
      log.e('Could not get widgetDescriptions: $e');
      _snackbarService.showCustomSnackBar(
          message: 'Could not get widgetDescriptions: $e',
          variant: ToastType.failed);
    }
  }

  void clearWidgetDescriptionForm() {
    log.v('');
    widgetDescription = null;
    captureWidgetStatusEnum = CaptureWidgetStatusEnum.idle;
  }

  /// When open the form create new instance of widgetDescription
  /// if it's null and set [CaptureWidgetStatusEnum.createWidget]
  void showWidgetForm() {
    widgetDescription = widgetDescription ??
        WidgetDescription(
            position: screenCenterPosition,
            viewName: '',
            originalViewName: '',
            widgetType: WidgetType.touchable);
    captureWidgetStatusEnum = CaptureWidgetStatusEnum.createWidget;
  }

  void updateDescriptionPosition(
    double x,
    double y,
    double capturedDeviceWidth,
    double capturedDeviceHeight,
  ) {
    widgetDescription = widgetDescription!.copyWith(
      position: WidgetPosition(
        capturedDeviceHeight: capturedDeviceHeight,
        capturedDeviceWidth: capturedDeviceWidth,
        x: x,
        y: y,
      ),
    );
    notifyListeners();
  }

  Future<String?> saveWidget() async {
    log.i(widgetDescription);

    setBusy(true);
    widgetDescription = widgetDescription?.copyWith(
      name: widgetNameValue!.convertWidgetNameToValidFormat,
      viewName:
          _testSweetsRouteTracker.currentRoute.convertViewNameToValidFormat,
      originalViewName: _testSweetsRouteTracker.currentRoute,
    );

    log.i('descriptionToSave:$widgetDescription');

    final result = await _widgetCaptureService.captureWidgetDescription(
        description: widgetDescription!);

    if (result is String) {
      _snackbarService.showCustomSnackBar(
          message: result, variant: ToastType.failed);
    } else {
      widgetDescription = null;
      captureWidgetStatusEnum = CaptureWidgetStatusEnum.idle;
    }
    setBusy(false);
    return result;
  }

  Future<String?> updateWidgetDescription() async {
    log.i(widgetDescription);

    setBusy(true);

    final result = await _widgetCaptureService.updateWidgetDescription(
        description: widgetDescription!);

    if (result is String) {
      _snackbarService.showCustomSnackBar(
          message: result, variant: ToastType.failed);
    } else {
      widgetDescription = null;
      captureWidgetStatusEnum = CaptureWidgetStatusEnum.idle;
    }

    setBusy(false);
    return result;
  }

  Future<String?> removeWidgetDescription() async {
    log.i(widgetDescription);

    setBusy(true);

    final result = await _widgetCaptureService.deleteWidgetDescription(
        description: widgetDescription!);
    if (result is String) {
      _snackbarService.showCustomSnackBar(
          message: result, variant: ToastType.failed);
    } else {
      widgetDescription = null;
      captureWidgetStatusEnum = CaptureWidgetStatusEnum.idle;
    }

    setBusy(false);
    return result;
  }

  @override
  void setFormStatus() {
    log.v('widgetNameValue: $widgetNameValue');

    widgetDescription =
        widgetDescription?.copyWith(name: widgetNameValue ?? '');
    notifyListeners();
  }

  Future<String?> submitForm() async {
    if (widgetDescription?.id != null) {
      return await updateWidgetDescription();
    } else {
      return await saveWidget();
    }
  }

  Future<void> popupMenuActionSelected(
      WidgetDescription description, PopupMenuAction popupMenuAction) async {
    log.v(popupMenuAction, description);
    widgetDescription = description;

    switch (popupMenuAction) {
      case PopupMenuAction.edit:
        captureWidgetStatusEnum = CaptureWidgetStatusEnum.editWidget;
        break;
      case PopupMenuAction.remove:
        await removeWidgetDescription();
        break;
      case PopupMenuAction.attachToKey:
        captureWidgetStatusEnum = CaptureWidgetStatusEnum.attachWidget;
        _snackbarService.showCustomSnackBar(
            message: 'Select Key to associate with Scroll View',
            variant: ToastType.info);
        break;
      case PopupMenuAction.attachToKey:
        captureWidgetStatusEnum = CaptureWidgetStatusEnum.attachWidget;
        _snackbarService.showCustomSnackBar(
            message: 'Select Key to associate with Scroll View',
            variant: ToastType.info);
        break;
      case PopupMenuAction.deattachFromKey:
        captureWidgetStatusEnum = CaptureWidgetStatusEnum.deattachWidget;
        _snackbarService.showCustomSnackBar(
            message: 'Select the key you want to remove the connection with',
            variant: ToastType.info);

        break;
    }
  }

  Future<void> onLongPressUp() async {
    log.v(captureWidgetStatusEnum);

    if (captureWidgetStatusEnum == CaptureWidgetStatusEnum.quickPositionEdit) {
      await updateWidgetDescription();
      captureWidgetStatusEnum = CaptureWidgetStatusEnum.idle;
    }
    widgetDescription = null;
  }

  void startQuickPositionEdit(
    WidgetDescription description,
  ) {
    log.v(description);
    widgetDescription = description;
    captureWidgetStatusEnum = CaptureWidgetStatusEnum.quickPositionEdit;
  }
}
