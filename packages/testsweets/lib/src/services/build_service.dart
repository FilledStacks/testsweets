import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:testsweets/utils/error_messages.dart';
import 'package:yaml/yaml.dart';

import '../locator.dart';
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
  final fileSystemService = locator<FileSystemService>();
  final flutterProcess = locator<FlutterProcess>();

  @override
  Future<BuildInfo> build({
    required String appType,
    List<String> extraFlutterProcessArgs = const <String>[],
    String pathToBuild = '',
  }) async {
    final flutterApp = fileSystemService.fullPathToWorkingDirectory;
    final pathToPubspecFile = '$flutterApp\\pubspec.yaml';

    if (!fileSystemService.doesFileExist(pathToPubspecFile)) {
      throw BuildError(ErrorMessages.thereIsNoPubspecyamlFile(flutterApp));
    }

    YamlMap pubspec =
        loadYaml(fileSystemService.readFileAsStringSync(pathToPubspecFile));

    if (pubspec['version'] == null) {
      throw BuildError(ErrorMessages.thereIsNoVersionInPubspecyamlFile);
    }

    if (pathToBuild.isEmpty) {
      final flutterArgs = ['build', appType, ...extraFlutterProcessArgs];
      print('flutterArgs: $flutterArgs');
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
      pathToBuild = '$flutterApp\\' + findSubPathToBuild(processStdoutString);
    }
    return BuildInfo(
      pathToBuild: pathToBuild,
      buildMode: extraFlutterProcessArgs.first,
      appType: appType,
      version: pubspec['version'],
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
