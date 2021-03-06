import 'dart:convert';

import 'package:testsweets/utils/error_messages.dart';

import '../locator.dart';
import 'build_service.dart';
import 'file_system_service.dart';

enum ConfigFileKeyType { ProjectId, ApiKey, FlutterBuildCommand }

extension ToString on ConfigFileKeyType {
  // Get the name of the enum like ProjectId,ApiKey,FlutterBuildCommand
  // if we use toString() we get for example "ConfigFileKeyType.ProjectId"
  String get string {
    var lastPart = toString().split('.').last;
    //convert to camelcase
    return "${lastPart[0].toLowerCase()}${lastPart.substring(1)}";
  }
}

abstract class TestSweetsConfigFileService {
  String getValueFromConfigFileByKey(ConfigFileKeyType keyType);
}

class TestSweetsConfigFileServiceImplementaion
    implements TestSweetsConfigFileService {
  final fileSystemService = locator<FileSystemService>();

  @override
  String getValueFromConfigFileByKey(ConfigFileKeyType keyType) {
    final flutterProjectFullPath = fileSystemService.fullPathToWorkingDirectory;

    final pathToTestSweetsConfigsFile = '$flutterProjectFullPath\\.testsweets';

    if (!fileSystemService.doesFileExist(pathToTestSweetsConfigsFile)) {
      throw BuildError(ErrorMessages.projectConfigNotCreated);
    }
    final testSweetsConfigsSrc =
        fileSystemService.readFileAsStringSync(pathToTestSweetsConfigsFile);

    final testSweetsConfigUtils = TestSweetsConfigUtils();
    return testSweetsConfigUtils.deserializeConfigFileByKey(
        testSweetsConfigsSrc, keyType);
  }
}

class TestSweetsConfigUtils {
  String deserializeConfigFileByKey(String src, ConfigFileKeyType keyType) {
    final ls = LineSplitter();
    final testSweetsConfigsCommands = ls.convert(src);

    final map = splittingStringOnEqualSign(testSweetsConfigsCommands);

    return getStringValueFromMapByKey(map, keyType);
  }

  String getStringValueFromMapByKey(
          List<MapEntry<String, String>> map, ConfigFileKeyType keyType) =>
      map.firstWhere((element) => element.key == keyType.string).value;

  List<MapEntry<String, String>> splittingStringOnEqualSign(
      List<String> testSweetsConfigsCommands) {
    var map = testSweetsConfigsCommands.map((line) {
      var listOfParts = line.split('=').map((part) => part.trim()).toList();
      return MapEntry(listOfParts[0], listOfParts[1]);
    }).toList();

    return map;
  }
}
