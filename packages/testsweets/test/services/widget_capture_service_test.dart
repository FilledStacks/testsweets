import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:testsweets/src/services/widget_capture_service.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('WidgetCaptureServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
    group('initialised -', () {
      test('When initialised, widgetDescriptionMap Should be empty', () {
        final service = WidgetCaptureService();
        expect(service.widgetDescriptionMap, isEmpty);
      });
    });
    group('loadWidgetDescriptions -', () {
      test(
          'When called, should get all the widget descriptions from the CloudFunctionsService',
          () async {
        final cloudFunctionsService = getAndRegisterCloudFunctionsService();
        final service = WidgetCaptureService();
        await service.loadWidgetDescriptionsForProject(projectId: 'proj');
        verify(cloudFunctionsService.getWidgetDescriptionForProject(
          projectId: 'proj',
        ));
      });

      test(
          'When called and descriptions are returned with 1 description for login and 1 for sign up, should populate map with key login and signup',
          () async {
        getAndRegisterCloudFunctionsService(
            getWidgetDescriptionForProjectResult: [
              WidgetDescription(
                viewName: 'login',
                name: 'loginButton',
                widgetType: WidgetType.touchable,
                position: WidgetPosition(x: 0, y: 0),
              ),
              WidgetDescription(
                viewName: 'signUp',
                name: 'loginButton',
                widgetType: WidgetType.touchable,
                position: WidgetPosition(x: 0, y: 0),
              ),
            ]);
        final service = WidgetCaptureService();
        await service.loadWidgetDescriptionsForProject(projectId: 'proj');

        expect(service.widgetDescriptionMap.containsKey('login'), true);
        expect(service.widgetDescriptionMap.containsKey('signUp'), true);
      });

      test(
          'When called and descriptions are returned with 2 descriptions for login, should have 2 in login key',
          () async {
        getAndRegisterCloudFunctionsService(
            getWidgetDescriptionForProjectResult: [
              WidgetDescription(
                viewName: 'login',
                name: 'loginButton',
                widgetType: WidgetType.touchable,
                position: WidgetPosition(x: 0, y: 0),
              ),
              WidgetDescription(
                viewName: 'login',
                name: 'loginButton2',
                widgetType: WidgetType.touchable,
                position: WidgetPosition(x: 0, y: 0),
              ),
            ]);
        final service = WidgetCaptureService();
        await service.loadWidgetDescriptionsForProject(projectId: 'proj');

        expect(service.widgetDescriptionMap['login']?.length, 2);
      });
    });

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
        await service.captureWidgetDescription(
            description: description, projectId: 'proj');

        verify(cloudFunctionsService.uploadWidgetDescriptionToProject(
          projectId: 'proj',
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
            addWidgetDescriptionToProjectResult: idToReturn);

        final service = WidgetCaptureService();
        await service.captureWidgetDescription(
            description: description, projectId: 'prodj');

        expect(
          service.widgetDescriptionMap[description.viewName]?.first.id,
          idToReturn,
        );
      });
      group('checkCurrentViewIfAlreadyCaptured -', () {
        test('When call and the view is captured, Should return true',
            () async {
          getAndRegisterCloudFunctionsService(
              getWidgetDescriptionForProjectResult: [
                WidgetDescription(
                  viewName: 'login',
                  name: 'loginButton',
                  widgetType: WidgetType.touchable,
                  position: WidgetPosition(x: 0, y: 0),
                ),
                WidgetDescription(
                  viewName: 'signUp',
                  name: 'loginButton',
                  widgetType: WidgetType.touchable,
                  position: WidgetPosition(x: 0, y: 0),
                ),
                WidgetDescription(
                  viewName: '/',
                  name: '',
                  widgetType: WidgetType.view,
                  position: WidgetPosition(x: 0, y: 0),
                ),
              ]);

          final service = WidgetCaptureService();
          await service.loadWidgetDescriptionsForProject(projectId: 'proj');

          bool isViewAlreadyExist =
              service.checkCurrentViewIfAlreadyCaptured('/');
          expect(isViewAlreadyExist, true);
        });
      });
    });
    group('addWidgetDescriptionToMap -', () {
      test(
          'When WidgetDescription has viewName that not empty(meaning that anything but view), Should create a new key from its viewName',
          () {
        final service = WidgetCaptureService();
        service.addWidgetDescriptionToMap(
          description: WidgetDescription(
            viewName: '/new_view',
            name: 'button',
            widgetType: WidgetType.touchable,
            position: WidgetPosition(x: 0, y: 0),
          ),
        );
        expect(service.widgetDescriptionMap['/new_view']!.length, 1);
      });

      test('When isUpdate is true, Should create a new key from its viewName',
          () {
        final service = WidgetCaptureService();
        service.addWidgetDescriptionToMap(
          description: WidgetDescription(
            viewName: '/new_view',
            name: 'button',
            widgetType: WidgetType.touchable,
            position: WidgetPosition(x: 0, y: 0),
          ),
        );
        expect(service.widgetDescriptionMap['/new_view']!.length, 1);
      });
      test(
          'When two WidgetDescription has the same viewName , Should add the second widget to the already added key from the first one ',
          () {
        final service = WidgetCaptureService();
        service.addWidgetDescriptionToMap(
          description: WidgetDescription(
            viewName: '/new_view',
            name: 'button',
            widgetType: WidgetType.touchable,
            position: WidgetPosition(x: 0, y: 0),
          ),
        );
        service.addWidgetDescriptionToMap(
          description: WidgetDescription(
            viewName: '/new_view',
            name: 'inputField',
            widgetType: WidgetType.input,
            position: WidgetPosition(x: 0, y: 0),
          ),
        );
        expect(service.widgetDescriptionMap['/new_view']!.length, 2);
      });
    });

    group('deleteWidgetDescription -', () {
      test(
          'When called, should call delete widget description from the CloudFunctionsService',
          () async {
        final description = WidgetDescription(
          viewName: 'login',
          name: 'email',
          position: WidgetPosition(x: 100, y: 199),
          widgetType: WidgetType.general,
        );

        final cloudFunctionsService = getAndRegisterCloudFunctionsService();
        final service = WidgetCaptureService();
        await service.deleteWidgetDescription(
          projectId: 'proJ',
          description: description,
        );

        verify(cloudFunctionsService.deleteWidgetDescription(
            projectId: 'proJ', description: description));
      });

      test(
          'When called and result is successful, Should remove description from List of widget descriptions',
          () async {
        getAndRegisterCloudFunctionsService(
            getWidgetDescriptionForProjectResult: [
              WidgetDescription(
                viewName: 'login',
                name: 'loginButton',
                widgetType: WidgetType.touchable,
                position: WidgetPosition(x: 0, y: 0),
              ),
              WidgetDescription(
                viewName: 'signUp',
                name: 'loginButton',
                widgetType: WidgetType.touchable,
                position: WidgetPosition(x: 0, y: 0),
              ),
            ]);
        final service = WidgetCaptureService();
        await service.deleteWidgetDescription(
          projectId: 'proj',
          description: WidgetDescription(
            viewName: 'signUp',
            name: 'loginButton',
            widgetType: WidgetType.touchable,
            position: WidgetPosition(x: 0, y: 0),
          ),
        );

        expect(service.widgetDescriptionMap.containsKey('signUp'), false);
      });
    });

    group('updateWidgetDescription -', () {
      test(
          'When called, should call update widget description from the CloudFunctionsService',
          () async {
        final description = WidgetDescription(
          viewName: 'login',
          name: 'email',
          position: WidgetPosition(x: 100, y: 199),
          widgetType: WidgetType.general,
        );

        final cloudFunctionsService = getAndRegisterCloudFunctionsService();
        final service = WidgetCaptureService();
        await service.updateWidgetDescription(
          projectId: 'proJ',
          description: description,
        );

        verify(cloudFunctionsService.updateWidgetDescription(
            projectId: 'proJ', description: description));
      });

      test(
          'When called and result is successful, Should update description from List of widget descriptions',
          () async {
        getAndRegisterCloudFunctionsService(
            getWidgetDescriptionForProjectResult: [
              WidgetDescription(
                viewName: 'login',
                name: 'loginButton',
                widgetType: WidgetType.touchable,
                position: WidgetPosition(x: 0, y: 0),
              ),
              WidgetDescription(
                viewName: 'signUp',
                name: 'loginButton',
                widgetType: WidgetType.touchable,
                position: WidgetPosition(x: 0, y: 0),
              ),
            ]);
        final service = WidgetCaptureService();
        await service.updateWidgetDescription(
          projectId: 'proj',
          description: WidgetDescription(
            viewName: 'signUp',
            name: 'loginBBButton',
            widgetType: WidgetType.touchable,
            position: WidgetPosition(x: 0, y: 0),
          ),
        );

        expect(
            service.widgetDescriptionMap['signUp']!.last.name, 'loginBBButton');
      });
    });
  });
}
