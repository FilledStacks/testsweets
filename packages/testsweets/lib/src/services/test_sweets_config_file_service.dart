import 'dart:convert';

import 'package:testsweets/src/models/build_error.dart';
import 'package:testsweets/utils/error_messages.dart';

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

class TestSweetsConfigFileService {
  final fileSystemService = FileSystemServiceImplementation();

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
      testSweetsConfigsSrc,
      keyType,
    );
  }
}

class TestSweetsConfigUtils {
  String deserializeConfigFileByKey(String src, ConfigFileKeyType keyType) {
    final ls = LineSplitter();
    final testSweetsConfigsCommands = ls.convert(src);
    // print(
    //     'deserializeConfigFileByKey|testSweetsConfigsCommands:$testSweetsConfigsCommands');
    final map = splittingStringOnEqualSign(testSweetsConfigsCommands);
    // print('deserializeConfigFileByKey|map:$map');
    final stringValueFromMapByKey = getStringValueFromMapByKey(map, keyType);
    // print(
    //     'deserializeConfigFileByKey|stringValueFromMapByKey:$stringValueFromMapByKey');
    return stringValueFromMapByKey;
  }

  String getStringValueFromMapByKey(
          List<MapEntry<String, String>> map, ConfigFileKeyType keyType) =>
      map.firstWhere((element) => element.key == keyType.string).value;

  List<MapEntry<String, String>> splittingStringOnEqualSign(
      List<String> testSweetsConfigsCommands) {
    var map = testSweetsConfigsCommands.map((line) {
      var listOfParts = line.split('=').map((part) => part.trim()).toList();
      return MapEntry(listOfParts[0],
          listOfParts.getRange(1, listOfParts.length).join('='));
    }).toList();

    return map;
  }
}
