import 'dart:convert';

import 'package:testsweets/utils/error_messages.dart';

import '../locator.dart';
import 'build_service.dart';
import 'dynamic_keys_generator.dart';
import 'file_system_service.dart';

abstract class AutomationKeysService {
  List<String> extractKeysListFromJson();
}

class AutomationKeysServiceImplementation implements AutomationKeysService {
  final _fileSystemService = locator<FileSystemService>();
  final _dynamicKeysGeneratorService = locator<DynamicKeysGenerator>();

  @override
  List<String> extractKeysListFromJson() {
    final flutterApp = _fileSystemService.fullPathToWorkingDirectory;
    final pathToAppAutomationKeys = '$flutterApp\\app_automation_keys.json';
    final pathToDynamicKeysFile = '$flutterApp\\dynamic_keys.json';
    List<String> appAutomationKeysJson = [];

    if (!_fileSystemService.doesFileExist(pathToAppAutomationKeys)) {
      throw BuildError(ErrorMessages.notFoundAutomationKeys);
    }

    final dynamicKeys = _dynamicKeysGeneratorService
        .generateAutomationKeysFromDynamicKeysFile(pathToDynamicKeysFile);

    appAutomationKeysJson.addAll(dynamicKeys);

    try {
      final automationKeysAsString =
          _fileSystemService.readFileAsStringSync(pathToAppAutomationKeys);
      final generatedKeys = (json.decode(automationKeysAsString) as Iterable);
      final generatedKeysList = generatedKeys.map((e) => e.toString()).toList();

      appAutomationKeysJson.addAll(generatedKeysList);
    } catch (e) {
      throw BuildError(ErrorMessages.errorParsingAutomationKeys);
    }
    return appAutomationKeysJson;
  }
}
