import 'dart:io';

import 'package:testsweets/src/services/test_sweets_config_file_service.dart';

import '../lib/src/locator.dart';
import '../lib/src/services/build_service.dart';
import '../lib/src/services/cloud_functions_service.dart';
import '../lib/src/services/file_system_service.dart';
import '../lib/src/services/upload_service.dart';

Future<void> main(List<String> args) async {
  void quit(
    String errorMsg,
  ) {
    throw BuildError('Error: $errorMsg');
  }

  final _buildArgumentsError =
      '''Expected arguments to have the form: buildAndUpload appType buildMode projectId apiKey

Where:
  appType can be apk or ipa
  buildMode can be debug or profile
  projectId is the id of the Test Sweets project you want to upload this build to
  apiKey is the API key for the project you want to upload this build to

You can find both the API key and the project id for your project in the project
settings tab in Test Sweets.

The 'buildAndUpload' command will build your application with `flutter build`. Normal
positional `flutter build` arguments, like --flavor, can be passed to the command just after
the apiKey.

You can use the 'upload' command if you already have a build (apk or ipa) and all you want
to do is upload it. The path to the build must be specified with the '--path' positional
argument after the apiKey.

For example:
  \$ testsweets upload apk profile myProjectId myApiKey --path 'path/to/my/build.apk'
''';

  if (args.length < 2) quit(_buildArgumentsError);

  final command = args[0];
  final appType = args[1];
  final buildMode = '';

  if (!['buildAndUpload', 'upload'].contains(command) ||
      buildMode == 'release') {
    quit(
      '$command is not a valid command, You can use either \'buildAndUpload\' or \'upload\'',
    );
  }

  String pathToBuild = '';
  if (command == 'upload') {
    int positionBeforePath = args.indexOf('--path');
    if (positionBeforePath == -1) positionBeforePath = args.indexOf('-p');

    if (positionBeforePath == -1 || positionBeforePath == args.length) {
      quit(
        "When using 'upload' you must provide the path to your build with the --path or -p argument after the apiKey\n\n",
      );
    }

    pathToBuild = args[positionBeforePath + 1];
  }

  setupLocator();

  final fileSystemService = locator<FileSystemService>();
  final flutterProjectFullPath = fileSystemService.fullPathToWorkingDirectory;

  final pathToTestSweetsConfigsFile = '$flutterProjectFullPath\\.testsweets';

  if (!fileSystemService.doesFileExist(pathToTestSweetsConfigsFile)) {
    throw BuildError(
        'The folder at $flutterProjectFullPath does not contain a pubspec.yaml file. '
        'Please check if this is the correct folder or create the pubspec.yaml file.');
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
      buildMode: buildMode,
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
