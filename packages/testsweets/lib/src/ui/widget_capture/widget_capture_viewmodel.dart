import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:testsweets/src/app/logger.dart';
import 'package:testsweets/src/enums/capture_widget_enum.dart';
import 'package:testsweets/src/enums/popup_menu_action.dart';
import 'package:testsweets/src/enums/toast_type.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/extensions/string_extension.dart';
import 'package:testsweets/src/extensions/widget_position_extension.dart';
import 'package:testsweets/src/extensions/widgets_description_list_extensions.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:testsweets/src/services/testsweets_route_tracker.dart';
import 'package:testsweets/src/services/widget_capture_service.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_view_form.dart';

import '../../services/reactive_scrollable.dart';

class WidgetCaptureViewModel extends FormViewModel {
  final log = getLogger('WidgetCaptureViewModel');

  final _testSweetsRouteTracker = locator<TestSweetsRouteTracker>();
  final _widgetCaptureService = locator<WidgetCaptureService>();
  final _snackbarService = locator<SnackbarService>();
  final _reactiveScrollable = locator<ReactiveScrollable>();

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
          message: result, variant: SnackbarType.failed);
    } else {
      widgetDescription = null;
      captureWidgetStatusEnum = CaptureWidgetStatusEnum.idle;
      refreshInteractions();
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
          message: result, variant: SnackbarType.failed);
    } else {
      widgetDescription = null;
      captureWidgetStatusEnum = CaptureWidgetStatusEnum.idle;
      refreshInteractions();
    }

    setBusy(false);
    return result;
  }

  Future<String?> removeWidgetDescription() async {
    log.i(widgetDescription);

    setBusy(true);

    final result = await _widgetCaptureService.removeWidgetDescription(
        description: widgetDescription!);
    if (result is String) {
      _snackbarService.showCustomSnackBar(
          message: result, variant: SnackbarType.failed);
    } else {
      descriptionsForView = descriptionsForView
          .whereNot((widget) => widgetDescription == widget)
          .toList();
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

  void onTapWidget(WidgetDescription widgetDescription) async {
    notifyListeners();
    await _snackbarService.showCustomSnackBar(
        message: widgetDescription.name, variant: SnackbarType.info);
  }

  bool onClientNotifiaction(Notification notification) {
    _notificationController.add(notification);
    return false;
  }

  void checkForExternalities(
      Iterable<ScrollableDescription> scrollableDescription) {
    log.i('before:' + widgetDescription.toString());
    widgetDescription = _reactiveScrollable.applyScrollableOnInteraction(
        scrollableDescription, widgetDescription!);
    log.i('after:' + widgetDescription.toString());
  }

  void listenToNotifications() {
    ScrollDirection? scrollDirection;
    Offset? globalPosition;
    Offset? localPosition;
    _notificationController.stream.listen((notification) {
      if (notification is UserScrollNotification) {
        scrollDirection = notification.direction;
      } else if (notification is ScrollStartNotification) {
        globalPosition = notification.dragDetails!.globalPosition;
        localPosition = notification.dragDetails!.localPosition;
      } else if (notification is ScrollUpdateNotification &&
          globalPosition != null &&
          scrollDirection != ScrollDirection.idle) {
        final scrollableDescription = ScrollableDescription.fromNotification(
            globalPosition: globalPosition!,
            localPosition: localPosition!,
            metrics: notification.metrics,
            scrollDirection: scrollDirection!);

        reactToScroll(scrollableDescription);
      }
    });
  }

  void reactToScroll(ScrollableDescription scrollableDescription) {
    final affectedInteractions =
        _reactiveScrollable.filterAffectedInteractionsByScrollable(
            scrollableDescription, descriptionsForView);
    final scrolledInteractions =
        _reactiveScrollable.moveInteractionsWithScrollable(
            scrollableDescription, affectedInteractions);

    descriptionsForView =
        descriptionsForView.replaceInteractions(scrolledInteractions);
  }

  @override
  void dispose() {
    _notificationController.close();
    super.dispose();
  }

  final _notificationController = StreamController<Notification>.broadcast();

  var _captureWidgetStatusEnum = CaptureWidgetStatusEnum.idle;

  WidgetCaptureViewModel({required String projectId}) {
    listenToNotifications();
    _widgetCaptureService.projectId = projectId;
  }

  WidgetDescription? widgetDescription;

  ValueNotifier<List<WidgetDescription>> descriptionsForViewNotifier =
      ValueNotifier([]);
  List<WidgetDescription> get descriptionsForView =>
      descriptionsForViewNotifier.value;
  set descriptionsForView(List<WidgetDescription> widgetDescriptions) {
    descriptionsForViewNotifier.value = widgetDescriptions;
  }

  bool get currentViewIsCaptured => descriptionsForView.any(
        (element) => element.widgetType == WidgetType.view,
      );
  String get currentViewName => _testSweetsRouteTracker.formatedCurrentRoute;

  /// We use this position as the starter point of any new widget
  late WidgetPosition screenCenterPosition;

  Future<void> loadWidgetDescriptions() async {
    log.v('');
    try {
      setBusy(true);
      await _widgetCaptureService.loadWidgetDescriptionsForProject().then((_) {
        refreshInteractions();
        _testSweetsRouteTracker.addListener(() {
          refreshInteractions();
        });
      });
      setBusy(false);
    } catch (e) {
      log.e('Could not get widgetDescriptions: $e');
      _snackbarService.showCustomSnackBar(
          message: 'Could not get widgetDescriptions: $e',
          variant: SnackbarType.failed);
    }
  }

  void refreshInteractions() {
    descriptionsForView = _widgetCaptureService.getDescriptionsForView(
        currentRoute: _testSweetsRouteTracker.currentRoute);
  }

  set captureWidgetStatusEnum(CaptureWidgetStatusEnum captureWidgetStatusEnum) {
    log.i(captureWidgetStatusEnum);
    _captureWidgetStatusEnum = captureWidgetStatusEnum;
    notifyListeners();
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

  CaptureWidgetStatusEnum get captureWidgetStatusEnum =>
      _captureWidgetStatusEnum;

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
}
