import 'dart:async';

import 'package:stacked/stacked.dart';
import 'package:testsweets/src/app/logger.dart';
import 'package:testsweets/src/enums/capture_widget_enum.dart';
import 'package:testsweets/src/enums/popup_menu_action.dart';
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
      CaptureWidgetStatusEnum.idle;

  set captureWidgetStatusEnum(CaptureWidgetStatusEnum captureWidgetStatusEnum) {
    _captureWidgetStatusEnum = captureWidgetStatusEnum;
    notifyListeners();
  }

  CaptureWidgetStatusEnum get captureWidgetStatusEnum =>
      _captureWidgetStatusEnum;

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

  Future<String?> saveWidget(
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
      captureWidgetStatusEnum = CaptureWidgetStatusEnum.idle;
      _widgetDescription = null;
    }
    setBusy(false);
    return result;
  }

  void toggleInfoForm(bool show) {
    if (show) {
      captureWidgetStatusEnum = CaptureWidgetStatusEnum.widgetInfoForm;
    } else {
      _widgetDescription = null;
      captureWidgetStatusEnum = CaptureWidgetStatusEnum.idle;
    }
  }

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

  void executeAction(
      {required WidgetDescription description,
      required PopupMenuAction popupMenuAction}) {
    _widgetDescription = description;
  }
}
