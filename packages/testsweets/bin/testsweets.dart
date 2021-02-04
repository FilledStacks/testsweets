import 'dart:io';

import 'src/locator.dart';
import 'src/services/build_service.dart';
import 'src/services/file_system_service.dart';
import 'src/services/upload_service.dart';

Future<void> main(List<String> args) async {
  final errorMessage =
      'Expected arguments to have the form: upload apk/ipa debug/profile projectId apiKey';
  if (args.length < 5 || args[0] != 'upload' || args[2] == 'release') {
    print('Error: $errorMessage');
    exit(-1);
  }

  setupLocator();
  final flutterApp = locator<FileSystemService>().fullPathToWorkingDirectory;

  final buildInfo = await locator<BuildService>()
      .build(flutterApp: flutterApp, appType: args[1], buildMode: args[2]);

  print('Uploading build ...');

  final projectId = args[3];
  final apiKey = args[4];

  await locator<UploadService>().uploadBuild(buildInfo, projectId, apiKey);
  print("Done!");
}
