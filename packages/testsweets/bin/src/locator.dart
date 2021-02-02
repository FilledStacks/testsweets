import 'dart:io';

import 'package:get_it/get_it.dart';
import 'services/build_service.dart';
import 'services/file_system_service.dart';
import 'services/runnable_process.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator
      .registerLazySingleton<BuildService>(() => BuildService.makeInstance());
  locator.registerLazySingleton<FlutterProcess>(
      () => FlutterProcess(Platform.isWindows ? 'flutter.bat' : 'flutter'));
  locator.registerLazySingleton<FileSystemService>(
      () => FileSystemService.makeInstance());
}
