import 'dart:async';
import 'dart:convert';
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
      'app_automation_keys.json',
    );
  }

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    // Will store all the files required for this build step
    final appAutomationKeys = <AutomationKey>[];

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
    final encoder = JsonEncoder.withIndent('  ');
    final jsonOut = encoder.convert(appAutomationKeys);
    return buildStep.writeAsString(outputFile, jsonOut);
  }

  @override
  Map<String, List<String>> get buildExtensions {
    return const {
      r'$lib$': const ['../app_automation_keys.json'],
    };
  }
}
