import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:testsweets/src/enums/capture_widget_enum.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_view.form.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_viewmodel.dart';

import '../helpers/test_helpers.dart';

final _projectId = 'testSweets Id';
void main() {
  group('WidgetCaptureViewModelTest -', () {
    setUp(registerServices);
    tearDown(unregisterServices);
    group('constructer -', () {
      test('When called, should call initialize and set viewmodel busy',
          () async {
        final model = WidgetCaptureViewModel(projectId: _projectId);

        expect(model.isBusy, true);
      });
      test('When call the constructer, Should call the initilise function', () {
        final service = getAndRegisterWidgetCaptureService();

        WidgetCaptureViewModel(projectId: _projectId);
        verify(service.loadWidgetDescriptionsForProject(projectId: _projectId));
      });
    });
    group('initialize -', () {
      test('When called, should get all widget description for project',
          () async {
        final service = getAndRegisterWidgetCaptureService();

        WidgetCaptureViewModel(projectId: _projectId);

        verify(service.loadWidgetDescriptionsForProject(projectId: _projectId));
      });
    });

    group('showWidgetDescription -', () {
      test(
          'When called, should set the active widget description to the current widget description',
          () async {
        final description = WidgetDescription(
          id: 'widgetId',
          viewName: 'login',
          name: 'email',
          position: WidgetPosition(x: 100, y: 199),
          widgetType: WidgetType.general,
        );

        final model = WidgetCaptureViewModel(projectId: _projectId);

        model.showWidgetDescription(description);

        expect(model.activeWidgetDescription, description);
        expect(model.activeWidgetId, description.id);
      });

      test(
          'When called, should set widget description and ignore pointer boolean value be true',
          () async {
        final description = WidgetDescription(
          viewName: 'login',
          name: 'email',
          position: WidgetPosition(x: 100, y: 199),
          widgetType: WidgetType.general,
        );

        final model = WidgetCaptureViewModel(projectId: _projectId);

        model.showWidgetDescription(description);

        expect(
            model.captureWidgetStatusEnum ==
                CaptureWidgetStatusEnum.inspectModeDialogShow,
            isTrue);
      });
    });

    group('closeWidgetDescription -', () {
      test('When called, should set the active widgetId to empty', () async {
        final model = WidgetCaptureViewModel(projectId: _projectId);

        model.closeWidgetDescription();

        expect(model.activeWidgetId, isEmpty);
      });

      test(
          'When called, should set widget description and ignore pointer boolean value be false',
          () async {
        final model = WidgetCaptureViewModel(projectId: _projectId);

        model.closeWidgetDescription();

        expect(
            model.captureWidgetStatusEnum ==
                CaptureWidgetStatusEnum.inspectModeDialogShow,
            isFalse);
      });
    });

    group('captureWidgetStatusEnum -', () {
      test('When call getter, Should default to idle', () {
        final model = WidgetCaptureViewModel(projectId: _projectId);
        expect(model.captureWidgetStatusEnum, CaptureWidgetStatusEnum.idle);
      });
      test(
          'When assign the enum to captureMode, Should change the value to the new assigned status',
          () {
        final model = WidgetCaptureViewModel(projectId: _projectId);
        model.captureWidgetStatusEnum = CaptureWidgetStatusEnum.captureMode;
        expect(
            model.captureWidgetStatusEnum, CaptureWidgetStatusEnum.captureMode);
      });
    });
    group('widgetDescription -', () {
      test('When call getter, Should default to null', () {
        final model = WidgetCaptureViewModel(projectId: _projectId);
        expect(model.widgetDescription, null);
      });
    });
    group('hasWidgetNameFocus -', () {
      test('When call getter, Should default to false', () {
        final model = WidgetCaptureViewModel(projectId: _projectId);
        expect(model.hasWidgetNameFocus, false);
      });
    });
    group('activeWidgetId -', () {
      test('When call getter, Should default to empty string', () {
        final model = WidgetCaptureViewModel(projectId: _projectId);
        expect(model.activeWidgetId, '');
      });
    });

    group('widgetNameInputPositionIsDown -', () {
      test('When call getter, Should default to true', () {
        final model = WidgetCaptureViewModel(projectId: _projectId);
        expect(model.widgetNameInputPositionIsDown, true);
      });
    });
    group('activeWidgetDescription -', () {
      test('When call getter, Should default to null', () {
        final model = WidgetCaptureViewModel(projectId: _projectId);
        expect(model.activeWidgetDescription, null);
      });
    });
    group('descriptionsForView -', () {
      test(
          'When call this getter, Should fetch list of WidgetDescription for the current route',
          () {
        final description = WidgetDescription(
          id: 'widgetId',
          viewName: 'login',
          name: 'email',
          position: WidgetPosition(x: 100, y: 199),
          widgetType: WidgetType.general,
        );
        getAndRegisterWidgetCaptureService(
            listOfWidgetDescription: [description]);
        getAndRegisterTestSweetsRouteTracker();
        final model = WidgetCaptureViewModel(projectId: _projectId);

        expect(model.descriptionsForView, [description]);
      });
    });
    group('initialise -', () {
      test(
          'When calling initialise, Should call loadWidgetDescriptionsForProject from WidgetCaptureService',
          () {
        final service = getAndRegisterWidgetCaptureService();
        WidgetCaptureViewModel(projectId: _projectId);
        verify(service.loadWidgetDescriptionsForProject(projectId: _projectId));
      });
    });
    group('toggleCaptureView -', () {
      test(
          'When called while the status is isAtCaptureMode, Should set captureWidgetStatusEnum to idle',
          () {
        final model = WidgetCaptureViewModel(projectId: _projectId);
        model.captureWidgetStatusEnum = CaptureWidgetStatusEnum.captureMode;
        model.toggleCaptureView();
        expect(model.captureWidgetStatusEnum, CaptureWidgetStatusEnum.idle);
      });
      test(
          'When called while the status is anything but isAtCaptureMode, Should set captureWidgetStatusEnum to captureMode',
          () {
        final model = WidgetCaptureViewModel(projectId: _projectId);
        model.captureWidgetStatusEnum = CaptureWidgetStatusEnum.idle;
        model.toggleCaptureView();
        expect(
            model.captureWidgetStatusEnum, CaptureWidgetStatusEnum.captureMode);
      });
    });
    group('toggleInspectLayout -', () {
      test(
          'When called while the status is inspectMode, Should set captureWidgetStatusEnum to idle',
          () {
        final model = WidgetCaptureViewModel(projectId: _projectId);
        model.captureWidgetStatusEnum = CaptureWidgetStatusEnum.inspectMode;
        model.toggleInspectLayout();
        expect(model.captureWidgetStatusEnum, CaptureWidgetStatusEnum.idle);
      });
      test(
          'When called while the status is anything but inspectMode, Should set captureWidgetStatusEnum to captureMode',
          () {
        final model = WidgetCaptureViewModel(projectId: _projectId);
        model.captureWidgetStatusEnum = CaptureWidgetStatusEnum.idle;
        model.toggleInspectLayout();
        expect(
            model.captureWidgetStatusEnum, CaptureWidgetStatusEnum.inspectMode);
      });
    });
    group('updateDescriptionPosition -', () {
      test(
          'When called, Shuold add the difference to widgetDescription position',
          () {
        final model = WidgetCaptureViewModel(projectId: _projectId);
        //initilise it cause it default to null
        model.addNewWidget(WidgetType.touchable,
            widgetPosition: WidgetPosition(x: 1, y: 1));
        model.updateDescriptionPosition(2, 2);
        expect(model.widgetDescription!.position.x, 3);
        expect(model.widgetDescription!.position.y, 3);
      });
    });
    group('saveWidgetDescription -', () {
      test(
          'When called and widget name textfield is empty, Should update nameInputErrorMessage with the following message "Widget name must not be empty"',
          () async {
        final model = WidgetCaptureViewModel(projectId: _projectId);
        model.formValueMap[WidgetNameValueKey] = '';
        await model.saveWidgetDescription();
        expect(model.nameInputErrorMessage, "Widget name must not be empty");
      });
      test(
          'When called with WidgetType.view and widget name textfield is not empty, Should empty nameInputErrorMessage and add the current route as the view name of widgetDescription',
          () async {
        final model = WidgetCaptureViewModel(projectId: _projectId);
        model.formValueMap[WidgetNameValueKey] = 'my widget name';
        model.addNewWidget(WidgetType.view);
        expect(model.nameInputErrorMessage, isEmpty);
        expect(model.widgetDescription!.viewName, 'current route');
      });
    });
  });
}
