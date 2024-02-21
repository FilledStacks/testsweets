import 'dart:io';

import 'package:flutter/material.dart';
import 'package:testsweets/src/app/logger.dart';
import 'package:testsweets/src/extensions/string_extension.dart';

class TestSweetsRouteTracker extends ChangeNotifier {
  final log = getLogger('TestSweetsRouteTracker');

  List<String> _routeSegments = List<String>.filled(10, '');

  String get _joinedRoutePath =>
      _routeSegments.where((element) => element.isNotEmpty).join('/');

  static TestSweetsRouteTracker? _instance;

  static TestSweetsRouteTracker get instance {
    if (_instance == null) {
      _instance = TestSweetsRouteTracker();
    }
    return _instance!;
  }

  String previosRoute = '';
  int _previousLevel = 0;

  String get currentRoute => _joinedRoutePath;

  String get formatedCurrentRoute => _joinedRoutePath.isNotEmpty
      ? _joinedRoutePath.convertViewNameToValidFormat
      : '';

  final _isTest = Platform.environment.containsKey('FLUTTER_TEST');

  void setCurrentRoute(String route, {int level = 0}) {
    if (_isTest) {
      setRoute(route, level: level);
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setRoute(route, level: level);
      notifyListeners();
    });
  }

  void setRoute(String route, {int level = 0}) {
    previosRoute = _joinedRoutePath;

    final clearAllNestedRoutesAfterCurrentLevel = _previousLevel > level;

    if (clearAllNestedRoutesAfterCurrentLevel) {
      for (var i = level++; i < _routeSegments.length; i++) {
        _routeSegments[i] = '';
      }
    }

    _routeSegments[level] = route;

    _previousLevel = level;
  }

  void changeRouteIndex(String viewName, int index) {
    final hasViewNameInSegments =
        _routeSegments.any((element) => element.contains(viewName));

    if (!hasViewNameInSegments) {
      print('''
TESTSWEETS NAVIGATION WARNING:

The viewName you provided for the bottom nav index tracking is not found in
the current navigation stack. 

Here's some more technical details:

viewName: $viewName
currentStack: $_joinedRoutePath

The viewName has to be in the stack otherwise it'll count as a completely
new navigation. 

If you need some help join the discord: https://discord.gg/xAJP6g3tRR
''');

      return;
    }

    final matchingSegment =
        _routeSegments.firstWhere((element) => element.contains(viewName));

    final levelOfMatchingElement = _routeSegments.indexOf(matchingSegment);

    setCurrentRoute('$viewName$index', level: levelOfMatchingElement);
  }
}
