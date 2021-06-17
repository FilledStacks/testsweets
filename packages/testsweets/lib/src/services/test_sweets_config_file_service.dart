import 'dart:convert';

enum ConfigFileKeyType { ProjectId, ApiKey, FlutterBuildCommand }

extension ToString on ConfigFileKeyType {
  String get string => toString().split('.').last;
}

abstract class TestSweetsConfigFileService {
  String getValueFromConfigFileByKey(ConfigFileKeyType keyType);
}

class TestSweetsConfigFileServiceImplementaion
    implements TestSweetsConfigFileService {
  final String testSweetsConfigsFileSrc;

  const TestSweetsConfigFileServiceImplementaion(
      {required this.testSweetsConfigsFileSrc});

  @override
  String getValueFromConfigFileByKey(ConfigFileKeyType keyType) {
    return _deserializeConfigFileByKey(testSweetsConfigsFileSrc, keyType);
  }

  static dynamic _deserializeConfigFileByKey(
      String src, ConfigFileKeyType keyType) {
    final ls = LineSplitter();
    final testSweetsConfigsCommands = ls.convert(src);

    final map = _splittingStringOnEqualSign(testSweetsConfigsCommands);

    switch (keyType) {
      case ConfigFileKeyType.ProjectId:
        return _getStringValueFromMapByKey(map, keyType);
      case ConfigFileKeyType.ApiKey:
        return _getStringValueFromMapByKey(map, keyType);
      case ConfigFileKeyType.FlutterBuildCommand:
        return _getStringValueFromMapByKey(map, keyType);
      default:
        return '';
    }
  }

  static String _getStringValueFromMapByKey(
      List<MapEntry<String, String>> map, ConfigFileKeyType keyType) {
    return map.firstWhere((element) => element.key == keyType.string).value;
  }

  static List<MapEntry<String, String>> _splittingStringOnEqualSign(
      List<String> testSweetsConfigsCommands) {
    var map = testSweetsConfigsCommands.map((line) {
      var listOfParts = line.split('=').map((part) => part.trim()).toList();
      return MapEntry(listOfParts[0], listOfParts[1]);
    }).toList();

    return map;
  }
}
