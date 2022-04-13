import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:testsweets/src/enums/capture_widget_enum.dart';
import 'package:testsweets/src/enums/popup_menu_action.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:testsweets/src/services/reactive_scrollable.dart';
import 'package:testsweets/src/services/testsweets_route_tracker.dart';
import 'package:testsweets/src/ui/widget_capture/widgets/interaction_capture_form.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_viewmodel.dart';

import '../helpers/test_consts.dart';
import '../helpers/test_helpers.dart';

final _projectId = 'projectId';
WidgetCaptureViewModel _getViewModel() {
  var model = WidgetCaptureViewModel(projectId: _projectId);
  model.screenCenterPosition = WidgetPosition.empty();
  return model;
}

void main() {
  group('WidgetCaptureViewModelTest -', () {
    setUp(registerServices);
    tearDown(unregisterServices);
    group('constructor -', () {
      test('When called, should set the project id in WidgetCaptureService',
          () async {
        final service = getAndRegisterWidgetCaptureService();

        _getViewModel();
        verify(service.projectId = _projectId);
      });
    });
    group('saveWidget -', () {
      test('''When called on route `current route`,
           Should added it to widgetDescription and send it to backend''',
          () async {
        getAndRegisterTestSweetsRouteTracker(currentRoute: 'current route');
        final model = _getViewModel();
        model.formValueMap[WidgetNameValueKey] = 'myWidgetName';
        model.showWidgetForm();
        model.inProgressInteraction!
            .copyWith(widgetType: WidgetType.scrollable);
        model.captureNewInteraction();
        expect(model.interactionInfo.originalViewName, 'current route');
      });
      test('''When called and the current route is `/current route`,
           Should convert it to `currentRoute` in viewName proberty before send it to backend''',
          () async {
        getAndRegisterTestSweetsRouteTracker(currentRoute: '/current route');
        final model = _getViewModel();
        model.formValueMap[WidgetNameValueKey] = 'myWidgetName';
        model.showWidgetForm();
        model.inProgressInteraction!
            .copyWith(widgetType: WidgetType.scrollable);
        model.captureNewInteraction();
        expect(model.interactionInfo.viewName, 'currentRoute');
        expect(model.interactionInfo.originalViewName, '/current route');
      });
      test('''When called and the current widget name is `login-button`,
           Should convert it to `loginButton` in name proberty before send it to backend''',
          () async {
        getAndRegisterTestSweetsRouteTracker(currentRoute: '/current route');
        final model = _getViewModel();
        model.showWidgetForm();

        model.formValueMap[WidgetNameValueKey] = 'login-button';

        model.inProgressInteraction = model.inProgressInteraction!
            .copyWith(widgetType: WidgetType.touchable);
        model.captureNewInteraction();
        expect(model.interactionInfo.name, 'loginButton');
      });
    });

    group('updateWidgetDescription -', () {
      test('''When change the name, should call updateWidgetDescription()
              in WidgetCaptureService with the new name"''', () async {
        final service = getAndRegisterWidgetCaptureService();

        final model = _getViewModel();
        model.viewInteractions = [kGeneralInteraction];

        await model.popupMenuActionSelected(
            kGeneralInteraction, PopupMenuAction.edit);
        model.formValueMap[WidgetNameValueKey] = 'loginButton';
        model.setFormStatus();

        await model.updateInteraction();

        verify(service.updateInteractionInDatabase(
            kGeneralInteraction.copyWith(name: 'loginButton')));
      });

      test('''When called and update was successful,
          Should set the current CaptureWidgetStatusEnum to idle''', () async {
        final model = _getViewModel();
        model.viewInteractions = [kGeneralInteraction];
        model.inProgressInteraction = kGeneralInteraction;

        await model.updateInteraction();

        expect(model.captureWidgetStatusEnum, CaptureWidgetStatusEnum.idle);
      });
      test('''When in quickPositionEdit mode and user trigger onLongPressUp
       without changing the interaction position,
       Should call updateWidgetDescription from WidgetCaptureService 
       with the same interaction without changing its position''', () async {
        final service = getAndRegisterWidgetCaptureService();

        final model = _getViewModel();
        model.startQuickPositionEdit(kGeneralInteraction);
        model.viewInteractions = [kGeneralInteraction];

        await model.onLongPressUp();

        verify(service.updateInteractionInDatabase(kGeneralInteraction));
      });

      test('''When in quickPositionEdit mode and user trigger onLongPressUp
       while changeing the widget position to new place,
       Should call updateWidgetDescription from WidgetCaptureService 
       with the interaction new position''', () async {
        final service = getAndRegisterWidgetCaptureService();

        final model = _getViewModel();
        model.startQuickPositionEdit(kGeneralInteraction);
        model.viewInteractions = [kGeneralInteraction];
        model.updateDescriptionPosition(
            33,
            33,
            kGeneralInteraction.position.capturedDeviceWidth!,
            kGeneralInteraction.position.capturedDeviceHeight!);

        await model.onLongPressUp();

        final updatedInteraction = kGeneralInteraction.copyWith(
          position: kGeneralInteraction.position.copyWith(
            x: 33,
            y: 33,
          ),
        );

        verify(service.updateInteractionInDatabase(updatedInteraction));
      });
      test('''
            When update interaction position,
            Should update the interaction in viewInteractions list
  ''', () async {
        final model = _getViewModel();
        model.startQuickPositionEdit(kGeneralInteraction);
        model.viewInteractions = [kGeneralInteraction];
        model.updateDescriptionPosition(
            22,
            33,
            kGeneralInteraction.position.capturedDeviceWidth!,
            kGeneralInteraction.position.capturedDeviceHeight!);

        await model.onLongPressUp();

        final updatedInteractionPosition = model.viewInteractions
            .firstWhere((element) => element.id == kGeneralInteraction.id)
            .position;

        expect(updatedInteractionPosition.x, 22);
        expect(updatedInteractionPosition.y, 33);
      });
    });

    group('removeWidgetDescription -', () {
      test(
          'When called, Should call deleteWidgetDescription from WidgetCaptureService',
          () async {
        final widgetCaptureService = getAndRegisterWidgetCaptureService();
        final model = _getViewModel();
        model.popupMenuActionSelected(
            kGeneralInteraction, PopupMenuAction.remove);

        await model.removeWidgetDescription();
        verify(widgetCaptureService
            .removeInteractionFromDatabase(kGeneralInteraction));
      });

      test(
          'When the call ended sucessfully, Should reset the captureWidgetStatusEnum to idle state',
          () async {
        final model = _getViewModel();
        model.showWidgetForm();
        await model.removeWidgetDescription();
        expect(model.captureWidgetStatusEnum, CaptureWidgetStatusEnum.idle);
      });
    });

    group('popupMenuActionSelected -', () {
      test(
          'When popupMenuAction is edit, Should set the captureWidgetStatusEnum to editWidget',
          () {
        final model = _getViewModel();
        model.popupMenuActionSelected(
            kGeneralInteraction, PopupMenuAction.edit);
        expect(
            model.captureWidgetStatusEnum, CaptureWidgetStatusEnum.editWidget);
      });
      test(
          'When popupMenuAction is remove, Should call deleteWidgetDescription from captureService',
          () {
        final widgetCaptureService = getAndRegisterWidgetCaptureService();

        final model = _getViewModel();

        model.popupMenuActionSelected(
            kGeneralInteraction, PopupMenuAction.remove);
        verify(widgetCaptureService
            .removeInteractionFromDatabase(kGeneralInteraction));
      });
    });
  });
}
