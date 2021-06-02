import 'dart:io';

import 'package:get_it/get_it.dart';
import 'services/build_service.dart';
import 'services/dynamic_keys_generator_service.dart';
import 'services/file_system_service.dart';
import 'services/runnable_process.dart';
import 'services/http_service.dart';
import 'services/time_service.dart';
import 'services/cloud_functions_service.dart';
import 'services/upload_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator
      .registerLazySingleton<BuildService>(() => BuildService.makeInstance());
  locator.registerLazySingleton<FlutterProcess>(
      () => FlutterProcess(Platform.isWindows ? 'flutter.bat' : 'flutter'));
  locator.registerLazySingleton<FileSystemService>(
      () => FileSystemService.makeInstance());

  locator.registerLazySingleton<HttpService>(() => HttpService.makeInstance());
  locator.registerLazySingleton<TimeService>(() => TimeService());
  locator.registerLazySingleton<CloudFunctionsService>(
      () => CloudFunctionsService.makeInstance());
  locator
      .registerLazySingleton<UploadService>(() => UploadService.makeInstance());
  locator
      .registerLazySingleton(() => DynamicKeysGeneratorService.makeInstance());
}
