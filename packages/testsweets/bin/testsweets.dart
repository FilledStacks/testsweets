import 'package:testsweets/src/dart_only_locator.dart';
import 'package:testsweets/src/models/build_error.dart';
import 'package:testsweets/src/models/build_info.dart';
import 'package:testsweets/src/services/automation_keys_service.dart';
import 'package:testsweets/src/services/build_service.dart';
import 'package:testsweets/src/services/cloud_functions_service.dart';
import 'package:testsweets/src/services/test_sweets_config_file_service.dart';
import 'package:testsweets/src/services/upload_service.dart';
import 'package:testsweets/utils/error_messages.dart';

TestSweetsConfigFileService? _testSweetsConfigFileService;
Future<void> quit(
  String errorMsg,
) =>
    throw BuildError('Error: $errorMsg');

Future<void> main(
  List<String> args, {
  bool isMocking = false,
}) async {
  print('TestSweets running!');
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

  if (!isMocking) await setupDartOnlyLocator();
  _testSweetsConfigFileService = dartOnlyLocator<TestSweetsConfigFileService>();

  print("Uploading automation keys ...");
  await extractAndUploadAutomationKeys();
  print('Successfully uploaded automation keys!');

  if (!onlyUploadAutomationKeys(command)) {
    final appType = args[1];

    print('Start building $appType ...');
    BuildInfo buildInfo = await buildApp(
      appType,
      pathToBuild,
    );
    print('Successfully Built the $appType...');

    print('Uploading build ...');
    await uploadBuild(
      buildInfo,
    );
    print('Successfully Uploaded the build ...');
  }
  print("Done!");
}

Future<void> extractAndUploadAutomationKeys() async {
  final automationKeys =
      dartOnlyLocator<AutomationKeysService>().extractKeysListFromJson();
  final projectId = _testSweetsConfigFileService!
      .getValueFromConfigFileByKey(ConfigFileKeyType.ProjectId);
  final apiKey = _testSweetsConfigFileService!
      .getValueFromConfigFileByKey(ConfigFileKeyType.ApiKey);

  await dartOnlyLocator<CloudFunctionsService>()
      .uploadAutomationKeys(projectId, apiKey, automationKeys);
}

Future<void> uploadBuild(BuildInfo buildInfo) async {
  final projectId = _testSweetsConfigFileService!
      .getValueFromConfigFileByKey(ConfigFileKeyType.ProjectId);
  final apiKey = _testSweetsConfigFileService!
      .getValueFromConfigFileByKey(ConfigFileKeyType.ApiKey);

  await dartOnlyLocator<UploadService>()
      .uploadBuild(buildInfo, projectId, apiKey);
}

Future<BuildInfo> buildApp(
  String appType,
  String pathToBuild,
) async {
  final extraFlutterProcessArgs = _testSweetsConfigFileService!
      .getValueFromConfigFileByKey(ConfigFileKeyType.FlutterBuildCommand)
      .split(' ');
  final buildInfo = await dartOnlyLocator<BuildService>().build(
      appType: appType,
      pathToBuild: pathToBuild,
      extraFlutterProcessArgs: extraFlutterProcessArgs);
  return buildInfo;
}

bool onlyUploadAutomationKeys(String command) => command == 'uploadKeys';
