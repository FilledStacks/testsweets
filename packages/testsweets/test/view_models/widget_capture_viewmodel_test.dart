import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:testsweets/src/enums/capture_widget_enum.dart';
import 'package:testsweets/src/enums/popup_menu_action.dart';
import 'package:testsweets/src/enums/toast_type.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:testsweets/src/services/reactive_scrollable.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_view_form.dart';
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
        model.saveWidget();
        expect(model.inProgressInteraction!.originalViewName, 'current route');
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
        model.saveWidget();
        expect(model.inProgressInteraction!.viewName, 'currentRoute');
        expect(model.inProgressInteraction!.originalViewName, '/current route');
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
        model.saveWidget();
        expect(model.inProgressInteraction!.name, 'loginButton');
      });
    });

    group('updateWidgetDescription -', () {
      test(
          'When change the name, should call updateWidgetDescription() in WidgetCaptureService with the new name"',
          () async {
        final service = getAndRegisterWidgetCaptureService();

        final model = _getViewModel();
        await model.popupMenuActionSelected(
            kGeneralInteraction, PopupMenuAction.edit);
        model.formValueMap[WidgetNameValueKey] = 'loginButton';
        model.setFormStatus();

        await model.updateWidgetDescription();

        verify(service.updateWidgetDescription(
            description: kGeneralInteraction.copyWith(name: 'loginButton')));
      });

      test(
          'When called and update was successful, Should set the current CaptureWidgetStatusEnum to inspectMode',
          () async {
        final model = _getViewModel();

        model.showWidgetForm();

        model.formValueMap[WidgetNameValueKey] = 'loginButton';

        await model.updateWidgetDescription();

        expect(model.captureWidgetStatusEnum, CaptureWidgetStatusEnum.idle);
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
        verify(widgetCaptureService.removeWidgetDescription(
            description: kGeneralInteraction));
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
        verify(widgetCaptureService.removeWidgetDescription(
            description: kGeneralInteraction));
      });
    });
    group('reactToScroll -', () {
      test('''
        When called on multiple interactions,
        Should pick the overlapping one add the scrollExtent
        to the YTranslit if the scrollable is vertical
        ''', () async {
        getAndRegisterWidgetCaptureService(
          listOfWidgetDescription: [
            kGeneralInteractionWithZeroOffset.copyWith(
                externalities: {SerializableRect.fromLTWH(0, 0, 0, 0)}),
            kGeneralInteraction
          ],
        );

        // I want to use the real service not the mocked one
        registerServiceInsteadOfMockedOne(ReactiveScrollable());

        final model = _getViewModel();
        await model.loadWidgetDescriptions();

        model.reactToScroll(kTopLeftVerticalScrollableDescription);

        /// It should be the first item not the second but replaceing
        /// widget adds the widget at the end of the list
        expect(model.viewInteractions[1].position.yDeviation, 100);
      });
      test('''
          When repeating the same scroll but now the interaction is already scrolled vertically
          So YTranslate not null
        ''', () async {
        getAndRegisterWidgetCaptureService(
          listOfWidgetDescription: [
            kGeneralInteractionWithZeroOffset.copyWith(
                position: WidgetPosition(x: 0, y: 0, yDeviation: 100),
                externalities: {SerializableRect.fromLTWH(0, 0, 0, 0)}),
            kGeneralInteraction
          ],
        );

        // I want to use the real service not the mocked one
        registerServiceInsteadOfMockedOne(ReactiveScrollable());

        final model = _getViewModel();
        await model.loadWidgetDescriptions();

        model.reactToScroll(kTopLeftVerticalScrollableDescription);

        /// It should be the first item not the second but replaceing
        /// widget adds the widget at the end of the list
        expect(model.viewInteractions[1].position.yDeviation, 100);
      });
      test('''
        When called two times(one vertical list and one horizontal) on one interaction,
        Should add the scrollExtent once for YTranslate and once for XTranslate
        ''', () async {
        getAndRegisterWidgetCaptureService(
          listOfWidgetDescription: [
            kGeneralInteractionWithZeroOffset.copyWith(
                position: WidgetPosition(x: 21, y: 22),
                externalities: {
                  SerializableRect.fromLTWH(
                      0, 0, 0, 0), // captured vertical list rect
                  SerializableRect.fromLTWH(0, 20, 0, 0,
                      nested:
                          true), // captured horizontal list rect which is nested inside
                  // the virtical one
                }),
            kGeneralInteraction
          ],
        );

        registerServiceInsteadOfMockedOne(ReactiveScrollable());

        final model = _getViewModel();
        await model.loadWidgetDescriptions();

        model.reactToScroll(kTopLeftVerticalScrollableDescription);

        /// Assumming that the horizontal list inside the vertical one
        /// it should move after the we scroll the vertical and that will change its rect
        /// so we will change it now manually to emulate the flutter scroll change
        final horizontalScrollableDescription =
            kTopLeftHorizontalScrollableDescription.copyWith(
          rect: SerializableRect.fromPoints(
            Offset(
              0,
              20 + 100, // where 100 is the scroll result from the vertical list
            ),
            Offset(
              40,
              40 + 100,
            ),
          ),
        );

        model.reactToScroll(horizontalScrollableDescription);

        /// It should be the first index(0) not the second(1) but when
        /// replacing an interaciton it adds it at the end of the list
        expect(model.viewInteractions[1].position.yDeviation, 100);
        expect(model.viewInteractions[1].position.xDeviation, 50);
      });
    });
  });
}
