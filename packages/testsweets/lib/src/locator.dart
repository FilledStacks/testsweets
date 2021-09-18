import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:testsweets/src/services/test_sweets_config_file_service.dart';
import 'package:testsweets/src/services/testsweets_route_tracker.dart';
import 'package:testsweets/src/services/validate_widget_description.dart';
import 'package:testsweets/src/services/widget_capture_service.dart';

import 'services/automation_keys_service.dart';
import 'services/build_service.dart';
import 'services/cloud_functions_service.dart';
import 'services/dynamic_keys_generator.dart';
import 'services/file_system_service.dart';
import 'services/http_service.dart';
import 'services/runnable_process.dart';
import 'services/time_service.dart';
import 'services/upload_service.dart';

GetIt locator = GetIt.asNewInstance();
bool locatorSetup = false;
Future<void> setupLocator() async {
  locator
      .registerLazySingleton<BuildService>(() => BuildServiceImplementation());
  locator.registerLazySingleton<FlutterProcess>(
      () => FlutterProcess(Platform.isWindows ? 'flutter.bat' : 'flutter'));
  locator.registerLazySingleton<FileSystemService>(
      () => FileSystemServiceImplementation());

  locator.registerLazySingleton<HttpService>(() => HttpServiceImplementation());
  locator.registerLazySingleton<TimeService>(() => TimeService());
  locator.registerLazySingleton<CloudFunctionsService>(
      () => CloudFunctionsService());
  locator.registerLazySingleton<UploadService>(
      () => UploadServiceImplementation());
  locator.registerLazySingleton(() => DynamicKeysGenerator());

  locator.registerLazySingleton<TestSweetsConfigFileService>(
      () => TestSweetsConfigFileService());

  locator.registerLazySingleton<AutomationKeysService>(
      () => AutomationKeysServiceImplementation());

  locator.registerLazySingleton(() => TestSweetsRouteTracker());
  locator.registerLazySingleton(() => WidgetCaptureService(verbose: true));
  locator.registerLazySingleton<ValidateWidgetDescription>(
      () => ValidateWidgetDescriptionName());

  locatorSetup = true;
}
