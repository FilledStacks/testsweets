import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:testsweets/src/enums/capture_widget_enum.dart';
import 'package:testsweets/src/enums/popup_menu_action.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_view.form.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_viewmodel.dart';
import 'package:testsweets/utils/error_messages.dart';

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
        model.widgetDescription!.copyWith(widgetType: WidgetType.scrollable);
        model.saveWidget();
        expect(model.widgetDescription!.originalViewName, 'current route');
      });
      test('''When called and the current route is `/current route`,
           Should convert it to `currentRoute` in viewName proberty before send it to backend''',
          () async {
        getAndRegisterTestSweetsRouteTracker(currentRoute: '/current route');
        final model = _getViewModel();
        model.formValueMap[WidgetNameValueKey] = 'myWidgetName';
        model.showWidgetForm();
        model.widgetDescription!.copyWith(widgetType: WidgetType.scrollable);
        model.saveWidget();
        expect(model.widgetDescription!.viewName, 'currentRoute');
        expect(model.widgetDescription!.originalViewName, '/current route');
      });
      test('''When called and the current widget name is `login-button`,
           Should convert it to `loginButton` in name proberty before send it to backend''',
          () async {
        getAndRegisterTestSweetsRouteTracker(currentRoute: '/current route');
        final model = _getViewModel();
        model.showWidgetForm();

        model.formValueMap[WidgetNameValueKey] = 'login-button';

        model.widgetDescription =
            model.widgetDescription!.copyWith(widgetType: WidgetType.touchable);
        model.saveWidget();
        expect(model.widgetDescription!.name, 'loginButton');
      });
    });

    group('updateWidgetDescription -', () {
      test(
          'When change the name, should call updateWidgetDescription() in WidgetCaptureService with the new name"',
          () async {
        final service = getAndRegisterWidgetCaptureService();

        final model = _getViewModel();
        model.popupMenuShown(kWidgetDescription);

        model.formValueMap[WidgetNameValueKey] = 'loginButton';
        model.setFormStatus();
        await model.updateWidgetDescription();

        verify(service.updateWidgetDescription(
            description: kWidgetDescription.copyWith(name: 'loginButton')));
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
        model.showWidgetForm();
        model.popupMenuShown(kWidgetDescription);

        await model.removeWidgetDescription();
        verify(widgetCaptureService.deleteWidgetDescription(
            description: kWidgetDescription));
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
  });
}
