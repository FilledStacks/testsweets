import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
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
import 'package:testsweets/src/services/notification_extractor.dart';
import 'package:testsweets/src/services/scroll_appliance.dart';
import 'package:testsweets/src/services/testsweets_route_tracker.dart';
import 'package:testsweets/src/services/widget_capture_service.dart';
import 'package:testsweets/src/ui/shared/find_scrollables.dart';
import 'package:testsweets/src/ui/widget_capture/widgets/interaction_capture_form.dart';

class WidgetCaptureViewModel extends FormViewModel {
  final log = getLogger('WidgetCaptureViewModel');

  final _testSweetsRouteTracker = locator<TestSweetsRouteTracker>();
  final _widgetCaptureService = locator<WidgetCaptureService>();
  final _snackbarService = locator<SnackbarService>();
  final _scrollAppliance = locator<ScrollAppliance>();
  final _notifictionExtractor = locator<NotificationExtractor>();

  final _notificationController = StreamController<Notification>.broadcast();
  var _captureWidgetStatusEnum = CaptureWidgetStatusEnum.idle;

  static String sideBusyIndicator = 'sideBusyIndicator';
  static String fullScreenBusyIndicator = 'fullScreenBusyIndicator';

  WidgetCaptureViewModel({required String projectId}) {
    _notificationController.stream
        .where(_notifictionExtractor.onlyScrollUpdateNotification)
        .map(_notifictionExtractor.notificationToScrollableDescription)
        .listen((notification) => viewInteractions = _notifictionExtractor
            .scrollInteractions(notification, viewInteractions));

    _testSweetsRouteTracker.addListener(() {
      _widgetCaptureService.syncRouteInteractions(
          _testSweetsRouteTracker.previosRoute, viewInteractions);
      loadCurrentRouteInteractions();
    });

    _widgetCaptureService.projectId = projectId;
  }

  Interaction? inProgressInteraction;

  ValueNotifier<List<Interaction>> interactionsForViewNotifier =
      ValueNotifier([]);
  List<Interaction> get viewInteractions => interactionsForViewNotifier.value;
  set viewInteractions(List<Interaction> interactions) {
    interactionsForViewNotifier.value = interactions;
  }

  bool get currentViewCaptured =>
      viewInteractions.any((element) => element.widgetType == WidgetType.view);

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
    setBusyForObject(fullScreenBusyIndicator, true);

    try {
      await _widgetCaptureService.loadWidgetDescriptionsForProject();
      loadCurrentRouteInteractions();
    } catch (error) {
      log.e('Could not get widgetDescriptions: $error');
      _snackbarService.showCustomSnackBar(
          message: 'Could not get widgetDescriptions: $error',
          variant: SnackbarType.failed);
    }
    setBusyForObject(fullScreenBusyIndicator, false);
  }

  void loadCurrentRouteInteractions() {
    viewInteractions = _widgetCaptureService.getDescriptionsForView(
        currentRoute: _testSweetsRouteTracker.currentRoute);
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

  Future<void> captureNewInteraction() async {
    log.i(inProgressInteraction);

    setBusyForObject(sideBusyIndicator, true);

    try {
      if (!currentViewCaptured) {
        final capturedView = await _widgetCaptureService
            .captureView(_testSweetsRouteTracker.currentRoute);
        viewInteractions.add(capturedView);
      }
      final interaction = await _widgetCaptureService
          .saveInteractionInDatabase(fullInteraction);

      _addSavedInteractionToViewWhenSuccess(interaction);
    } catch (e) {
      _snackbarService.showCustomSnackBar(
          message: e.toString(), variant: SnackbarType.failed);
    }

    setBusyForObject(sideBusyIndicator, false);
  }

  Interaction get fullInteraction => inProgressInteraction!.copyWith(
        name: widgetNameValue!.convertWidgetNameToValidFormat,
        viewName: _testSweetsRouteTracker.formatedCurrentRoute,
        originalViewName: _testSweetsRouteTracker.currentRoute,
      );

  void _addSavedInteractionToViewWhenSuccess(Interaction createdInteraction) {
    final syncedInteraction =
        _notifictionExtractor.syncInteractionWithScrollable(createdInteraction);

    viewInteractions.add(syncedInteraction);
    inProgressInteraction = null;
    captureWidgetStatusEnum = CaptureWidgetStatusEnum.idle;
  }

  Future<void> updateInteraction() async {
    log.i(inProgressInteraction);

    setBusyForObject(sideBusyIndicator, true);

    try {
      final updatedInteraction = viewInteractions.firstWhere(
          (oldInteraciton) => oldInteraciton.id == inProgressInteraction!.id);

      await _widgetCaptureService.updateInteractionInDatabase(
          oldInteraction: updatedInteraction,
          updatedInteraction: inProgressInteraction!);

      _updateInteractionInViewWhenSuccess(inProgressInteraction!);
    } catch (error) {
      _snackbarService.showCustomSnackBar(
          message: error.toString(), variant: SnackbarType.failed);
    }

    setBusyForObject(sideBusyIndicator, false);
  }

  void _updateInteractionInViewWhenSuccess(Interaction updatedInteraction) {
    final syncedInteraction =
        _notifictionExtractor.syncInteractionWithScrollable(updatedInteraction);

    final indexToUpdate = viewInteractions
        .indexWhere((element) => syncedInteraction.id == element.id);

    viewInteractions[indexToUpdate] = syncedInteraction;
    inProgressInteraction = null;
    captureWidgetStatusEnum = CaptureWidgetStatusEnum.idle;
  }

  Future<void> removeWidgetDescription() async {
    log.i(inProgressInteraction);

    setBusyForObject(sideBusyIndicator, true);

    try {
      await _widgetCaptureService
          .removeInteractionFromDatabase(inProgressInteraction!);

      _removeInteractionFromViewWhenSuccess();
    } catch (error) {
      _snackbarService.showCustomSnackBar(
          message: error.toString(), variant: SnackbarType.failed);
    }

    setBusyForObject(sideBusyIndicator, false);
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
      await updateInteraction();
    } else {
      await captureNewInteraction();
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

      await updateInteraction();
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

  void interactionOnTap(Interaction widgetDescription) async {
    notifyListeners();
    await _snackbarService.showCustomSnackBar(
        message: widgetDescription.name, variant: SnackbarType.info);
  }

  bool onClientNotifiaction(Notification notification) {
    _notificationController.add(notification);

    /// We return false to keep the notification bubbling in the widget tree
    return false;
  }

  void checkForExternalities(
    Iterable<ScrollableDescription> scrollableDescription,
  ) {
    log.i('before:' + inProgressInteraction.toString());

    inProgressInteraction = _scrollAppliance.applyScrollableOnInteraction(
      scrollableDescription,
      inProgressInteraction!,
    );

    log.i('after:' + inProgressInteraction.toString());
  }

  @override
  void dispose() {
    _notificationController.close();
    super.dispose();
  }
}
