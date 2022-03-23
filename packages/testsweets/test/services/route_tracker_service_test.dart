import 'package:flutter_test/flutter_test.dart';
import 'package:testsweets/src/services/testsweets_route_tracker.dart';

import '../helpers/test_helpers.dart';

final testSweetsRouteTrackerService = TestSweetsRouteTracker();
void main() {
  group('RouteTrackerServiceTest -', () {
    setUp(() {
      registerServices();
      testSweetsRouteTrackerService.setCurrentRoute('currentRoute');
      testSweetsRouteTrackerService.setparentRoute('parentRoute');
    });
    tearDown(unregisterServices);
    testSweetsRouteTrackerService.testMode = true;

    group('toggleActivatedRouteBetweenParentAndChild -', () {
      test(
          'When called with tempRoute is empty(child is active), Should store the current route inside the tempRoute and replace the currentRoute with the parentRoute',
          () {
        testSweetsRouteTrackerService
            .toggleActivatedRouteBetweenParentAndChild();
        expect(testSweetsRouteTrackerService.currentRoute, 'parentRoute');
        expect(testSweetsRouteTrackerService.parentRoute, '');
        expect(testSweetsRouteTrackerService.isChildRouteActivated, false);
      });
      test(
          'When called  with tempRoute is not empty(parent is active), Should store the current route inside the tempRoute and replace the currentRoute with the parentRoute',
          () {
        testSweetsRouteTrackerService
            .toggleActivatedRouteBetweenParentAndChild();

        /// the only way to set the tempRoute is to call it twice
        testSweetsRouteTrackerService
            .toggleActivatedRouteBetweenParentAndChild();
        expect(testSweetsRouteTrackerService.currentRoute, 'currentRoute');
        expect(testSweetsRouteTrackerService.parentRoute, 'parentRoute');
        expect(testSweetsRouteTrackerService.isChildRouteActivated, true);
      });
    });
    group('setCurrentRoute -', () {
      test(
          'When called, Should set the current route and clear the child route',
          () {
        testSweetsRouteTrackerService.setCurrentRoute('currentRoute');
        expect(testSweetsRouteTrackerService.currentRoute, 'currentRoute');
        expect(testSweetsRouteTrackerService.parentRoute, '');
      });
    });
    group('isChildRouteActivated -', () {
      test('When tempRoute is not empty, Should be true', () {
        testSweetsRouteTrackerService
            .toggleActivatedRouteBetweenParentAndChild();
        expect(testSweetsRouteTrackerService.isChildRouteActivated, false);
      });
    });
    group('rightViewName -', () {
      test(
          'When isChildRouteActivated is true(child is active), rightViewName should be the currentRoute',
          () {
        expect(testSweetsRouteTrackerService.rightViewName, 'currentRoute');
        expect(testSweetsRouteTrackerService.isChildRouteActivated, true);
      });
      test(
          'When isChildRouteActivated is false(parent is active),  rightViewName should be also the tempRoute(which is the currentRoute)',
          () {
        testSweetsRouteTrackerService
            .toggleActivatedRouteBetweenParentAndChild();
        expect(testSweetsRouteTrackerService.rightViewName, 'currentRoute');
        expect(testSweetsRouteTrackerService.isChildRouteActivated, false);
      });
    });
    group('leftViewName -', () {
      test('When isNestedView is true, parentRoute should be the rightViewName',
          () {
        expect(testSweetsRouteTrackerService.leftViewName, 'parentRoute');
      });
    });

    group('changeRouteIndex -', () {
      test('''When called, Should set the current route and set the ''', () {
        testSweetsRouteTrackerService.changeRouteIndex('viewName', 1);
        expect(testSweetsRouteTrackerService.currentRoute, 'viewName1');
        expect(testSweetsRouteTrackerService.parentRoute, 'viewName');
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
