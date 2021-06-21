import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:testsweets/utils/error_messages.dart';

import '../locator.dart';
import '../models/build_info.dart';
import 'dynamic_keys_generator_service.dart';
import 'file_system_service.dart';
import 'runnable_process.dart';
import 'package:yaml/yaml.dart';

abstract class BuildService {
  /// Returns [BuildInfo] for the application in [flutterApp].
  ///
  /// The application will be build with `flutter build` if [pathToBuild] is
  /// empty empty, else [pathToBuild] is returned as the pathToBuild
  /// field in the returned build information.
  ///
  /// The directory [flutterApp] must contain a `pubspec.yaml` file which
  /// must contain the `version` field. An error is thrown if the `version`
  /// is not given in the pubspec.yaml file.
  Future<BuildInfo> build({
    required String flutterApp,
    required String appType,
    List<String> extraFlutterProcessArgs,
    String pathToBuild,
  });
}

class BuildServiceImplementaion implements BuildService {
  final fileSystemService = locator<FileSystemService>();
  final flutterProcess = locator<FlutterProcess>();
  final dynamicKeysGeneratorService = locator<DynamicKeysGeneratorService>();

  @override
  Future<BuildInfo> build({
    required String flutterApp,
    required String appType,
    List<String> extraFlutterProcessArgs = const <String>[],
    String pathToBuild = '',
  }) async {
    final pathToPubspecFile = '$flutterApp\\pubspec.yaml';
    final pathToAppAutomationKeys = '$flutterApp\\app_automation_keys.json';
    // final pathToDynamicKeys = '$flutterApp\\dynamic_keys.json';

    if (!fileSystemService.doesFileExist(pathToPubspecFile)) {
      throw BuildError(ErrorMessages.thereIsNoPubspecyamlFile(flutterApp));
    }

    if (!fileSystemService.doesFileExist(pathToAppAutomationKeys)) {
      throw BuildError(ErrorMessages.notFoundAutomationKeys);
    }

    YamlMap pubspec =
        loadYaml(fileSystemService.readFileAsStringSync(pathToPubspecFile));
    List<String> appAutomationKeysJson = [];
    try {
      appAutomationKeysJson = (json.decode(fileSystemService
              .readFileAsStringSync(pathToAppAutomationKeys)) as Iterable)
          .map((e) => e.toString())
          .toList();
    } catch (e) {
      //TODO(ebrahim): find a proper response to this case
    }

    if (pubspec['version'] == null) {
      throw BuildError(ErrorMessages.thereIsNoVersionInPubspecyamlFile);
    }

    if (pathToBuild.isEmpty) {
      final runningFlutterProcess = await flutterProcess
          .startWith(args: ['build', appType, ...extraFlutterProcessArgs]);

      final processStdoutCollector = Utf8CollectingStreamConsumer(stdout);
      final processStderrCollector = Utf8CollectingStreamConsumer(stderr);

      await runningFlutterProcess.stdout.pipe(processStdoutCollector);
      await runningFlutterProcess.stderr.pipe(processStderrCollector);

      final exitCode = await runningFlutterProcess.exitCode;

      if (exitCode != 0) {
        throw BuildError(processStderrCollector.collectAsString());
      }

      final processStdoutString = processStdoutCollector.collectAsString();
      pathToBuild = '$flutterApp\\' + findSubPathToBuild(processStdoutString);
    }
    return BuildInfo(
      pathToBuild: pathToBuild,
      buildMode: extraFlutterProcessArgs.first,
      appType: appType,
      version: pubspec['version'],
      automationKeysJson: appAutomationKeysJson,
      dynamicKeysJson: [],
    );
  }

  String findSubPathToBuild(String processStdout) {
    final regexp = RegExp(r'build\\app\\outputs\\[\w-\\\.]+');
    final match = regexp.firstMatch(processStdout);

    if (match == null) throw BuildError('Could not find matches for $regexp');

    final ret = processStdout.substring(match.start, match.end);
    if (ret.endsWith('.')) return ret.substring(0, ret.length - 1);

    return ret;
  }
}

class BuildError extends Error {
  final String message;
  BuildError(this.message);

  operator ==(other) => other is BuildError && other.message == this.message;

  int get hashCode => message.hashCode;

  @override
  String toString() => '$BuildError: $message';
}

class Utf8CollectingStreamConsumer implements StreamConsumer<List<int>> {
  final IOSink? relayTo;
  Utf8CollectingStreamConsumer([this.relayTo]);

  List<int> collectedCodeUnits = [];

  @override
  Future addStream(Stream<List<int>> stream) async {
    stream.forEach((data) {
      collectedCodeUnits.addAll(data);
      relayTo?.add(data);
    });
  }

  @override
  Future close() async {}

  String collectAsString() {
    return utf8.decode(collectedCodeUnits);
  }
}
