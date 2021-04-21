import 'package:mocktail/mocktail.dart';
import '../bin/src/locator.dart';
import '../bin/src/services/file_system_service.dart';
import '../bin/src/services/runnable_process.dart';
import '../bin/src/services/http_service.dart';
import '../bin/src/services/time_service.dart';
import '../bin/src/services/cloud_functions_service.dart';

class MockFileSystemService extends Mock implements FileSystemService {}

class MockFlutterProcess extends Mock implements FlutterProcess {}

class MockHttpService extends Mock implements HttpService {}

class MockTimeService extends Mock implements TimeService {}

class MockCloudFunctionsService extends Mock implements CloudFunctionsService {}

void setUpLocatorForTesting() {
  locator
      .registerLazySingleton<FileSystemService>(() => MockFileSystemService());
  locator.registerLazySingleton<FlutterProcess>(() => MockFlutterProcess());
  locator.registerLazySingleton<HttpService>(() => MockHttpService());
  locator.registerLazySingleton<TimeService>(() => MockTimeService());
  locator.registerLazySingleton<CloudFunctionsService>(
      () => MockCloudFunctionsService());
}
