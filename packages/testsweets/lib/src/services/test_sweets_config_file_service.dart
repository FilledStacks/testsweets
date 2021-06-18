import 'dart:convert';

enum ConfigFileKeyType { ProjectId, ApiKey, FlutterBuildCommand }

extension ToString on ConfigFileKeyType {
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
  final String testSweetsConfigsFileSrc;

  const TestSweetsConfigFileServiceImplementaion(
      {required this.testSweetsConfigsFileSrc});

  @override
  String getValueFromConfigFileByKey(ConfigFileKeyType keyType) {
    return _deserializeConfigFileByKey(testSweetsConfigsFileSrc, keyType);
  }

  String _deserializeConfigFileByKey(String src, ConfigFileKeyType keyType) {
    final ls = LineSplitter();
    final testSweetsConfigsCommands = ls.convert(src);

    final map = _splittingStringOnEqualSign(testSweetsConfigsCommands);

    return _getStringValueFromMapByKey(map, keyType);
  }

  String _getStringValueFromMapByKey(
      List<MapEntry<String, String>> map, ConfigFileKeyType keyType) {
    print(
        'key type: ${keyType.string}\n_getStringValueFromMapByKey: map = ${map.toString()}');
    return map.firstWhere((element) => element.key == keyType.string).value;
  }

  List<MapEntry<String, String>> _splittingStringOnEqualSign(
      List<String> testSweetsConfigsCommands) {
    var map = testSweetsConfigsCommands.map((line) {
      var listOfParts = line.split('=').map((part) => part.trim()).toList();
      return MapEntry(listOfParts[0], listOfParts[1]);
    }).toList();

    return map;
  }
}
