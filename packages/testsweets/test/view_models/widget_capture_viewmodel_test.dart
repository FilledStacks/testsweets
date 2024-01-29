import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:testsweets/src/enums/capture_widget_enum.dart';
import 'package:testsweets/src/enums/popup_menu_action.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_viewmodel.dart';
import 'package:testsweets/src/ui/widget_capture/widgets/interaction_capture_form.dart';

import '../helpers/test_consts.dart';
import '../helpers/test_helpers.dart';

final _projectId = 'projectId';
WidgetCaptureViewModel _getViewModel() {
  var model = WidgetCaptureViewModel(projectId: _projectId);
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
    group('captureNewInteraction -', () {
      test('''When called on route `current route`,
           Should added it to widgetDescription and send it to backend''',
          () async {
        getAndRegisterTestSweetsRouteTracker(currentRoute: 'current route');
        final model = _getViewModel();
        model.setWidgetType = WidgetType.input;
        model.formValueMap[WidgetNameValueKey] = 'myWidgetName';
        model.showWidgetForm();
        model.captureNewInteraction();
        expect(model.fullInteraction.originalViewName, 'current route');
      });
      test('''When called and the current route is `/current route`,
           Should convert it to `currentRoute` in viewName proberty before send it to backend''',
          () async {
        getAndRegisterTestSweetsRouteTracker(currentRoute: '/current route');
        final model = _getViewModel();
        model.setWidgetType = WidgetType.input;
        model.formValueMap[WidgetNameValueKey] = 'myWidgetName';
        model.showWidgetForm();
        model.captureNewInteraction();
        expect(model.fullInteraction.viewName, 'currentRoute');
        expect(model.fullInteraction.originalViewName, '/current route');
      });
      test('''When called and the current widget name is `login-button`,
           Should convert it to `loginButton` in name proberty before send it to backend''',
          () async {
        getAndRegisterTestSweetsRouteTracker(currentRoute: '/current route');
        final model = _getViewModel();
        model.showWidgetForm();
        model.setWidgetType = WidgetType.input;
        model.formValueMap[WidgetNameValueKey] = 'login-button';

        model.inProgressInteraction = model.inProgressInteraction!
            .copyWith(widgetType: WidgetType.touchable);
        model.captureNewInteraction();
        expect(model.fullInteraction.name, 'loginButton');
      });
      test('''
When capture a new intercation, Should sync with any scrollable underneath it ''',
          () async {
        getAndRegisterTestSweetsRouteTracker(currentRoute: 'current route');
        getAndRegisterWidgetCaptureService();
        final notificationExtractor = getAndRegisterNotificationExtractor();
        final model = _getViewModel();
        model
          ..setWidgetType = WidgetType.input
          ..formValueMap[WidgetNameValueKey] = 'myWidgetName'
          ..showWidgetForm()
          ..viewInteractions
              .add(kViewInteraction); // to skip capturing the view

        await model.captureNewInteraction();

        verify(notificationExtractor
            .syncInteractionWithScrollable(kGeneralInteraction));
      });
    });

    group('updateWidgetDescription -', () {
      test('''When name changed, should call updateWidgetDescription()
              in WidgetCaptureService with the new name"''', () async {
        final service = getAndRegisterWidgetCaptureService();

        final model = _getViewModel();
        model.viewInteractions = [kGeneralInteraction];

        await model.popupMenuActionSelected(
          kGeneralInteraction,
          PopupMenuAction.edit,
        );

        // model.setFormStatus();

        model.inProgressInteraction = kGeneralInteraction.copyWith(
          name: 'loginButton',
        );

        await model.updateInteraction();

        verify(service.updateInteractionInDatabase(
          oldInteraction: kGeneralInteraction,
          updatedInteraction: kGeneralInteraction.copyWith(name: 'loginButton'),
        ));
      });

      test('''When called and update was successful,
          Should set the current CaptureWidgetStatusEnum to idle''', () async {
        final model = _getViewModel();
        model.viewInteractions = [kGeneralInteraction];
        model.inProgressInteraction = kGeneralInteraction;

        await model.updateInteraction();

        expect(model.captureState, CaptureWidgetState.idle);
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

        verify(service.updateInteractionInDatabase(
            oldInteraction: kGeneralInteraction,
            updatedInteraction: kGeneralInteraction));
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
            kGeneralInteraction.position.capturedDeviceWidth,
            kGeneralInteraction.position.capturedDeviceHeight);

        await model.onLongPressUp();

        final updatedInteraction = kGeneralInteraction.copyWith(
          position: kGeneralInteraction.position.copyWith(
            x: 33.0,
            y: 33.0,
          ),
        );

        verify(service.updateInteractionInDatabase(
            updatedInteraction: updatedInteraction,
            oldInteraction: kGeneralInteraction));
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
            kGeneralInteraction.position.capturedDeviceWidth,
            kGeneralInteraction.position.capturedDeviceHeight);

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
        model.setWidgetType = WidgetType.input;
        await model.removeWidgetDescription();
        expect(model.captureState, CaptureWidgetState.idle);
      });
    });

    group('popupMenuActionSelected -', () {
      test(
          'When popupMenuAction is edit, Should set the captureWidgetStatusEnum to editWidget',
          () {
        final model = _getViewModel();
        model.popupMenuActionSelected(
            kGeneralInteraction, PopupMenuAction.edit);
        expect(model.captureState, CaptureWidgetState.editWidget);
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
