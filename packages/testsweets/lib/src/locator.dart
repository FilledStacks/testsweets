import 'package:get_it/get_it.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:testsweets/src/services/cloud_functions_service.dart';
import 'package:testsweets/src/services/http_service.dart';
import 'package:testsweets/src/services/reactive_interaction.dart';
import 'package:testsweets/src/services/testsweets_route_tracker.dart';
import 'package:testsweets/src/services/widget_capture_service.dart';
import 'package:testsweets/src/setup_snackbar_ui.dart';
import 'package:testsweets/src/services/widget_visibilty_changer_service.dart';

GetIt locator = GetIt.asNewInstance();
bool locatorSetup = false;
Future<void> setupLocator() async {
  locator.registerLazySingleton(() => CloudFunctionsService(
        httpService: HttpServiceImplementation(),
      ));
  locator.registerLazySingleton(() => TestSweetsRouteTracker());
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerLazySingleton(() => WidgetCaptureService(verbose: true));
  locator.registerLazySingleton(() => WidgetVisibiltyChangerService());
  locator
      .registerLazySingleton<ReactiveInteraction>(() => ReactiveScrollable());
  setupSnackbarUi();

  locatorSetup = true;
}
