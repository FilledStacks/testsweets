import 'package:get_it/get_it.dart';
import 'package:testsweets/src/services/build_service.dart';
import 'package:testsweets/src/services/file_system_service.dart';
import 'package:testsweets/src/services/runnable_process.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator
      .registerLazySingleton<BuildService>(() => BuildService.makeInstance());
  locator
      .registerLazySingleton<FlutterProcess>(() => FlutterProcess('flutter'));
  locator.registerLazySingleton<FileSystemService>(
      () => FileSystemService.makeInstance());
}
