import 'package:flutter/cupertino.dart';

/// Keeps track of the current that is active
class TestSweetsRouteTracker extends ChangeNotifier {
  String _currentRoute = '';
  String get currentRoute => _currentRoute;

  void setCurrentRoute(String route) {
    print('setCurrentRoute | route$route');
    _currentRoute = route;
    notifyListeners();
  }
}
