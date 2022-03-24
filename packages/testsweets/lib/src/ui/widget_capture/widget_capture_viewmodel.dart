import 'dart:async';

import 'package:collection/collection.dart';
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
import 'package:testsweets/src/extensions/widgets_description_list_extensions.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:testsweets/src/services/testsweets_route_tracker.dart';
import 'package:testsweets/src/services/widget_capture_service.dart';
import 'package:testsweets/src/ui/shared/find_scrollables.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_view_form.dart';

import '../../services/reactive_scrollable.dart';

class WidgetCaptureViewModel extends FormViewModel {
  final log = getLogger('WidgetCaptureViewModel');

  final _testSweetsRouteTracker = locator<TestSweetsRouteTracker>();
  final _widgetCaptureService = locator<WidgetCaptureService>();
  final _snackbarService = locator<SnackbarService>();
  final _reactiveScrollable = locator<ReactiveScrollable>();
  final _notificationController = StreamController<Notification>.broadcast();

  var _captureWidgetStatusEnum = CaptureWidgetStatusEnum.idle;

  WidgetCaptureViewModel({required String projectId}) {
    listenToNotifications();
    _widgetCaptureService.projectId = projectId;
  }

  Interaction? inProgressInteraction;

  ValueNotifier<List<Interaction>> descriptionsForViewNotifier =
      ValueNotifier([]);
  List<Interaction> get viewInteractions => descriptionsForViewNotifier.value;
  set viewInteractions(List<Interaction> widgetDescriptions) {
    descriptionsForViewNotifier.value = widgetDescriptions;
  }

  bool get currentViewCaptured => viewInteractions.any(
        (element) => element.widgetType == WidgetType.view,
      );
  String get currentViewName => _testSweetsRouteTracker.formatedCurrentRoute;

  /// We use this position as the starter point of any new widget
  late WidgetPosition screenCenterPosition;

  /// When open the form create new instance of widgetDescription
  /// if it's null and set [CaptureWidgetStatusEnum.createWidget]
  void showWidgetForm() {
    inProgressInteraction = inProgressInteraction ??
        Interaction(
            position: screenCenterPosition,
            viewName: '',
            originalViewName: '',
            widgetType: WidgetType.touchable);
    captureWidgetStatusEnum = CaptureWidgetStatusEnum.createWidget;
  }

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
    viewInteractions = _widgetCaptureService.getDescriptionsForView(
        currentRoute: _testSweetsRouteTracker.currentRoute);
    notifyListeners();
  }

  set captureWidgetStatusEnum(CaptureWidgetStatusEnum captureWidgetStatusEnum) {
    log.i(captureWidgetStatusEnum);
    _captureWidgetStatusEnum = captureWidgetStatusEnum;
    notifyListeners();
  }

  set setWidgetType(WidgetType widgetType) {
    log.v(widgetType);
    inProgressInteraction =
        inProgressInteraction!.copyWith(widgetType: widgetType);
    notifyListeners();
  }

  set setVisibilty(bool visible) {
    log.v(visible);
    inProgressInteraction =
        inProgressInteraction!.copyWith(visibility: visible);
    notifyListeners();
  }

  CaptureWidgetStatusEnum get captureWidgetStatusEnum =>
      _captureWidgetStatusEnum;

  void clearWidgetDescriptionForm() {
    log.v('');
    inProgressInteraction = null;
    captureWidgetStatusEnum = CaptureWidgetStatusEnum.idle;
  }

  void updateDescriptionPosition(
    double x,
    double y,
    double capturedDeviceWidth,
    double capturedDeviceHeight,
  ) {
    log.v('x: $x , y: $y');
    inProgressInteraction = inProgressInteraction!.copyWith(
      position: WidgetPosition(
        capturedDeviceHeight: capturedDeviceHeight,
        capturedDeviceWidth: capturedDeviceWidth,
        x: x,
        y: y,
      ),
    );
    notifyListeners();
  }

  Future<void> saveWidget() async {
    log.i(inProgressInteraction);

    _gatherInteracitonInfo();

    setBusy(true);

    try {
      final ineractionId = await _widgetCaptureService.captureWidgetDescription(
          description: inProgressInteraction!);
      _addSavedInteractionToViewWhenSuccess(ineractionId);
    } catch (e) {
      _snackbarService.showCustomSnackBar(
          message: e.toString(), variant: SnackbarType.failed);
    }

    setBusy(false);
  }

  void _gatherInteracitonInfo() {
    inProgressInteraction = inProgressInteraction?.copyWith(
      name: widgetNameValue!.convertWidgetNameToValidFormat,
      viewName:
          _testSweetsRouteTracker.currentRoute.convertViewNameToValidFormat,
      originalViewName: _testSweetsRouteTracker.currentRoute,
    );
  }

  void _addSavedInteractionToViewWhenSuccess(String id) {
    viewInteractions.add(inProgressInteraction!.copyWith(id: id));
    inProgressInteraction = null;
    captureWidgetStatusEnum = CaptureWidgetStatusEnum.idle;
  }

  Future<String?> updateWidgetDescription() async {
    log.i(inProgressInteraction);

    setBusy(true);

    final result = await _widgetCaptureService.updateWidgetDescription(
        description: inProgressInteraction!);

    if (result is String) {
      _snackbarService.showCustomSnackBar(
          message: result, variant: SnackbarType.failed);
    } else {
      _updateInteractionInViewWhenSuccess();
    }

    setBusy(false);
    return result;
  }

  void _updateInteractionInViewWhenSuccess() {
    final updatedIndex = viewInteractions.indexWhere(
        (interaction) => inProgressInteraction!.id == interaction.id);
    viewInteractions[updatedIndex] = inProgressInteraction!;
    inProgressInteraction = null;
    captureWidgetStatusEnum = CaptureWidgetStatusEnum.idle;
  }

  Future<String?> removeWidgetDescription() async {
    log.i(inProgressInteraction);

    setBusy(true);

    final result = await _widgetCaptureService.removeWidgetDescription(
        description: inProgressInteraction!);
    if (result is String) {
      _snackbarService.showCustomSnackBar(
          message: result, variant: SnackbarType.failed);
    } else {
      _removeInteractionFromViewWhenSuccess();
    }

    setBusy(false);
    return result;
  }

  void _removeInteractionFromViewWhenSuccess() {
    viewInteractions = viewInteractions
        .whereNot((widget) => inProgressInteraction == widget)
        .toList();
    inProgressInteraction = null;
    captureWidgetStatusEnum = CaptureWidgetStatusEnum.idle;
  }

  @override
  void setFormStatus() {
    log.v('widgetNameValue: $widgetNameValue');

    inProgressInteraction =
        inProgressInteraction?.copyWith(name: widgetNameValue ?? '');
    notifyListeners();
  }

  Future<void> submitForm() async {
    if (inProgressInteraction?.id != null) {
      await updateWidgetDescription();
    } else {
      await saveWidget();
    }
  }

  Future<void> popupMenuActionSelected(
      Interaction description, PopupMenuAction popupMenuAction) async {
    log.v(popupMenuAction, description);
    inProgressInteraction = description;

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
      final findScrollablesService = locator<FindScrollables>()
        ..searchForScrollableElements();
      final extractedScrollables =
          findScrollablesService.convertElementsToScrollDescriptions();

      checkForExternalities(extractedScrollables);

      await updateWidgetDescription();
      captureWidgetStatusEnum = CaptureWidgetStatusEnum.idle;
    }
    inProgressInteraction = null;
  }

  void startQuickPositionEdit(
    Interaction description,
  ) {
    log.v(description);
    inProgressInteraction = description;
    captureWidgetStatusEnum = CaptureWidgetStatusEnum.quickPositionEdit;
  }

  void onTapWidget(Interaction widgetDescription) async {
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
    log.i('before:' + inProgressInteraction.toString());

    if (scrollableDescription.isEmpty) return;

    inProgressInteraction = _reactiveScrollable.applyScrollableOnInteraction(
        scrollableDescription, inProgressInteraction!);

    log.i('after:' + inProgressInteraction.toString());
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
            scrollableDescription, viewInteractions);

    final scrolledInteractions =
        _reactiveScrollable.moveInteractionsWithScrollable(
            scrollableDescription, affectedInteractions);

    viewInteractions =
        viewInteractions.replaceInteractions(scrolledInteractions);
  }

  @override
  void dispose() {
    _notificationController.close();
    super.dispose();
  }
}
