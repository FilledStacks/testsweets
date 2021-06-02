import 'dart:convert';

import '../locator.dart';
import 'file_system_service.dart';

/// A service for generating dautomation keys for the dynamic keys.
abstract class DynamicKeysGeneratorService {
  /// Generates fake automation keys for the dynamic keys to be uploaded to the
  /// projects automation keys.
  ///
  /// Uploading fake keys makes it possible to have autocomplete available for
  /// dynamic keys as well.
  List<Map<String, String>> generateAutomationKeysFromDynamicKeysFile(
      String dynamicKeysFilePath);
  List<Map<String, String>> generateAutomationKeysForDynamicKey(
      {required String key, required int numberOfAutomationKeysToGenerate});

  factory DynamicKeysGeneratorService.makeInstance() {
    return _DynamicKeysGeneratorService();
  }
}

class _DynamicKeysGeneratorService implements DynamicKeysGeneratorService {
  final fileSystemService = locator<FileSystemService>();

  @override
  List<Map<String, String>> generateAutomationKeysForDynamicKey(
      {required String key, required int numberOfAutomationKeysToGenerate}) {
    final out = <Map<String, String>>[];

    for (int iii = 0; iii < numberOfAutomationKeysToGenerate; iii++) {
      final keyUnits = key.replaceAll("{index}", '$iii').split('_');
      out.add({
        'view': keyUnits[0],
        'type': keyUnits[1],
        if (keyUnits.length == 2) ...{
          'name': keyUnits[0],
        },
        if (keyUnits.length > 2) ...{
          'name': keyUnits[2],
        }
      });
    }

    return out;
  }

  @override
  List<Map<String, String>> generateAutomationKeysFromDynamicKeysFile(
      String dynamicKeysFilePath) {
    if (!fileSystemService.doesFileExist(dynamicKeysFilePath)) return [];

    final fileJson = json
        .decode(fileSystemService.readFileAsStringSync(dynamicKeysFilePath));

    final out = <Map<String, String>>[];
    for (var dynamicKey in (fileJson as Iterable)) {
      out.addAll(generateAutomationKeysForDynamicKey(
        key: dynamicKey['key'],
        numberOfAutomationKeysToGenerate: dynamicKey['itemCount'] ?? 10,
      ));
    }

    return out;
  }
}
