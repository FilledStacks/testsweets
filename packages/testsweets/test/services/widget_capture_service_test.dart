import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:testsweets/src/services/widget_capture_service.dart';

import '../helpers/test_consts.dart';
import '../helpers/test_helpers.dart';

WidgetCaptureService get _getService => WidgetCaptureService(verbose: true);
void main() {
  group('WidgetCaptureServiceTest -', () {
    setUp(() {
      registerServices();
    });
    tearDown(unregisterServices);
    group('initialised -', () {
      test('When initialised, widgetDescriptionMap Should be empty', () {
        final _service = _getService;
        _service.projectId = 'PrjectId';
        expect(_service.widgetDescriptionMap, isEmpty);
      });
    });
    group('loadWidgetDescriptions -', () {
      test(
          'When called, should get all the widget descriptions from the CloudFunctionsService',
          () async {
        final cloudFunctionsService = getAndRegisterCloudFunctionsService();
        final _service = _getService;

        await _service.loadWidgetDescriptionsForProject();
        verify(cloudFunctionsService.getWidgetDescriptionForProject(
            projectId: 'projectId'));
      });

      test(
          'When called and descriptions are returned with 1 description for login and 1 for sign up, should populate map with key login and signup',
          () async {
        getAndRegisterCloudFunctionsService(
            getWidgetDescriptionForProjectResult: [
              Interaction(
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
              Interaction(
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
        final _service = _getService;

        await _service.loadWidgetDescriptionsForProject();

        expect(_service.widgetDescriptionMap.containsKey('login_view'), true);
        expect(_service.widgetDescriptionMap.containsKey('signup_view'), true);
      });

      test(
          'When called and descriptions are returned with 2 descriptions for login, should have 2 in login key',
          () async {
        getAndRegisterCloudFunctionsService(
            getWidgetDescriptionForProjectResult: [
              Interaction(
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
              Interaction(
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
        final _service = _getService;

        await _service.loadWidgetDescriptionsForProject();

        expect(_service.widgetDescriptionMap['login_view']?.length, 2);
      });
    });

    group('captureWidgetDescription -', () {
      test(
          'When called, should capture the widget description passed in to the backed',
          () async {
        final description = Interaction(
          originalViewName: 'OriginalLoginView',
          viewName: 'loginView',
          name: 'email',
          position: WidgetPosition(
              x: 100, y: 199, capturedDeviceHeight: 0, capturedDeviceWidth: 0),
          widgetType: WidgetType.general,
        );

        final cloudFunctionsService = getAndRegisterCloudFunctionsService();
        final _service = _getService;
        _service.addWidgetDescriptionToMap = Interaction.view(
            viewName: 'OriginalLoginView',
            originalViewName: 'OriginalLoginView');
        await _service.saveInteractionInDatabase(description);

        verify(cloudFunctionsService.uploadWidgetDescriptionToProject(
          projectId: 'projectId',
          description: description,
        ));
      });
    });
    group('checkCurrentViewIfAlreadyCaptured -', () {
      test('When call and the view is captured, Should return true', () async {
        getAndRegisterCloudFunctionsService(
            getWidgetDescriptionForProjectResult: [
              Interaction(
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
              Interaction(
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
              Interaction(
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
        final _service = _getService;

        await _service.loadWidgetDescriptionsForProject();

        bool isViewAlreadyExist =
            _service.checkCurrentViewIfAlreadyCaptured('/');
        expect(isViewAlreadyExist, true);
      });
    });
    group('addWidgetDescriptionToMap -', () {
      test(
          'When WidgetDescription has viewName that not empty(meaning that anything but view), Should create a new key from its viewName',
          () {
        final _service = _getService;

        _service.addWidgetDescriptionToMap = Interaction(
          originalViewName: '/new_view',
          viewName: 'newView',
          name: 'button',
          widgetType: WidgetType.touchable,
          position: WidgetPosition(
              x: 0, y: 0, capturedDeviceHeight: 0, capturedDeviceWidth: 0),
        );
        expect(_service.widgetDescriptionMap['/new_view']!.length, 1);
      });

      test('When isUpdate is true, Should create a new key from its viewName',
          () {
        final _service = _getService;

        _service.addWidgetDescriptionToMap = Interaction(
          originalViewName: '/new_view',
          viewName: 'newView',
          name: 'button',
          widgetType: WidgetType.touchable,
          position: WidgetPosition(
              x: 0, y: 0, capturedDeviceHeight: 0, capturedDeviceWidth: 0),
        );
        expect(_service.widgetDescriptionMap['/new_view']!.length, 1);
      });
      test(
          'When two WidgetDescription has the same viewName , Should add the second widget to the already added key from the first one ',
          () {
        final _service = _getService;

        _service.addWidgetDescriptionToMap = Interaction(
          originalViewName: '/new_view',
          viewName: 'newView',
          name: 'button',
          widgetType: WidgetType.touchable,
          position: WidgetPosition(
              x: 0, y: 0, capturedDeviceHeight: 0, capturedDeviceWidth: 0),
        );
        _service.addWidgetDescriptionToMap = Interaction(
          originalViewName: '/new_view',
          viewName: 'newView',
          name: 'inputField',
          widgetType: WidgetType.input,
          position: WidgetPosition(
              x: 0, y: 0, capturedDeviceHeight: 0, capturedDeviceWidth: 0),
        );
        expect(_service.widgetDescriptionMap['/new_view']!.length, 2);
      });
    });

    group('deleteWidgetDescription -', () {
      test(
          'When called, should call delete widget description from the CloudFunctionsService',
          () async {
        final description = Interaction(
          originalViewName: '/new_view',
          viewName: 'newView',
          name: 'email',
          position: WidgetPosition(
              x: 100, y: 199, capturedDeviceHeight: 0, capturedDeviceWidth: 0),
          widgetType: WidgetType.general,
        );

        final cloudFunctionsService = getAndRegisterCloudFunctionsService();
        final _service = _getService;

        await _service.removeWidgetDescription(
          description: description,
        );

        verify(cloudFunctionsService.deleteWidgetDescription(
            projectId: 'projectId', description: description));
      });

      test(
          'When called and result is successful, Should remove description from List of widget descriptions',
          () async {
        getAndRegisterCloudFunctionsService(
            getWidgetDescriptionForProjectResult: [
              Interaction(
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
              Interaction(
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
        final _service = _getService;

        await _service.removeWidgetDescription(
          description: Interaction(
            viewName: 'signUp',
            originalViewName: '/signUp_view',
            name: 'loginButton',
            widgetType: WidgetType.touchable,
            position: WidgetPosition(
                x: 0, y: 0, capturedDeviceHeight: 0, capturedDeviceWidth: 0),
          ),
        );

        expect(_service.widgetDescriptionMap.containsKey('signUp'), false);
      });
    });

    group('getDescriptionsForView -', () {
      test(
          'When called with route homeView, should return the widgets for homeView only',
          () async {
        getAndRegisterCloudFunctionsService(
            getWidgetDescriptionForProjectResult: [
              Interaction(
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
              Interaction(
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
        final _service = _getService;

        await _service.loadWidgetDescriptionsForProject();

        final result =
            _service.getDescriptionsForView(currentRoute: '/home_view');
        expect(result.length, 2);
      });

      test(
          'When called with route homeView0, should return the widgets for homeView + homeView0',
          () async {
        getAndRegisterCloudFunctionsService(
            getWidgetDescriptionForProjectResult: [
              Interaction(
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
              Interaction(
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
              Interaction(
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
              Interaction(
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
        final _service = _getService;

        await _service.loadWidgetDescriptionsForProject();

        final result =
            _service.getDescriptionsForView(currentRoute: '/home_view0');
        expect(result.length, 3);
      });

      test(
          'When called with route homeView1, should return the widgets for homeView + homeView0',
          () async {
        getAndRegisterCloudFunctionsService(
            getWidgetDescriptionForProjectResult: [
              Interaction(
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
              Interaction(
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
              Interaction(
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
              Interaction(
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
              Interaction(
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
        final _service = _getService;

        await _service.loadWidgetDescriptionsForProject();

        final result =
            _service.getDescriptionsForView(currentRoute: '/home_view1');
        expect(result.length, 4);
      });
    });

    group('updateWidgetDescription -', () {
      test(
          'When called, should call update widget description from the CloudFunctionsService',
          () async {
        final description = Interaction(
          viewName: 'login',
          originalViewName: '/login_view',
          name: 'email',
          position: WidgetPosition(
              x: 100, y: 199, capturedDeviceHeight: 0, capturedDeviceWidth: 0),
          widgetType: WidgetType.general,
        );

        final cloudFunctionsService = getAndRegisterCloudFunctionsService();
        final _service = _getService;

        _service.addWidgetDescriptionToMap = description;
        await _service.updateInteractionInDatabase(description);

        verify(cloudFunctionsService.updateWidgetDescription(
            projectId: 'projectId',
            oldwidgetDescription: description,
            newwidgetDescription: description));
      });

      test(
          'When called and result is successful, Should update description from List of widget descriptions',
          () async {
        getAndRegisterCloudFunctionsService(
            getWidgetDescriptionForProjectResult: [
              kGeneralInteraction,
              kViewInteraction
            ]);
        final _service = _getService;

        // load the project keys first
        await _service.loadWidgetDescriptionsForProject();

        // update [kWidgetDescription] key
        await _service.updateInteractionInDatabase(
            kGeneralInteraction.copyWith(name: 'login22'));

        expect(_service.widgetDescriptionMap['/']!.first.name,
            kGeneralInteraction.name);
      });
    });
    group('syncRouteInteractions -', () {
      const routeName = 'routeName';
      test('''
When called with a new route, Add the new route
with its interactions to widgetDescriptionMap''', () {
        final _service = _getService;

        _service.syncRouteInteractions(
            routeName, [kGeneralInteraction, kViewInteraction]);

        expect(_service.widgetDescriptionMap, {
          routeName: [kGeneralInteraction, kViewInteraction]
        });
      });
      test('''
When called with existing route, Should override the route interactions
with the new ones ''', () {
        final _service = _getService;

        _service.widgetDescriptionMap.addAll({
          routeName: [kGeneralInteractionWithZeroOffset]
        });
        _service.syncRouteInteractions(
            routeName, [kGeneralInteraction, kViewInteraction]);

        expect(_service.widgetDescriptionMap, {
          routeName: [kGeneralInteraction, kViewInteraction]
        });
      });
    });
  });
}
