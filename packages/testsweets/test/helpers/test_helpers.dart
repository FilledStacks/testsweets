import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/expect.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/models/build_info.dart';
import 'package:testsweets/src/services/build_service.dart';
import 'package:testsweets/src/services/cloud_functions_service.dart';
import 'package:testsweets/src/services/dynamic_keys_generator_service.dart';
import 'package:testsweets/src/services/file_system_service.dart';
import 'package:testsweets/src/services/http_service.dart';
import 'package:testsweets/src/services/runnable_process.dart';
import 'package:testsweets/src/services/test_sweets_config_file_service.dart';
import 'package:testsweets/src/services/time_service.dart';
import 'test_consts.dart';
import 'stubed_proccess.dart';
import 'test_helpers.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<TestSweetsConfigFileService>(returnNullOnMissingStub: true),
  MockSpec<BuildService>(returnNullOnMissingStub: true),
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
  bool? jsonFilesDoesFileExist,
  String? jsonFilesreadFileAsStringSyncResult,
}) {
  _removeRegistrationIfExists<FileSystemService>();
  final service = MockFileSystemService();

  /// duo to multiple calls to this service in [BuildService],if you want to change the mock for just json files
  /// activate this fields(or one of them depends on your needs) [jsonFilesDoesFileExist,jsonFilesreadFileAsStringSyncResult]
  when(service.doesFileExist(any)).thenAnswer((realInvocation) {
    var fileName = realInvocation.positionalArguments[0] as String;
    if (jsonFilesDoesFileExist != null && fileName.endsWith('.json'))
      return jsonFilesDoesFileExist;
    else
      return doesFileExist;
  });
  when(service.readFileAsStringSync(any)).thenAnswer((realInvocation) {
    var fileName = realInvocation.positionalArguments[0] as String;
    if (jsonFilesreadFileAsStringSyncResult != null &&
        fileName.endsWith('.json'))
      return jsonFilesreadFileAsStringSyncResult;
    else
      return readFileAsStringSyncResult;
  });
  when(service.openFileForReading(any)).thenAnswer((_) => testDataStream);
  when(service.getFileSizeInBytes(any)).thenReturn(testContentLength);
  when(service.fullPathToWorkingDirectory).thenReturn(testDirectoryPath);
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

MockTestSweetsConfigFileService getAndRegisterTestSweetsConfigFileService() {
  _removeRegistrationIfExists<TestSweetsConfigFileService>();
  final service = MockTestSweetsConfigFileService();
  when(service
          .getValueFromConfigFileByKey(ConfigFileKeyType.FlutterBuildCommand))
      .thenAnswer((realInvocation) => '--debug -t lib/main_profile.dart');
  locator.registerSingleton<TestSweetsConfigFileService>(service);
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
  when(service.now()).thenReturn(testDateTime);
  locator.registerSingleton<TimeService>(service);
  return service;
}

BuildService getAndRegisterBuildServiceService() {
  _removeRegistrationIfExists<BuildService>();
  final service = MockBuildService();
  when(service.build(
          appType: testAppType,
          extraFlutterProcessArgs: ['--debug -t lib/main_profile.dart']))
      .thenAnswer(
    (_) => Future.value(BuildInfo(
      pathToBuild: 'abc.apk',
      buildMode: 'profile',
      appType: testAppType,
      version: '0.1.1',
      automationKeysJson: ['automationKeysJson'],
      dynamicKeysJson: [
        {
          "name": "home",
          "type": "view",
          "view": "home",
        },
        {
          "name": "orders",
          "type": "touchable",
          "view": "ready",
        }
      ],
    )),
  );
  locator.registerSingleton<BuildService>(service);
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
  getAndRegisterBuildServiceService();
  getAndRegisterTestSweetsConfigFileService();
}

void unregisterServices() {
  locator.unregister<FileSystemService>();
  locator.unregister<FlutterProcess>();
  locator.unregister<HttpService>();
  locator.unregister<TimeService>();
  locator.unregister<CloudFunctionsService>();
  locator.unregister<DynamicKeysGeneratorService>();
  locator.unregister<TestSweetsConfigFileService>();
}

// Call this before any service registration helper. This is to ensure that if there
// is a service registered we remove it first. We register all services to remove boiler plate from tests
void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}
