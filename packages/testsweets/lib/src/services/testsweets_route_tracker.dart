import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testsweets/src/app/app.logger.dart';
import 'package:testsweets/src/extensions/string_extension.dart';

class TestSweetsRouteTracker extends ChangeNotifier {
  final log = getLogger('TestSweetsRouteTracker');

  static TestSweetsRouteTracker? _instance;
  static TestSweetsRouteTracker get instance {
    if (_instance == null) {
      _instance = TestSweetsRouteTracker();
    }
    return _instance!;
  }

  bool get isChildRouteActivated => _tempRoute.isEmpty;
  bool get isNestedView => _tempRoute.isNotEmpty || _parentRoute.isNotEmpty;

  String _currentRoute = '';
  String get currentRoute => _currentRoute;
  String get formatedCurrentRoute => _currentRoute.convertViewNameToValidFormat;

  String _parentRoute = '';
  String get parentRoute => _parentRoute;
  String get formatedParentRoute =>
      _parentRoute.isNotEmpty ? _parentRoute.convertViewNameToValidFormat : '';

  String _tempRoute = '';
  String get formatedTempRoute =>
      _tempRoute.isNotEmpty ? _tempRoute.convertViewNameToValidFormat : '';

  String get leftViewName => isNestedView
      ? isChildRouteActivated
          ? formatedParentRoute
          : formatedCurrentRoute
      : '';
  String get rightViewName => isChildRouteActivated
      ? formatedCurrentRoute
      : _tempRoute.convertViewNameToValidFormat;
  void setCurrentRoute(String route) {
    log.i('setCurrentRoute | route: $route');
    _parentRoute = '';
    _tempRoute = '';
    _currentRoute = route;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void setparentRoute(String route) {
    log.i('setparentRoute | parentRoute: $route');
    _parentRoute = route;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void toggleActivatedRouteBetweenParentAndChild() {
    if (_tempRoute.isEmpty) {
      _tempRoute = _currentRoute;
      _currentRoute = _parentRoute;
      _parentRoute = '';
    } else {
      _parentRoute = _currentRoute;
      _currentRoute = _tempRoute;
      _tempRoute = '';
    }
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      notifyListeners();
    });
    log.v(
        'tempRoute: $_tempRoute | currentRoute: $_currentRoute | parentRoute: $_parentRoute');
  }
}
