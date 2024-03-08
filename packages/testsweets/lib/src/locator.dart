import 'package:get_it/get_it.dart';
import 'package:testsweets/src/services/cloud_functions_service.dart';
import 'package:testsweets/src/services/events_service.dart';
import 'package:testsweets/src/services/http_service.dart';
import 'package:testsweets/src/services/local_config_service.dart';
import 'package:testsweets/src/services/notification_extractor.dart';
import 'package:testsweets/src/services/reactive_scrollable.dart';
import 'package:testsweets/src/services/run_configuration_service.dart';
import 'package:testsweets/src/services/scroll_appliance.dart';
import 'package:testsweets/src/services/snackbar_service.dart';
import 'package:testsweets/src/services/test_integrity.dart';
import 'package:testsweets/src/services/testsweets_route_tracker.dart';
import 'package:testsweets/src/services/widget_capture_service.dart';
import 'package:testsweets/src/ui/shared/scrollable_finder.dart';

import 'services/old_http_service.dart';

GetIt locator = GetIt.asNewInstance();

bool locatorSetup = false;

Future<void> setupLocator() async {
  final localConfigService = LocalConfigService();
  await localConfigService.init();
  locator.registerSingleton(localConfigService);

  locator.registerLazySingleton(() => CloudFunctionsService(
        httpService: OldHttpServiceImplementation(),
      ));
  locator.registerLazySingleton(() => TestSweetsRouteTracker());
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerLazySingleton(() => WidgetCaptureService());
  locator.registerLazySingleton(() => ReactiveScrollable());
  locator.registerLazySingleton(() => ScrollAppliance());
  locator.registerLazySingleton(() => ScrollableFinder());
  locator.registerLazySingleton(() => NotificationExtractor());
  locator.registerLazySingleton(() => HttpService());

  locator.registerLazySingleton(() => TestIntegrity());
  locator.registerLazySingleton(() => EventsService());
  locator.registerLazySingleton(() => RunConfigurationService());

  locatorSetup = true;
}
