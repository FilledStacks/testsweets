import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/services/cloud_functions_service.dart';
import 'package:testsweets/src/services/dynamic_keys_generator_service.dart';
import 'package:testsweets/src/services/file_system_service.dart';
import 'package:testsweets/src/services/http_service.dart';
import 'package:testsweets/src/services/runnable_process.dart';
import 'package:testsweets/src/services/time_service.dart';

import '../build_service_test.dart';
import 'test_helpers.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<FileSystemService>(returnNullOnMissingStub: true),
  MockSpec<FlutterProcess>(returnNullOnMissingStub: true),
  MockSpec<HttpService>(returnNullOnMissingStub: true),
  MockSpec<TimeService>(returnNullOnMissingStub: true),
  MockSpec<CloudFunctionsService>(returnNullOnMissingStub: true),
  MockSpec<DynamicKeysGeneratorService>(returnNullOnMissingStub: true),
])
MockFileSystemService getAndRegisterFileSystemService({
  bool doesFileExist = false,
  String readFileAsStringSyncResult = ksAppAutomationKeysFile,
}) {
  _removeRegistrationIfExists<FileSystemService>();
  final service = MockFileSystemService();

  when(service.doesFileExist(any)).thenReturn(doesFileExist);

  when(service.readFileAsStringSync(any))
      .thenReturn(readFileAsStringSyncResult);

  locator.registerSingleton<FileSystemService>(service);
  return service;
}

MockFlutterProcess getAndRegisterFlutterProcess() {
  _removeRegistrationIfExists<FlutterProcess>();
  final service = MockFlutterProcess();
  when(service.startWith(args: anyNamed('args'))).thenAnswer((_) {
    return Future.value(StubbedProcess(
        sExitCode: 0,
        sStdErr: '',
        sStdOut: 'build\\app\\outputs\\flutter-apk\\abc.apk'));
  });

  locator.registerSingleton<FlutterProcess>(service);
  return service;
}

MockDynamicKeysGeneratorService getAndRegisterDynamicKeysGeneratorService(
    {List<Map<String, String>> generateAutomationKeysFromDynamicKeysFileResult =
        const [
      {
        "name": "orders",
        "type": "touchable",
        "view": "ready",
      }
    ]}) {
  _removeRegistrationIfExists<DynamicKeysGeneratorService>();
  final service = MockDynamicKeysGeneratorService();

  when(service.generateAutomationKeysFromDynamicKeysFile(any)).thenReturn(
    generateAutomationKeysFromDynamicKeysFileResult,
  );

  locator.registerSingleton<DynamicKeysGeneratorService>(service);
  return service;
}

MockHttpService getAndRegisterHttpService() {
  _removeRegistrationIfExists<HttpService>();
  final service = MockHttpService();

  when(service.putBinary(
    to: anyNamed('to'),
    data: anyNamed('data'),
    headers: anyNamed('headers'),
    contentLength: anyNamed('contentLength'),
  )).thenAnswer((_) async => SimpleHttpResponse(200, ''));

  locator.registerSingleton<HttpService>(service);
  return service;
}

MockTimeService getAndRegisterTimeService() {
  _removeRegistrationIfExists<TimeService>();
  final service = MockTimeService();
  locator.registerSingleton<TimeService>(service);
  return service;
}

MockCloudFunctionsService getAndRegisterCloudFunctionsService(
    {String getV4BuildUploadSignedUrlResult = '',
    bool doesBuildExistInProjectResult = true}) {
  _removeRegistrationIfExists<CloudFunctionsService>();
  final service = MockCloudFunctionsService();
  when(service.getV4BuildUploadSignedUrl(
    any,
    any,
    any,
  )).thenAnswer((_) async => getV4BuildUploadSignedUrlResult);

  when(service.doesBuildExistInProject(any,
          withVersion: anyNamed('withVersion')))
      .thenAnswer((invocation) async => doesBuildExistInProjectResult);

  locator.registerSingleton<CloudFunctionsService>(service);
  return service;
}

void registerServices() {
  getAndRegisterFileSystemService();
  getAndRegisterFlutterProcess();
  getAndRegisterHttpService();
  getAndRegisterTimeService();
  getAndRegisterCloudFunctionsService();
  getAndRegisterDynamicKeysGeneratorService();
}

// Call this before any service registration helper. This is to ensure that if there
// is a service registered we remove it first. We register all services to remove boiler plate from tests
void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}
