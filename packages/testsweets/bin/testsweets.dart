import 'package:testsweets/src/locator.dart';
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
  if (!isMocking) await setupLocator();
  final testSweetsConfigFileService = locator<TestSweetsConfigFileService>();

  final buildInfo = await locator<BuildService>().build(
      appType: appType,
      pathToBuild: pathToBuild,
      extraFlutterProcessArgs: testSweetsConfigFileService
          .getValueFromConfigFileByKey(ConfigFileKeyType.FlutterBuildCommand)
          .split(' '));

  print("BuildInfo collected: $buildInfo \n Uploading automation keys ...");
  await locator<CloudFunctionsService>().uploadAutomationKeys(
    testSweetsConfigFileService
        .getValueFromConfigFileByKey(ConfigFileKeyType.ProjectId),
    testSweetsConfigFileService
        .getValueFromConfigFileByKey(ConfigFileKeyType.ApiKey),
    buildInfo.automationKeysJson,
  );

  print('Successfully uploaded automation keys! \nUploading build ...');
  await locator<UploadService>().uploadBuild(
      buildInfo,
      testSweetsConfigFileService
          .getValueFromConfigFileByKey(ConfigFileKeyType.ProjectId),
      testSweetsConfigFileService
          .getValueFromConfigFileByKey(ConfigFileKeyType.ApiKey));
  print("Done!");
}
