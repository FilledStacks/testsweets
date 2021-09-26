import 'package:example/app/app.locator.dart';
import 'package:example/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  
  void navigateToOtherView() {
    _navigationService.navigateTo(Routes.mainView);

  }
}
