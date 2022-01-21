import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:testsweets/src/dart_only_locator.dart';
import 'package:testsweets/src/models/build_error.dart';
import 'package:testsweets/utils/error_messages.dart';
import 'package:yaml/yaml.dart';

import '../models/build_info.dart';
import 'file_system_service.dart';
import 'runnable_process.dart';

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
    required String appType,
    List<String> extraFlutterProcessArgs,
    String pathToBuild,
  });
}

class BuildServiceImplementation implements BuildService {
  final fileSystemService = dartOnlyLocator<FileSystemService>();
  final flutterProcess = dartOnlyLocator<FlutterProcess>();

  @override
  Future<BuildInfo> build({
    required String appType,
    List<String> extraFlutterProcessArgs = const <String>[],
    String pathToBuild = '',
  }) async {
    final pubspecYamlPath =
        fileSystemService.fullPathToWorkingDirectory(fileName: 'pubspec.yaml');

    if (!fileSystemService.doesFileExist(pubspecYamlPath)) {
      throw BuildError(ErrorMessages.thereIsNoPubspecyamlFile(pubspecYamlPath));
    }

    YamlMap pubspec =
        loadYaml(fileSystemService.readFileAsStringSync(pubspecYamlPath));

    if (pubspec['version'] == null) {
      throw BuildError(ErrorMessages.thereIsNoVersionInPubspecyamlFile);
    }

    if (pathToBuild.isEmpty) {
      final flutterArgs = ['build', appType, ...extraFlutterProcessArgs];
      final runningFlutterProcess = await flutterProcess.startWith(
        args: flutterArgs,
      );
      final processStdoutCollector = Utf8CollectingStreamConsumer(stdout);
      final processStderrCollector = Utf8CollectingStreamConsumer(stderr);

      await runningFlutterProcess.stdout.pipe(processStdoutCollector);
      await runningFlutterProcess.stderr.pipe(processStderrCollector);

      final exitCode = await runningFlutterProcess.exitCode;

      if (exitCode != 0) {
        throw BuildError(processStderrCollector.collectAsString());
      }

      final processStdoutString = processStdoutCollector.collectAsString();
      final fileName = findSubPathToBuild(processStdoutString);
      pathToBuild =
          fileSystemService.fullPathToWorkingDirectory(fileName: fileName);
    }
    return BuildInfo(
      pathToBuild: pathToBuild,
      buildMode: extraFlutterProcessArgs.first,
      appType: appType,
      version: pubspec['version'],
    );
  }

  String findSubPathToBuild(String processStdout) {
    final regexp = !Platform.isWindows
        ? RegExp(r'build\/app\/outputs\/[\w-\\/.]+')
        : RegExp(r'build\\app\\outputs\\[\w-\\\.]+');
    final match = regexp.firstMatch(processStdout);

    if (match == null) throw BuildError('Could not find matches for $regexp');

    final ret = processStdout.substring(match.start, match.end);
    if (ret.endsWith('.')) return ret.substring(0, ret.length - 1);

    return ret;
  }
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
