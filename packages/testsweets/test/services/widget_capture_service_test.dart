import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
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
        await service.loadWidgetDescriptionsForProject();
        verify(cloudFunctionsService.getWidgetDescriptionForProject());
      });

      test(
          'When called and descriptions are returned with 1 description for login and 1 for sign up, should populate map with key login and signup',
          () async {
        getAndRegisterCloudFunctionsService(
            getWidgetDescriptionForProjectResult: [
              WidgetDescription(
                originalViewName: 'login_view',
                viewName: 'loginView',
                name: 'loginButton',
                widgetType: WidgetType.touchable,
                position: WidgetPosition(
                    x: 0,
                    y: 0,
                    capturedDeviceHeight: 0,
                    capturedDeviceWidth: 0),
              ),
              WidgetDescription(
                originalViewName: 'signup_view',
                viewName: 'signUpView',
                name: 'loginButton',
                widgetType: WidgetType.touchable,
                position: WidgetPosition(
                    x: 0,
                    y: 0,
                    capturedDeviceHeight: 0,
                    capturedDeviceWidth: 0),
              ),
            ]);
        final service = WidgetCaptureService();
        await service.loadWidgetDescriptionsForProject();

        expect(service.widgetDescriptionMap.containsKey('login_view'), true);
        expect(service.widgetDescriptionMap.containsKey('signup_view'), true);
      });

      test(
          'When called and descriptions are returned with 2 descriptions for login, should have 2 in login key',
          () async {
        getAndRegisterCloudFunctionsService(
            getWidgetDescriptionForProjectResult: [
              WidgetDescription(
                originalViewName: 'login_view',
                viewName: 'loginView',
                name: 'loginButton',
                widgetType: WidgetType.touchable,
                position: WidgetPosition(
                    x: 0,
                    y: 0,
                    capturedDeviceHeight: 0,
                    capturedDeviceWidth: 0),
              ),
              WidgetDescription(
                originalViewName: 'login_view',
                viewName: 'loginView',
                name: 'loginButton2',
                widgetType: WidgetType.touchable,
                position: WidgetPosition(
                    x: 0,
                    y: 0,
                    capturedDeviceHeight: 0,
                    capturedDeviceWidth: 0),
              ),
            ]);
        final service = WidgetCaptureService();
        await service.loadWidgetDescriptionsForProject();

        expect(service.widgetDescriptionMap['login_view']?.length, 2);
      });
    });

    group('captureWidgetDescription -', () {
      test(
          'When called, should capture the widget description passed in to the backed',
          () async {
        final description = WidgetDescription(
          originalViewName: '',
          viewName: 'login',
          name: 'email',
          position: WidgetPosition(
              x: 100, y: 199, capturedDeviceHeight: 0, capturedDeviceWidth: 0),
          widgetType: WidgetType.general,
        );

        final cloudFunctionsService = getAndRegisterCloudFunctionsService();

        final service = WidgetCaptureService();
        await service.captureWidgetDescription(
          description: description,
        );

        verify(cloudFunctionsService.uploadWidgetDescriptionToProject(
          description: description,
        ));
      });

      test(
          'When widget has been added to backend, add description to descriptionMap with id from the backend',
          () async {
        final description = WidgetDescription(
          originalViewName: 'login_view',
          viewName: 'loginView',
          name: 'email',
          position: WidgetPosition(
              x: 100, y: 199, capturedDeviceHeight: 0, capturedDeviceWidth: 0),
          widgetType: WidgetType.general,
        );

        final String idToReturn = 'cloud_id';

        getAndRegisterCloudFunctionsService(
            addWidgetDescriptionToProjectResult: idToReturn);

        final service = WidgetCaptureService();
        await service.captureWidgetDescription(
          description: description,
        );

        expect(
          service.widgetDescriptionMap[description.originalViewName]?.first.id,
          idToReturn,
        );
      });
    });
    group('checkCurrentViewIfAlreadyCaptured -', () {
      test('When call and the view is captured, Should return true', () async {
        getAndRegisterCloudFunctionsService(
            getWidgetDescriptionForProjectResult: [
              WidgetDescription(
                originalViewName: 'login_view',
                viewName: 'loginView',
                name: 'loginButton',
                widgetType: WidgetType.touchable,
                position: WidgetPosition(
                    x: 0,
                    y: 0,
                    capturedDeviceHeight: 0,
                    capturedDeviceWidth: 0),
              ),
              WidgetDescription(
                originalViewName: 'signUp_view',
                viewName: 'signUpView',
                name: 'loginButton',
                widgetType: WidgetType.touchable,
                position: WidgetPosition(
                    x: 0,
                    y: 0,
                    capturedDeviceHeight: 0,
                    capturedDeviceWidth: 0),
              ),
              WidgetDescription(
                originalViewName: '/',
                viewName: 'initialView',
                name: '',
                widgetType: WidgetType.view,
                position: WidgetPosition(
                    x: 0,
                    y: 0,
                    capturedDeviceHeight: 0,
                    capturedDeviceWidth: 0),
              ),
            ]);

        final service = WidgetCaptureService();
        await service.loadWidgetDescriptionsForProject();

        bool isViewAlreadyExist =
            service.checkCurrentViewIfAlreadyCaptured('/');
        expect(isViewAlreadyExist, true);
      });
    });
    group('addWidgetDescriptionToMap -', () {
      test(
          'When WidgetDescription has viewName that not empty(meaning that anything but view), Should create a new key from its viewName',
          () {
        final service = WidgetCaptureService();
        service.addWidgetDescriptionToMap(
          description: WidgetDescription(
            originalViewName: '/new_view',
            viewName: 'newView',
            name: 'button',
            widgetType: WidgetType.touchable,
            position: WidgetPosition(
                x: 0, y: 0, capturedDeviceHeight: 0, capturedDeviceWidth: 0),
          ),
        );
        expect(service.widgetDescriptionMap['/new_view']!.length, 1);
      });

      test('When isUpdate is true, Should create a new key from its viewName',
          () {
        final service = WidgetCaptureService();
        service.addWidgetDescriptionToMap(
          description: WidgetDescription(
            originalViewName: '/new_view',
            viewName: 'newView',
            name: 'button',
            widgetType: WidgetType.touchable,
            position: WidgetPosition(
                x: 0, y: 0, capturedDeviceHeight: 0, capturedDeviceWidth: 0),
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
            originalViewName: '/new_view',
            viewName: 'newView',
            name: 'button',
            widgetType: WidgetType.touchable,
            position: WidgetPosition(
                x: 0, y: 0, capturedDeviceHeight: 0, capturedDeviceWidth: 0),
          ),
        );
        service.addWidgetDescriptionToMap(
          description: WidgetDescription(
            originalViewName: '/new_view',
            viewName: 'newView',
            name: 'inputField',
            widgetType: WidgetType.input,
            position: WidgetPosition(
                x: 0, y: 0, capturedDeviceHeight: 0, capturedDeviceWidth: 0),
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
          originalViewName: '/new_view',
          viewName: 'newView',
          name: 'email',
          position: WidgetPosition(
              x: 100, y: 199, capturedDeviceHeight: 0, capturedDeviceWidth: 0),
          widgetType: WidgetType.general,
        );

        final cloudFunctionsService = getAndRegisterCloudFunctionsService();
        final service = WidgetCaptureService();
        await service.deleteWidgetDescription(
          description: description,
        );

        verify(cloudFunctionsService.deleteWidgetDescription(
            description: description));
      });

      test(
          'When called and result is successful, Should remove description from List of widget descriptions',
          () async {
        getAndRegisterCloudFunctionsService(
            getWidgetDescriptionForProjectResult: [
              WidgetDescription(
                viewName: 'login',
                originalViewName: '/login_view',
                name: 'loginButton',
                widgetType: WidgetType.touchable,
                position: WidgetPosition(
                    x: 0,
                    y: 0,
                    capturedDeviceHeight: 0,
                    capturedDeviceWidth: 0),
              ),
              WidgetDescription(
                viewName: 'signUp',
                originalViewName: '/login_view',
                name: 'loginButton',
                widgetType: WidgetType.touchable,
                position: WidgetPosition(
                    x: 0,
                    y: 0,
                    capturedDeviceHeight: 0,
                    capturedDeviceWidth: 0),
              ),
            ]);
        final service = WidgetCaptureService();
        await service.deleteWidgetDescription(
          description: WidgetDescription(
            viewName: 'signUp',
            originalViewName: '/signUp_view',
            name: 'loginButton',
            widgetType: WidgetType.touchable,
            position: WidgetPosition(
                x: 0, y: 0, capturedDeviceHeight: 0, capturedDeviceWidth: 0),
          ),
        );

        expect(service.widgetDescriptionMap.containsKey('signUp'), false);
      });
    });

    group('getDescriptionsForView -', () {
      test(
          'When called with route homeView, should return the widgets for homeView only',
          () async {
        getAndRegisterCloudFunctionsService(
            getWidgetDescriptionForProjectResult: [
              WidgetDescription(
                viewName: 'homeView',
                originalViewName: '/home_view',
                name: 'bottomTab1',
                widgetType: WidgetType.touchable,
                position: WidgetPosition(
                    x: 0,
                    y: 0,
                    capturedDeviceHeight: 0,
                    capturedDeviceWidth: 0),
              ),
              WidgetDescription(
                viewName: 'homeView',
                originalViewName: '/home_view',
                name: 'bottomTab2',
                widgetType: WidgetType.touchable,
                position: WidgetPosition(
                    x: 0,
                    y: 0,
                    capturedDeviceHeight: 0,
                    capturedDeviceWidth: 0),
              ),
            ]);
        final service = WidgetCaptureService();
        await service.loadWidgetDescriptionsForProject();

        final result =
            service.getDescriptionsForView(currentRoute: '/home_view');
        expect(result.length, 2);
      });

      test(
          'When called with route homeView0, should return the widgets for homeView + homeView0',
          () async {
        getAndRegisterCloudFunctionsService(
            getWidgetDescriptionForProjectResult: [
              WidgetDescription(
                viewName: 'homeView',
                originalViewName: '/home_view',
                name: 'bottomTab1',
                widgetType: WidgetType.touchable,
                position: WidgetPosition(
                    x: 0,
                    y: 0,
                    capturedDeviceHeight: 0,
                    capturedDeviceWidth: 0),
              ),
              WidgetDescription(
                viewName: 'homeView',
                originalViewName: '/home_view',
                name: 'bottomTab2',
                widgetType: WidgetType.touchable,
                position: WidgetPosition(
                    x: 0,
                    y: 0,
                    capturedDeviceHeight: 0,
                    capturedDeviceWidth: 0),
              ),
              WidgetDescription(
                viewName: 'homeView0',
                originalViewName: '/home_view0',
                name: 'bottomTab2',
                widgetType: WidgetType.touchable,
                position: WidgetPosition(
                    x: 0,
                    y: 0,
                    capturedDeviceHeight: 0,
                    capturedDeviceWidth: 0),
              ),
              WidgetDescription(
                viewName: 'homeView1',
                originalViewName: '/home_view1',
                name: 'bottomTab2',
                widgetType: WidgetType.touchable,
                position: WidgetPosition(
                    x: 0,
                    y: 0,
                    capturedDeviceHeight: 0,
                    capturedDeviceWidth: 0),
              ),
            ]);
        final service = WidgetCaptureService();
        await service.loadWidgetDescriptionsForProject();

        final result =
            service.getDescriptionsForView(currentRoute: '/home_view0');
        expect(result.length, 3);
      });

      test(
          'When called with route homeView1, should return the widgets for homeView + homeView0',
          () async {
        getAndRegisterCloudFunctionsService(
            getWidgetDescriptionForProjectResult: [
              WidgetDescription(
                viewName: 'homeView',
                originalViewName: '/home_view',
                name: 'bottomTab1',
                widgetType: WidgetType.touchable,
                position: WidgetPosition(
                    x: 0,
                    y: 0,
                    capturedDeviceHeight: 0,
                    capturedDeviceWidth: 0),
              ),
              WidgetDescription(
                viewName: 'homeView',
                originalViewName: '/home_view',
                name: 'bottomTab2',
                widgetType: WidgetType.touchable,
                position: WidgetPosition(
                    x: 0,
                    y: 0,
                    capturedDeviceHeight: 0,
                    capturedDeviceWidth: 0),
              ),
              WidgetDescription(
                viewName: 'homeView0',
                originalViewName: '/home_view0',
                name: 'bottomTab2',
                widgetType: WidgetType.touchable,
                position: WidgetPosition(
                    x: 0,
                    y: 0,
                    capturedDeviceHeight: 0,
                    capturedDeviceWidth: 0),
              ),
              WidgetDescription(
                viewName: 'homeView1',
                originalViewName: '/home_view1',
                name: 'bottomTab2',
                widgetType: WidgetType.touchable,
                position: WidgetPosition(
                    x: 0,
                    y: 0,
                    capturedDeviceHeight: 0,
                    capturedDeviceWidth: 0),
              ),
              WidgetDescription(
                viewName: 'homeView1',
                originalViewName: '/home_view1',
                name: 'bottomTab3',
                widgetType: WidgetType.touchable,
                position: WidgetPosition(
                    x: 0,
                    y: 0,
                    capturedDeviceHeight: 0,
                    capturedDeviceWidth: 0),
              ),
            ]);
        final service = WidgetCaptureService();
        await service.loadWidgetDescriptionsForProject();

        final result =
            service.getDescriptionsForView(currentRoute: '/home_view1');
        expect(result.length, 4);
      });
    });

    group('updateWidgetDescription -', () {
      test(
          'When called, should call update widget description from the CloudFunctionsService',
          () async {
        final description = WidgetDescription(
          viewName: 'login',
          originalViewName: '/login_view',
          name: 'email',
          position: WidgetPosition(
              x: 100, y: 199, capturedDeviceHeight: 0, capturedDeviceWidth: 0),
          widgetType: WidgetType.general,
        );

        final cloudFunctionsService = getAndRegisterCloudFunctionsService();
        final service = WidgetCaptureService();
        service.addWidgetDescriptionToMap(description: description);
        await service.updateWidgetDescription(
          description: description,
        );

        verify(cloudFunctionsService.updateWidgetDescription(
            oldwidgetDescription: description,
            newwidgetDescription: description));
      });

      test(
          'When called and result is successful, Should update description from List of widget descriptions',
          () async {
        getAndRegisterCloudFunctionsService(
            getWidgetDescriptionForProjectResult: [
              WidgetDescription(
                viewName: 'login',
                originalViewName: '/login_view',
                name: 'loginButton',
                widgetType: WidgetType.touchable,
                position: WidgetPosition(
                    x: 0,
                    y: 0,
                    capturedDeviceHeight: 0,
                    capturedDeviceWidth: 0),
              ),
              WidgetDescription(
                viewName: 'signUp',
                originalViewName: '/signUp_view',
                name: 'loginButton',
                widgetType: WidgetType.touchable,
                position: WidgetPosition(
                    x: 0,
                    y: 0,
                    capturedDeviceHeight: 0,
                    capturedDeviceWidth: 0),
              ),
            ]);
        final service = WidgetCaptureService();
        service.addWidgetDescriptionToMap(
          description: WidgetDescription(
            id: '1234',
            originalViewName: '/signUp_view',
            viewName: 'signUp',
            name: 'loginBBButton',
            widgetType: WidgetType.touchable,
            position: WidgetPosition(
                x: 0, y: 0, capturedDeviceHeight: 0, capturedDeviceWidth: 0),
          ),
        );

        await service.updateWidgetDescription(
          description: WidgetDescription(
            id: '1234',
            originalViewName: '/signUp_view',
            viewName: 'signUp',
            name: 'loginBBButton',
            widgetType: WidgetType.touchable,
            position: WidgetPosition(
                x: 0, y: 0, capturedDeviceHeight: 0, capturedDeviceWidth: 0),
          ),
        );

        expect(service.widgetDescriptionMap['/signUp_view']!.last.name,
            'loginBBButton');
      });
    });
  });
}
