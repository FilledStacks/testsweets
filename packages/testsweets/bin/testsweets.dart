import 'dart:io';

import 'package:testsweets/src/services/test_sweets_config_file_service.dart';
import 'package:testsweets/utils/error_messages.dart';

import '../lib/src/locator.dart';
import '../lib/src/services/build_service.dart';
import '../lib/src/services/cloud_functions_service.dart';
import '../lib/src/services/file_system_service.dart';
import '../lib/src/services/upload_service.dart';

Future<void> main(List<String> args) async {
  void quit(
    String errorMsg,
  ) =>
      throw BuildError('Error: $errorMsg');

  if (args.length < 2) quit(ErrorMessages.buildArgumentsError);

  final command = args[0];
  final appType = args[1];

  if (!['buildAndUpload', 'upload'].contains(command)) {
    quit(
      ErrorMessages.notValidCommand(command),
    );
  }

  String pathToBuild = '';
  if (command == 'upload') {
    int positionBeforePath = args.indexOf('--path');
    if (positionBeforePath == -1) positionBeforePath = args.indexOf('-p');

    if (positionBeforePath == -1 || positionBeforePath == args.length) {
      quit(
        ErrorMessages.uploadCommandeMissingPath,
      );
    }

    pathToBuild = args[positionBeforePath + 1];
  }

  setupLocator();

  final fileSystemService = locator<FileSystemService>();
  final flutterProjectFullPath = fileSystemService.fullPathToWorkingDirectory;

  final pathToTestSweetsConfigsFile = '$flutterProjectFullPath\\.testsweets';

  if (!fileSystemService.doesFileExist(pathToTestSweetsConfigsFile)) {
    throw BuildError(ErrorMessages.projectConfigNotCreated);
  }
  final testSweetsConfigsSrc =
      fileSystemService.readFileAsStringSync(pathToTestSweetsConfigsFile);

  locator.registerSingleton<TestSweetsConfigFileService>(
      TestSweetsConfigFileServiceImplementaion(
          testSweetsConfigsFileSrc: testSweetsConfigsSrc));

  final testSweetsConfigFileService = locator<TestSweetsConfigFileService>();

  final buildInfo = await locator<BuildService>().build(
      flutterApp: flutterProjectFullPath,
      appType: appType,
      pathToBuild: pathToBuild,
      extraFlutterProcessArgs: testSweetsConfigFileService
          .getValueFromConfigFileByKey(ConfigFileKeyType.FlutterBuildCommand)
          .split(' '));

  print('BuildInfo collected: $buildInfo');

  print('Uploading automation keys ...');
  await locator<CloudFunctionsService>().uploadAutomationKeys(
    testSweetsConfigFileService
        .getValueFromConfigFileByKey(ConfigFileKeyType.ProjectId),
    testSweetsConfigFileService
        .getValueFromConfigFileByKey(ConfigFileKeyType.ApiKey),
    buildInfo.automationKeysJson,
  );
  print('Successfully uploaded automation keys!');

  print('Uploading build ...');
  await locator<UploadService>().uploadBuild(
      buildInfo,
      testSweetsConfigFileService
          .getValueFromConfigFileByKey(ConfigFileKeyType.ProjectId),
      testSweetsConfigFileService
          .getValueFromConfigFileByKey(ConfigFileKeyType.ApiKey));
  print("Done!");
}
