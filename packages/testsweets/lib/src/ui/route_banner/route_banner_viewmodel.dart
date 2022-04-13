import 'package:stacked/stacked.dart';
import 'package:testsweets/src/locator.dart';

import '../../services/testsweets_route_tracker.dart';

class RouteBannerViewmodel extends BaseViewModel {
  final _testSweetsRouteTracker = locator<TestSweetsRouteTracker>();
  RouteBannerViewmodel() {
    _testSweetsRouteTracker.addListener(notifyListeners);
  }
  String get currentViewName => _testSweetsRouteTracker.formatedCurrentRoute;
}
