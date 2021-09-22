import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testsweets/src/app/app.logger.dart';

class TestSweetsRouteTracker extends ChangeNotifier {
  final log = getLogger('TestSweetsRouteTracker');

  static TestSweetsRouteTracker? _instance;
  static TestSweetsRouteTracker get instance {
    if (_instance == null) {
      _instance = TestSweetsRouteTracker();
    }
    return _instance!;
  }

  String _currentRoute = '';
  String get currentRoute => _currentRoute;

  void setCurrentRoute(String route) {
    log.i('setCurrentRoute | route: $route');
    _currentRoute = route;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
}
