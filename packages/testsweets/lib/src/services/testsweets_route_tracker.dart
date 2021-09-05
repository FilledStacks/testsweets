import 'package:flutter/cupertino.dart';

class TestSweetsRouteTracker extends ChangeNotifier {
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
    print('setCurrentRoute | route$route');
    _currentRoute = route;
    notifyListeners();
  }
}
