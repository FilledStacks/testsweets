import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/models/build_info.dart';
import 'package:testsweets/src/services/automation_keys_service.dart';
import 'package:testsweets/src/services/build_service.dart';
import 'package:testsweets/src/services/cloud_functions_service.dart';
import 'package:testsweets/src/services/test_sweets_config_file_service.dart';
import 'package:testsweets/src/services/upload_service.dart';
import 'package:testsweets/utils/error_messages.dart';

Future<void> quit(
  String errorMsg,
) =>
    throw BuildError('Error: $errorMsg');
Future<void> main(
  List<String> args, {
  bool isMocking = false,
}) async {
  if (args.length < 1) quit(ErrorMessages.buildArgumentsError);

  final command = args[0];

  if (!['buildAndUpload', 'uploadApp', 'uploadKeys'].contains(command)) {
    quit(
      ErrorMessages.notValidCommand(command),
    );
  }

  String pathToBuild = '';
  if (command == 'uploadApp') {
    int positionBeforePath = args.indexOf('--path');
    if (positionBeforePath == -1) positionBeforePath = args.indexOf('-p');

    if (positionBeforePath == -1 || positionBeforePath == args.length) {
      quit(
        ErrorMessages.uploadAppCommandeMissingPath,
      );
    }

    pathToBuild = args[positionBeforePath + 1];
  }
  if (!isMocking) await setupLocator();
  final testSweetsConfigFileService = locator<TestSweetsConfigFileService>();

  print("Uploading automation keys ...");
  await extractAndUploadAutomationKeys(testSweetsConfigFileService);
  print('Successfully uploaded automation keys!');

  if (!onlyUploadAutomationKeys(command)) {
    final appType = args[1];

    print('Start building $appType ...');
    BuildInfo buildInfo =
        await buildApp(appType, pathToBuild, testSweetsConfigFileService);
    print('Successfully Built the $appType...');

    print('Uploading build ...');
    await uploadBuild(buildInfo, testSweetsConfigFileService);
    print('Successfully Uploaded the build ...');
  }
  print("Done!");
}

Future<void> extractAndUploadAutomationKeys(
    TestSweetsConfigFileService testSweetsConfigFileService) async {
  await locator<CloudFunctionsService>().uploadAutomationKeys(
    testSweetsConfigFileService
        .getValueFromConfigFileByKey(ConfigFileKeyType.ProjectId),
    testSweetsConfigFileService
        .getValueFromConfigFileByKey(ConfigFileKeyType.ApiKey),
    locator<AutomationKeysService>().extractKeysListFromJson(),
  );
}

Future<void> uploadBuild(BuildInfo buildInfo,
    TestSweetsConfigFileService testSweetsConfigFileService) async {
  await locator<UploadService>().uploadBuild(
      buildInfo,
      testSweetsConfigFileService
          .getValueFromConfigFileByKey(ConfigFileKeyType.ProjectId),
      testSweetsConfigFileService
          .getValueFromConfigFileByKey(ConfigFileKeyType.ApiKey));
}

Future<BuildInfo> buildApp(String appType, String pathToBuild,
    TestSweetsConfigFileService testSweetsConfigFileService) async {
  final buildInfo = await locator<BuildService>().build(
      appType: appType,
      pathToBuild: pathToBuild,
      extraFlutterProcessArgs: testSweetsConfigFileService
          .getValueFromConfigFileByKey(ConfigFileKeyType.FlutterBuildCommand)
          .split(' '));
  return buildInfo;
}

bool onlyUploadAutomationKeys(String command) => command == 'uploadKeys';
