import 'package:flutter/material.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/services/testsweets_route_tracker.dart';

class TestSweetsNavigatorObserver extends NavigatorObserver {
  final routeTracker = locator<TestSweetsRouteTracker>();

  @override
  void didPop(Route route, Route? previousRoute) {
    routeTracker.setCurrentRoute(_getRouteName(previousRoute));
    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    routeTracker.setCurrentRoute(_getRouteName(previousRoute));
    super.didRemove(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    routeTracker.setCurrentRoute(_getRouteName(route));
    super.didPush(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    routeTracker.setCurrentRoute(_getRouteName(newRoute));
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  void setBottomNavIndex({required int index, required String btmNavBarName}) {
    routeTracker.setCurrentRoute(btmNavBarName + index.toString());
  }

  String _getRouteName(Route? route) {
    return route?.settings.name ?? 'NoView';
  }
}
