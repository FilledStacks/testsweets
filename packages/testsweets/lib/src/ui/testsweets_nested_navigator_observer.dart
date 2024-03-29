import 'package:flutter/material.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/services/local_config_service.dart';
import 'package:testsweets/src/services/testsweets_route_tracker.dart';

class TestSweetsNestedNavigatorObserver extends NavigatorObserver {
  final _localConfigService = locator<LocalConfigService>();
  final _routeTracker = locator<TestSweetsRouteTracker>();

  /// Used with multiple navigators to indicate which navigator
  /// is performig navigations at this point.
  final String? source;

  final bool verbose;

  final int level;

  TestSweetsNestedNavigatorObserver({
    this.source,
    this.level = 1,
    this.verbose = false,
  });

  static final TestSweetsNestedNavigatorObserver _instance =
      TestSweetsNestedNavigatorObserver._internal(source: 'root');

  TestSweetsNestedNavigatorObserver._internal({
    this.source,
  })  : level = 1,
        verbose = false;

  static TestSweetsNestedNavigatorObserver get instance => _instance;

  @override
  void didPop(Route route, Route? previousRoute) {
    if (!_localConfigService.enabled) return;

    _routeTracker.setCurrentRoute(
      _getRouteName(
        previousRoute,
        callingFunction: 'didPop',
      ),
      level: level,
    );

    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    if (!_localConfigService.enabled) return;

    _routeTracker.setCurrentRoute(
      _getRouteName(route, callingFunction: 'didPush'),
      level: level,
    );

    super.didPush(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    if (!_localConfigService.enabled) return;

    _routeTracker.setCurrentRoute(
      _getRouteName(newRoute, callingFunction: 'didReplace'),
      level: level,
    );

    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  /// Creates a unique name for each bottom nav tab to ensure widgets are captured
  /// as if each tab is a new view
  void setBottomNavIndex({
    required int index,
    required String viewName,
  }) {
    if (!_localConfigService.enabled) return;

    _routeTracker.changeRouteIndex(viewName, index);
  }

  String _getRouteName(Route? route, {required String callingFunction}) {
    if (!_localConfigService.enabled) return 'NoView';

    final routeName = route?.settings.name;
    // print('🚂 ${source ?? ''} - $callingFunction - routeName: $routeName');
    return routeName ?? 'NoView';
  }
}
