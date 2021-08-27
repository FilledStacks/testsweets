import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:build/build.dart';
import 'package:testsweets_generator/src/constants/app_constants.dart';

import 'key_extractor.dart';

class AutomationKeyGenerator implements Builder {
  final BuilderOptions options;

  final _keyExtractor = const KeyExtractor();

  AutomationKeyGenerator(this.options);

  static AssetId _allFileOutput(BuildStep buildStep) {
    return AssetId(
      buildStep.inputId.package,
      'app_automation_keys.json',
    );
  }

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final appAutomationKeys = <String>[];

    final pathsToCheck = [
      Directory.current.absolute.path,
    ];

    if (options.config.containsKey(AdditionalPathsConfigKey)) {
      final paths = (options.config[AdditionalPathsConfigKey] as List)
          .cast<String>()
          .map((e) => '${Directory.current.absolute.path}/$e');
      pathsToCheck.addAll(paths);
    }

    print('AutomationKeyGenerator | Check for keys in paths: $pathsToCheck');

    for (var path in pathsToCheck) {
      final dir = Directory('$path');
      final allFilePaths = await dir
          .list(recursive: true)
          .where((entity) => entity.absolute.path.endsWith('.dart'))
          .map((entity) => entity.absolute.path)
          .toList();

      for (var path in allFilePaths) {
        if (path.contains('.dart')) {
          final file = File(path);

          final content = file.readAsStringSync();

          var extractedkeys = _keyExtractor
              .getKeysFromString(content)
              .map((key) => '$key')
              .toList();

          appAutomationKeys.addAll(extractedkeys);
        }
      }
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
