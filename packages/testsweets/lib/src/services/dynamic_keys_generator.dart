import 'dart:convert';

import '../locator.dart';
import 'file_system_service.dart';

class DynamicKeysGenerator {
  final fileSystemService = locator<FileSystemService>();

  List<String> generateAutomationKeysForDynamicKey(
      {required String key, required int numberOfAutomationKeysToGenerate}) {
    final List<String> keys = [];

    for (int index = 0; index < numberOfAutomationKeysToGenerate; index++) {
      final keyUnits = key.replaceAll("{index}", '$index').split('_');
      final newKey = [
        keyUnits[0],
        keyUnits[1],
        if (keyUnits.length == 2) keyUnits[0],
        if (keyUnits.length > 2) keyUnits[2],
      ];

      keys.add(newKey.join('_'));
    }

    return keys;
  }

  List<String> generateAutomationKeysFromDynamicKeysFile(
      String dynamicKeysFilePath) {
    if (!fileSystemService.doesFileExist(dynamicKeysFilePath)) return [];

    final fileJson = json
        .decode(fileSystemService.readFileAsStringSync(dynamicKeysFilePath));
    final out = <String>[];
    for (var dynamicKey in (fileJson as Iterable)) {
      out.addAll(generateAutomationKeysForDynamicKey(
        key: dynamicKey['key'],
        numberOfAutomationKeysToGenerate: dynamicKey['itemCount'] ?? 10,
      ));
    }

    return out;
  }
}
