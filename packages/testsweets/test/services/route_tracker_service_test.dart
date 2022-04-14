import 'package:flutter_test/flutter_test.dart';
import 'package:testsweets/src/services/testsweets_route_tracker.dart';

import '../helpers/test_helpers.dart';

final testSweetsRouteTrackerService = TestSweetsRouteTracker();
void main() {
  group('RouteTrackerServiceTest -', () {
    setUp(() {
      registerServices();
      testSweetsRouteTrackerService.setCurrentRoute('currentRoute');
    });
    tearDown(unregisterServices);
    testSweetsRouteTrackerService.testMode = true;

    group('setCurrentRoute -', () {
      test(
          'When called, Should set the current route and clear the child route',
          () {
        testSweetsRouteTrackerService.setCurrentRoute('currentRoute');
        expect(testSweetsRouteTrackerService.currentRoute, 'currentRoute');
      });
    });

    group('changeRouteIndex -', () {
      test('''When called, Should set the current route and set the ''', () {
        testSweetsRouteTrackerService.changeRouteIndex('viewName', 1);
        expect(testSweetsRouteTrackerService.currentRoute, 'viewName1');
        expect(testSweetsRouteTrackerService.indexedRouteStateMap,
            {'viewName': 1});
      });
    });
    group('saveRouteIndex -', () {
      test('''
              When we set route index, Should save it to a map where key is parentViewName
              and value is the last setted index 
          ''', () {
        testSweetsRouteTrackerService.saveRouteIndex('viewName', 2);
        expect(
            testSweetsRouteTrackerService.indexedRouteStateMap['viewName'], 2);
      });
    });
    group('loadRouteIndexIfExist -', () {
      test(
          'When called, Should check for history of this current route and load it',
          () {
        testSweetsRouteTrackerService.saveRouteIndex('viewName', 2);
        testSweetsRouteTrackerService.setCurrentRoute('viewName');
        expect(testSweetsRouteTrackerService.currentRoute, 'viewName2');
      });
    });
  });
}
