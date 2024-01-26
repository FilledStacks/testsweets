import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:testsweets/src/app/logger.dart';
import 'package:testsweets/src/enums/capture_widget_enum.dart';
import 'package:testsweets/src/enums/popup_menu_action.dart';
import 'package:testsweets/src/enums/toast_type.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/extensions/string_extension.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/services/notification_extractor.dart';
import 'package:testsweets/src/services/scroll_appliance.dart';
import 'package:testsweets/src/services/snackbar_service.dart';
import 'package:testsweets/src/services/testsweets_route_tracker.dart';
import 'package:testsweets/src/services/widget_capture_service.dart';
import 'package:testsweets/src/ui/shared/find_scrollables.dart';
import 'package:testsweets/src/ui/widget_capture/widgets/interaction_capture_form.dart';
import 'package:testsweets/testsweets.dart';

class WidgetCaptureViewModel extends FormViewModel {
  final log = getLogger('WidgetCaptureViewModel');

  final _testSweetsRouteTracker = locator<TestSweetsRouteTracker>();
  final _widgetCaptureService = locator<WidgetCaptureService>();
  final _snackbarService = locator<SnackbarService>();
  final _scrollAppliance = locator<ScrollAppliance>();
  final _notifictionExtractor = locator<NotificationExtractor>();

  final _notificationController = StreamController<Notification>.broadcast();
  var _captureWidgetStatusEnum = CaptureWidgetState.idle;

  static String sideBusyIndicator = 'sideBusyIndicator';
  static String fullScreenBusyIndicator = 'fullScreenBusyIndicator';

  final Size currentScreenSize;
  final Orientation orientation;

  WidgetCaptureViewModel({
    required String projectId,
    this.currentScreenSize = Size.zero,
    this.orientation = Orientation.portrait,
  }) {
    _notificationController.stream
        .where(_notifictionExtractor.onlyScrollUpdateNotification)
        .map(_notifictionExtractor.notificationToScrollableDescription)
        .listen((notification) => viewInteractions = _notifictionExtractor
            .scrollInteractions(notification, viewInteractions));

    _testSweetsRouteTracker.addListener(() {
      _widgetCaptureService.syncRouteInteractions(
        _testSweetsRouteTracker.previosRoute,
        viewInteractions,
      );

      showInteractionPonts = true;

      loadCurrentRouteInteractions();
    });

    _widgetCaptureService.projectId = projectId;
  }

  Interaction? inProgressInteraction;
  bool showInteractionPonts = true;

  ValueNotifier<List<Interaction>> interactionsForViewNotifier =
      ValueNotifier([]);

  List<Interaction> get viewInteractions => interactionsForViewNotifier.value;

  set viewInteractions(List<Interaction> interactions) {
    print('');
    print('================= Current View Interactions ===================');
    print(interactions.join('\n'));
    print('===============================================================');
    print('');
    interactionsForViewNotifier.value = interactions;
  }

  bool get currentViewCaptured =>
      viewInteractions.any((element) => element.widgetType == WidgetType.view);

  /// When open the form create new instance of widgetDescription
  /// if it's null and set [CaptureWidgetState.createWidget]
  void showWidgetForm() {
    captureState = CaptureWidgetState.createWidget;
  }

  void setSnackbarContext(BuildContext context) {
    _snackbarService.setBuildContext(context);
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
        variant: SnackbarType.failed,
      );
    }
    setBusyForObject(fullScreenBusyIndicator, false);
  }

  void loadCurrentRouteInteractions() {
    viewInteractions = _widgetCaptureService.getDescriptionsForView(
      currentRoute: _testSweetsRouteTracker.currentRoute,
    );
  }

  set captureState(CaptureWidgetState captureWidgetStatusEnum) {
    log.i(captureWidgetStatusEnum);
    _captureWidgetStatusEnum = captureWidgetStatusEnum;
    notifyListeners();
  }

  set setWidgetType(WidgetType widgetType) {
    log.v('widgetType: $widgetType - currentScreenSize: $currentScreenSize');
    if (inProgressInteraction == null) {
      inProgressInteraction = Interaction(
        position: WidgetPosition(
          x: currentScreenSize.width / 2,
          y: currentScreenSize.height / 2,
          capturedDeviceHeight: currentScreenSize.height,
          capturedDeviceWidth: currentScreenSize.width,
        ),
        viewName: '',
        originalViewName: '',
        widgetType: widgetType,
      );
    } else {
      inProgressInteraction = inProgressInteraction?.copyWith(
        widgetType: widgetType,
      );
    }
    notifyListeners();
  }

  set setVisibilty(bool visible) {
    log.v(visible);

    showInteractionPonts = visible;
    notifyListeners();
  }

  CaptureWidgetState get captureState => _captureWidgetStatusEnum;

  void clearWidgetDescriptionForm() {
    log.v('');
    inProgressInteraction = null;
    captureState = CaptureWidgetState.idle;
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
        final capturedView = await _widgetCaptureService.captureView(
          _testSweetsRouteTracker.currentRoute,
        );

        viewInteractions.add(capturedView);
      }
      final interaction = await _widgetCaptureService
          .saveInteractionInDatabase(fullInteraction);

      _addSavedInteractionToViewWhenSuccess(interaction);
    } catch (e) {
      print(e.toString());
      _snackbarService.showCustomSnackBar(
        message: e.toString(),
        variant: SnackbarType.failed,
      );
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
    captureState = CaptureWidgetState.idle;
  }

  Future<void> updateInteraction() async {
    log.i(inProgressInteraction);

    setBusyForObject(sideBusyIndicator, true);

    try {
      var updatedInteraction = viewInteractions.firstWhere(
        (oldInteraciton) => oldInteraciton.id == inProgressInteraction!.id,
      );

      // Refactor: I kept this outside so it's clear, but this can move into
      // the widget itself.
      // VIDEO IDEA: Make a video asking for opinions, this will attract some
      // dart engineers that might work for an ICP
      final bool hasDeviceDetailsForCurrentScreenSize =
          updatedInteraction.hasDeviceDetailsForScreenSize(
        size: currentScreenSize,
        orientation: orientation,
      );

      if (!hasDeviceDetailsForCurrentScreenSize) {
        updatedInteraction = updatedInteraction.storeDeviceDetails(
          size: currentScreenSize,
          orientation: orientation,
        );
      }

      await _widgetCaptureService.updateInteractionInDatabase(
        oldInteraction: updatedInteraction,
        updatedInteraction: inProgressInteraction!,
      );

      _updateInteractionInViewWhenSuccess(inProgressInteraction!);
    } catch (error) {
      _snackbarService.showCustomSnackBar(
        message: error.toString(),
        variant: SnackbarType.failed,
      );
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
    captureState = CaptureWidgetState.idle;
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
        message: error.toString(),
        variant: SnackbarType.failed,
      );
    }

    setBusyForObject(sideBusyIndicator, false);
  }

  void _removeInteractionFromViewWhenSuccess() {
    viewInteractions = viewInteractions
        .whereNot((widget) => inProgressInteraction == widget)
        .toList();

    inProgressInteraction = null;
    captureState = CaptureWidgetState.idle;
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
        captureState = CaptureWidgetState.editWidget;
        break;
      case PopupMenuAction.remove:
        await removeWidgetDescription();
        break;
    }
  }

  Future<void> onLongPressUp() async {
    if (captureState == CaptureWidgetState.quickPositionEdit) {
      final findScrollablesService = locator<FindScrollables>()
        ..searchForScrollableElements();

      final extractedScrollables =
          findScrollablesService.convertElementsToScrollDescriptions();

      checkForExternalities(extractedScrollables);

      await updateInteraction();
      captureState = CaptureWidgetState.idle;
    }

    inProgressInteraction = null;
  }

  void startQuickPositionEdit(
    Interaction description,
  ) {
    log.v(description);
    inProgressInteraction = description;
    captureState = CaptureWidgetState.quickPositionEdit;
  }

  void interactionOnTap(Interaction widgetDescription) {
    notifyListeners();
    _snackbarService.showCustomSnackBar(
      message: widgetDescription.name,
      variant: SnackbarType.info,
    );
  }

  bool onClientNotifiaction(Notification notification) {
    _notificationController.add(notification);

    /// We return false to keep the notification bubbling in the widget tree
    return false;
  }

  void checkForExternalities(
    Iterable<ScrollableDescription> scrollableDescription,
  ) {
    log.i('<<<=== before:' + inProgressInteraction.toString());

    inProgressInteraction = _scrollAppliance.applyScrollableOnInteraction(
      scrollableDescription,
      inProgressInteraction!,
    );

    log.i('<<<===after:' + inProgressInteraction.toString());
  }

  @override
  void dispose() {
    _notificationController.close();
    super.dispose();
  }
}
