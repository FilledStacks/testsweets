import 'dart:async';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as p;

import 'package:build/build.dart';
import 'package:testsweets_generator/src/data_models/data_models.dart';

import 'automation_key_creator.dart';
import 'key_extractor.dart';

class AutomationKeyGenerator implements Builder {
  // TODO: To make it faster allow user to pass in a path to their top level view folder
  static final _allFilesInLib = new Glob('lib/**');
  final _keyExtractor = const KeyExtractor();
  final _keyCreator = const AutomationKeyCreator();

  static AssetId _allFileOutput(BuildStep buildStep) {
    return AssetId(
      buildStep.inputId.package,
      p.join('lib', 'app_automation_keys.dart'),
    );
  }

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    // Will store all the files required for this build step
    final appAutomationKeys = List<AutomationKey>();

    await for (final input in buildStep.findAssets(_allFilesInLib)) {
      var fileContent = await buildStep.readAsString(input);

      var extractedkeys = _keyExtractor
          .getKeysFromString(fileContent)
          .map((key) => '$key')
          .toList();

      var automationKeys =
          _keyCreator.getAutomationKeysFromStrings(extractedkeys);

      appAutomationKeys.addAll(automationKeys);
    }

    final outputFile = _allFileOutput(buildStep);
    List<String> codeUnits =
        appAutomationKeys.map((key) => key.toDartCode()).toList();
    String dartCode =
        '''// DO NOT EDIT, CODE GENERATED WITH TEST SWEETS GENERATOR on ${DateTime.now()}.

const List<Map<String, String>> APP_AUTOMATION_KEYS = [
${codeUnits.join(',\n')}
];
''';

    return buildStep.writeAsString(outputFile, dartCode);
  }

  @override
  Map<String, List<String>> get buildExtensions {
    return const {
      r'$lib$': const ['app_automation_keys.dart'],
    };
  }
}
