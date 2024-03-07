import 'dart:io';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:testsweets/src/dart_only_locator.dart';
import 'package:testsweets/src/models/interaction.dart';
import 'package:testsweets/src/services/automation_keys_service.dart';
import 'package:testsweets/src/services/build_service.dart';
import 'package:testsweets/src/services/cloud_functions_service.dart';
import 'package:testsweets/src/services/dynamic_keys_generator.dart';
import 'package:testsweets/src/services/file_system_service.dart';
import 'package:testsweets/src/services/old_http_service.dart';
import 'package:testsweets/src/services/runnable_process.dart';
import 'package:testsweets/src/services/test_sweets_config_file_service.dart';
import 'package:testsweets/src/services/time_service.dart';
import 'package:testsweets/src/services/upload_service.dart';

import 'dart_only_test_helpers.mocks.dart';
import 'stubed_proccess.dart';
import 'test_consts.dart';

@GenerateMocks([], customMocks: [
  MockSpec<TestSweetsConfigFileService>(
      onMissingStub: OnMissingStub.returnDefault),
  MockSpec<BuildService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<FileSystemService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<FlutterProcess>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<OldHttpService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<TimeService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<CloudFunctionsService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<DynamicKeysGenerator>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<UploadService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<AutomationKeysService>(onMissingStub: OnMissingStub.returnDefault),
])
MockFileSystemService getAndRegisterFileSystemService({
  bool doesFileExist = false,
  String readFileAsStringSyncResult = appAutomationKeysFile,
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
  when(service.fullPathToWorkingDirectory(fileName: anyNamed('fileName')))
      .thenReturn(testDirectoryPath);
  dartOnlyLocator.registerSingleton<FileSystemService>(service);
  return service;
}

MockFlutterProcess getAndRegisterFlutterProcess() {
  _removeRegistrationIfExists<FlutterProcess>();
  final service = MockFlutterProcess();
  when(service.startWith(args: anyNamed('args'))).thenAnswer((_) {
    return Future.value(StubbedProcess(
        sExitCode: 0,
        sStdErr: '',
        sStdOut: !Platform.isWindows
            ? 'build\/app\/outputs\/flutter-apk\/abc.apk'
            : 'build\\app\\outputs\\flutter-apk\\abc.apk'));
  });

  dartOnlyLocator.registerSingleton<FlutterProcess>(service);
  return service;
}

MockTestSweetsConfigFileService getAndRegisterTestSweetsConfigFileService(
    {String? valueFromConfigFileByKey}) {
  _removeRegistrationIfExists<TestSweetsConfigFileService>();
  final service = MockTestSweetsConfigFileService();

  when(service.getValueFromConfigFileByKey(any)).thenReturn(
      valueFromConfigFileByKey ?? testExtraFlutterProcessArgsWithDebug[0]);

  dartOnlyLocator.registerSingleton<TestSweetsConfigFileService>(service);
  return service;
}

MockDynamicKeysGenerator getAndRegisterDynamicKeysGeneratorService(
    {List<String>? generateAutomationKeysFromDynamicKeysFileResult}) {
  _removeRegistrationIfExists<DynamicKeysGenerator>();
  final service = MockDynamicKeysGenerator();

  when(service.generateAutomationKeysFromDynamicKeysFile(any)).thenReturn(
    generateAutomationKeysFromDynamicKeysFileResult ??
        testDynamicAutomationKeys,
  );

  dartOnlyLocator.registerSingleton<DynamicKeysGenerator>(service);
  return service;
}

MockOldHttpService getAndRegisterHttpService() {
  _removeRegistrationIfExists<OldHttpService>();
  final service = MockOldHttpService();

  when(service.putBinary(
    to: anyNamed('to'),
    data: anyNamed('data'),
    headers: anyNamed('headers'),
    contentLength: anyNamed('contentLength'),
  )).thenAnswer((_) async => OldSimpleHttpResponse(200, ''));

  dartOnlyLocator.registerSingleton<OldHttpService>(service);
  return service;
}

MockTimeService getAndRegisterTimeService() {
  _removeRegistrationIfExists<TimeService>();
  final service = MockTimeService();
  when(service.now()).thenReturn(testDateTime);
  dartOnlyLocator.registerSingleton<TimeService>(service);
  return service;
}

BuildService getAndRegisterBuildServiceService() {
  _removeRegistrationIfExists<BuildService>();
  final service = MockBuildService();
  when(service.build(
          pathToBuild: anyNamed('pathToBuild'),
          appType: anyNamed('appType'),
          extraFlutterProcessArgs: anyNamed('extraFlutterProcessArgs')))
      .thenAnswer(
    (_) => Future.value(testBuildInfo),
  );

  dartOnlyLocator.registerSingleton<BuildService>(service);
  return service;
}

MockCloudFunctionsService getAndRegisterCloudFunctionsService({
  String getV4BuildUploadSignedUrlResult = '',
  bool doesBuildExistInProjectResult = true,
  String addWidgetDescriptionToProjectResult = 'default_id',
  String updateWidgetDescription = 'default_id',
  String deleteWidgetDescription = 'default_id',
  List<Interaction> getWidgetDescriptionForProjectResult = const [],
}) {
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

  when(service.uploadWidgetDescriptionToProject(
          projectId: anyNamed('projectId'),
          description: anyNamed('description')))
      .thenAnswer((realInvocation) =>
          Future.value(addWidgetDescriptionToProjectResult));

  when(service.getWidgetDescriptionForProject(projectId: anyNamed('projectId')))
      .thenAnswer((realInvocation) =>
          Future.value(getWidgetDescriptionForProjectResult));

  when(service.deleteWidgetDescription(
          projectId: anyNamed('projectId'),
          description: anyNamed('description')))
      .thenAnswer((realInvocation) => Future.value(deleteWidgetDescription));

  when(service.updateInteraction(
          projectId: anyNamed('projectId'),
          interaction: anyNamed('interaction')))
      .thenAnswer((realInvocation) => Future.value(updateWidgetDescription));

  dartOnlyLocator.registerSingleton<CloudFunctionsService>(service);
  return service;
}

UploadService getAndRegisterUploadService() {
  _removeRegistrationIfExists<UploadService>();
  final service = MockUploadService();
  when(service.uploadBuild(any, any, any))
      .thenAnswer((realInvocation) => Future.value());
  dartOnlyLocator.registerSingleton<UploadService>(service);
  return service;
}

AutomationKeysService getAndRegisterAutomationKeysService() {
  _removeRegistrationIfExists<AutomationKeysService>();
  final service = MockAutomationKeysService();
  when(service.extractKeysListFromJson()).thenReturn(testAutomationKeys);
  dartOnlyLocator.registerSingleton<AutomationKeysService>(service);
  return service;
}

void registerDartOnlyServices() {
  getAndRegisterFileSystemService();
  getAndRegisterFlutterProcess();
  getAndRegisterHttpService();
  getAndRegisterTimeService();
  getAndRegisterCloudFunctionsService();
  getAndRegisterDynamicKeysGeneratorService();
  getAndRegisterBuildServiceService();
  getAndRegisterTestSweetsConfigFileService();
  getAndRegisterUploadService();
  getAndRegisterAutomationKeysService();
}

void unregisterDartOnlyServices() {
  _removeRegistrationIfExists<FileSystemService>();
  _removeRegistrationIfExists<FlutterProcess>();
  _removeRegistrationIfExists<OldHttpService>();
  _removeRegistrationIfExists<TimeService>();
  _removeRegistrationIfExists<CloudFunctionsService>();
  _removeRegistrationIfExists<DynamicKeysGenerator>();
  _removeRegistrationIfExists<BuildService>();
  _removeRegistrationIfExists<TestSweetsConfigFileService>();
  _removeRegistrationIfExists<UploadService>();
  _removeRegistrationIfExists<AutomationKeysService>();
}

// Call this before any service registration helper. This is to ensure that if there
// is a service registered we remove it first. We register all services to remove boiler plate from tests
void _removeRegistrationIfExists<T extends Object>() {
  if (dartOnlyLocator.isRegistered<T>()) {
    dartOnlyLocator.unregister<T>();
  }
}
