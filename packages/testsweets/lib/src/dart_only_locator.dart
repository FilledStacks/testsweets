import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:testsweets/src/services/dynamic_keys_generator.dart';
import 'package:testsweets/src/services/file_system_service.dart';
import 'package:testsweets/src/services/old_http_service.dart';
import 'package:testsweets/src/services/runnable_process.dart';
import 'package:testsweets/src/services/test_sweets_config_file_service.dart';
import 'package:testsweets/src/services/time_service.dart';

import 'services/automation_keys_service.dart';
import 'services/build_service.dart';
import 'services/cloud_functions_service.dart';
import 'services/upload_service.dart';

GetIt dartOnlyLocator = GetIt.asNewInstance();
bool dartOnlyLocatorSetup = false;
Future<void> setupDartOnlyLocator() async {
  dartOnlyLocator.registerLazySingleton<TestSweetsConfigFileService>(
      () => TestSweetsConfigFileService());

  dartOnlyLocator.registerLazySingleton<AutomationKeysService>(
      () => AutomationKeysServiceImplementation());

  dartOnlyLocator.registerLazySingleton<OldHttpService>(
      () => OldHttpServiceImplementation());

  dartOnlyLocator.registerLazySingleton<FileSystemService>(
      () => FileSystemServiceImplementation());

  dartOnlyLocator.registerLazySingleton(() => DynamicKeysGenerator());

  dartOnlyLocator
      .registerLazySingleton<CloudFunctionsService>(() => CloudFunctionsService(
            httpService: OldHttpServiceImplementation(),
          ));

  dartOnlyLocator.registerLazySingleton(() => TimeService());

  dartOnlyLocator.registerLazySingleton<UploadService>(
      () => UploadServiceImplementation());

  dartOnlyLocator.registerLazySingleton<FlutterProcess>(
      () => FlutterProcess(Platform.isWindows ? 'flutter.bat' : 'flutter'));

  dartOnlyLocator
      .registerLazySingleton<BuildService>(() => BuildServiceImplementation());

  dartOnlyLocatorSetup = true;
}
