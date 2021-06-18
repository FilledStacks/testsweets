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
      '''Expected arguments to have the form: buildAndUpload appType

Where:
  appType can be apk or ipa

you need to add .testsweets file at the root of your project containing the folowing parameters
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

  if (!['buildAndUpload', 'upload'].contains(command)) {
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
        '''Project config is not created . If you forgot to setup your .testsweets file please
           create one. It requires three values, your projectId (found in your project settings)
           your apiKey (found in your project settings) and your flutterBuildCommand (the part
           of the command after flutter pub build apk).''');
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
