import 'dart:io';

import 'src/locator.dart';
import 'src/services/build_service.dart';
import 'src/services/file_system_service.dart';
import 'src/services/upload_service.dart';

Future<void> main(List<String> args) async {
  final errorMessage =
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

  void quit() {
    print('Error: $errorMessage');
    exit(-1);
  }

  if (args.length < 5) quit();

  final command = args[0];
  final appType = args[1];
  final buildMode = args[2];
  final projectId = args[3];
  final apiKey = args[4];
  final extraArgs = args.length > 5 ? args.sublist(5) : <String>[];

  if (!['buildAndUpload', 'upload'].contains(command) ||
      buildMode == 'release') {
    quit();
  }

  String pathToBuild = '';
  if (command == 'upload') {
    int positionBeforePath = args.indexOf('--path');
    if (positionBeforePath == -1) positionBeforePath = args.indexOf('-p');

    if (positionBeforePath == -1 || positionBeforePath == args.length) {
      print(
          "When using 'upload' you must provide the path to your build with the --path or -p argument after the apiKey\n\n");
      quit();
    }

    pathToBuild = args[positionBeforePath + 1];
  }

  setupLocator();
  final flutterApp = locator<FileSystemService>().fullPathToWorkingDirectory;

  final buildInfo = await locator<BuildService>().build(
    flutterApp: flutterApp,
    appType: appType,
    buildMode: buildMode,
    extraFlutterProcessArgs: extraArgs,
    pathToBuild: pathToBuild,
  );

  print('Uploading build ...');
  await locator<UploadService>().uploadBuild(buildInfo, projectId, apiKey);
  print("Done!");
}
