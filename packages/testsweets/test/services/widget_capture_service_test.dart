import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:testsweets/src/models/enums/widget_type.dart';
import 'package:testsweets/src/services/widget_capture_service.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('WidgetCaptureServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());

    group('captureWidgetDescription -', () {
      test(
          'When called, should capture the widget description passed in to the backed',
          () async {
        final description = WidgetDescription(
          viewName: 'login',
          name: 'email',
          position: WidgetPosition(x: 100, y: 199),
          widgetType: WidgetType.general,
        );

        final cloudFunctionsService = getAndRegisterCloudFunctionsService();
        getAndRegisterTestSweetsConfigFileService(
          valueFromConfigFileByKey: 'projectId',
        );

        final service = WidgetCaptureService();
        await service.captureWidgetDescription(description: description);

        verify(cloudFunctionsService.uploadWidgetDescriptionToProject(
          projectId: 'projectId',
          description: description,
        ));
      });

      test(
          'When widget has been added to backend, add description to descriptionMap with id from the backend',
          () async {
        final description = WidgetDescription(
          viewName: 'login',
          name: 'email',
          position: WidgetPosition(x: 100, y: 199),
          widgetType: WidgetType.general,
        );

        final String idToReturn = 'cloud_id';

        getAndRegisterCloudFunctionsService(
            addWidgetDescritpionToProjectResult: idToReturn);

        final service = WidgetCaptureService();
        await service.captureWidgetDescription(description: description);

        expect(
          service.widgetDescriptionMap[description.viewName]?.id,
          idToReturn,
        );
      });
    });
  });
}
