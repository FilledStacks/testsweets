import 'package:flutter/material.dart';
import 'package:testsweets/src/app/logger.dart';
import 'package:testsweets/src/extensions/string_extension.dart';

class TestSweetsRouteTracker extends ChangeNotifier {
  final log = getLogger('TestSweetsRouteTracker');

  @visibleForTesting
  bool testMode = false;
  @visibleForTesting
  Map<String, int> indexedRouteStateMap = {};

  static TestSweetsRouteTracker? _instance;

  static TestSweetsRouteTracker get instance {
    if (_instance == null) {
      _instance = TestSweetsRouteTracker();
    }
    return _instance!;
  }

  String previosRoute = '';
  String _currentRoute = '';
  String get currentRoute => _currentRoute;
  String get formatedCurrentRoute => _currentRoute.isNotEmpty
      ? _currentRoute.convertViewNameToValidFormat
      : '';

  void setCurrentRoute(String route) {
    log.i('route: $_currentRoute | previousRoute: $previosRoute');

    if (testMode) {
      setRoute(route);
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setRoute(route);
      notifyListeners();
    });
  }

  void setRoute(String route) {
    previosRoute = _currentRoute;
    _currentRoute = route;
    loadRouteIndexIfExist(route);
  }

  void changeRouteIndex(String viewName, int index) {
    setCurrentRoute(viewName + index.toString());
    saveRouteIndex(viewName, index);
  }

  void saveRouteIndex(String viewName, int index) {
    indexedRouteStateMap[viewName] = index;
  }

  void loadRouteIndexIfExist(String viewName) {
    if (indexedRouteStateMap.containsKey(viewName)) {
      _currentRoute = viewName + indexedRouteStateMap[viewName].toString();
    }
  }
}
