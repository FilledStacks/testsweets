import 'package:example/ui/home/home_view.dart';
import 'package:example/ui/home/signup_view.dart';
import 'package:example/ui/login/login_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(
      page: SignUpView,
      initial: true,
    ),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: HomeView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
  ],
  logger: StackedLogger(),
)
class App {}
