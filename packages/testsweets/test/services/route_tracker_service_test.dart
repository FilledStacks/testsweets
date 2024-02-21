import 'package:flutter_test/flutter_test.dart';
import 'package:testsweets/src/services/testsweets_route_tracker.dart';

import '../helpers/test_helpers.dart';

TestSweetsRouteTracker get _service => TestSweetsRouteTracker();
void main() {
  group('RouteTrackerServiceTest -', () {
    setUp(() {
      registerServices();
    });
    tearDown(unregisterServices);

    group('setRoute -', () {
      test('When called, should set the current route', () {
        final service = _service;
        service.setRoute('currentRoute');
        expect(service.currentRoute, 'currentRoute');
      });

      test(
          'When called, Should set the current route and change previous route to the previous call',
          () {
        final service = _service;
        service.setRoute('currentRoute');
        service.setRoute('currentRoute2');

        expect(service.currentRoute, 'currentRoute2');
        expect(service.previosRoute, 'currentRoute');
      });

      test(
          'When called with level=1, should append the new route onto the previous route',
          () {
        final service = _service;
        service.setRoute('currentRoute');
        service.setRoute('nestedRoute', level: 1);

        expect(
          service.currentRoute,
          'currentRoute/nestedRoute',
        );
      });

      test(
          'When called twice with level=1, should change the route after / to the new route',
          () {
        final service = _service;
        service.setRoute('currentRoute');
        service.setRoute('nestedRoute', level: 1);
        service.setRoute('nestedRoute2', level: 1);

        expect(
          service.currentRoute,
          'currentRoute/nestedRoute2',
        );
      });

      test(
          'When called with level 1, then level 0, should clear everything after level 0',
          () {
        final service = _service;
        service.setRoute('currentRoute');
        service.setRoute('nestedRoute', level: 1);
        service.setRoute('newRootRoute');

        expect(
          service.currentRoute,
          'newRootRoute',
        );
      });

      test(
          'When called with level 0,1,2, then 1, should clear everything after level 1',
          () {
        final service = _service;
        service.setRoute('currentRoute');
        service.setRoute('nestedRoute', level: 1);
        service.setRoute('doubleNestedRoute', level: 2);
        service.setRoute('newNestedRoute', level: 1);

        expect(
          service.currentRoute,
          'currentRoute/newNestedRoute',
        );
      });
    });

    group('changeRouteIndex -', () {
      test('When called, should append the index onto the matching route name',
          () {
        final service = _service;
        service.setRoute('currentRoute');
        service.changeRouteIndex('currentRoute', 1);
        expect(service.currentRoute, 'currentRoute1');
      });

      test(
          'When called and we have nested a route, should append the index onto the matching nested route',
          () {
        final service = _service;
        service.setRoute('currentRoute');
        service.setRoute('nestedRoute', level: 1);
        service.changeRouteIndex('nestedRoute', 1);
        expect(service.currentRoute, 'currentRoute/nestedRoute1');
      });

      test(
          'When called and route already has an index, should only swap out the index and keep the route',
          () {
        final service = _service;
        service.setRoute('currentRoute1');
        service.changeRouteIndex('currentRoute', 2);
        expect(service.currentRoute, 'currentRoute2');
      });

      test(
          'When called and nested route already has an index, should only swap out the index and keep the route',
          () {
        final service = _service;
        service.setRoute('root');
        service.setRoute('nestedRoute1', level: 1);
        service.changeRouteIndex('nestedRoute', 2);
        expect(service.currentRoute, 'root/nestedRoute2');
      });
    });
  });
}
