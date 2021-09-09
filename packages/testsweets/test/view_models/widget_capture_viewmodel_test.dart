import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:testsweets/src/enums/capture_widget_enum.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:testsweets/src/models/enums/widget_type.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_viewmodel.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('WidgetCaptureViewModelTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
    group('constructer -', () {
      test('When called, should call initialize and set viewmodel busy',
          () async {
        final projectId = 'testSweets Id';

        final model = WidgetCaptureViewModel(projectId: projectId);

        expect(model.isBusy, true);
      });
    });
    group('initialize -', () {
      test('When called, should get all widget description for project',
          () async {
        final service = getAndRegisterWidgetCaptureService();
        final projectId = 'testSweets Id';

        WidgetCaptureViewModel(projectId: projectId);

        verify(service.loadWidgetDescriptionsForProject(projectId: projectId));
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

        final projectId = 'testSweets Id';

        final model = WidgetCaptureViewModel(projectId: projectId);

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

        final projectId = 'testSweets Id';
        final model = WidgetCaptureViewModel(projectId: projectId);

        model.showWidgetDescription(description);

        expect(
            model.captureWidgetStatusEnum ==
                CaptureWidgetStatusEnum.inspectModeDialogShow,
            isTrue);
        expect(model.ignorePointer, isTrue);
      });
    });

    group('closeWidgetDescription -', () {
      test('When called, should set the active widgetId to empty', () async {
        final projectId = 'testSweets Id';
        final model = WidgetCaptureViewModel(projectId: projectId);

        model.closeWidgetDescription();

        expect(model.activeWidgetId, isEmpty);
      });

      test(
          'When called, should set widget description and ignore pointer boolean value be false',
          () async {
        final projectId = 'testSweets Id';
        final model = WidgetCaptureViewModel(projectId: projectId);

        model.closeWidgetDescription();

        expect(
            model.captureWidgetStatusEnum ==
                CaptureWidgetStatusEnum.inspectModeDialogShow,
            isFalse);
        expect(model.ignorePointer, isFalse);
      });
    });
  });
}
