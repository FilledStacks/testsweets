import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:meta/meta.dart';

import '../locator.dart';
import '../models/build_info.dart';
import 'file_system_service.dart';
import 'runnable_process.dart';
import 'package:yaml/yaml.dart';

abstract class BuildService {
  /// Builds the flutter application in the directory [flutterApp].
  ///
  /// The directory [flutterApp] must contain a `pubspec.yaml` file which
  /// must contain the `version` field. An error is thrown if the `version`
  /// is not given in the pubspec.yaml file.
  Future<BuildInfo> build({
    @required String flutterApp,
    @required String appType,
    @required String buildMode,
    List<String> extraFlutterProcessArgs,
  });

  factory BuildService.makeInstance() {
    return _BuildService();
  }
}

class _BuildService implements BuildService {
  final fileSystemService = locator<FileSystemService>();
  final flutterProcess = locator<FlutterProcess>();

  @override
  Future<BuildInfo> build(
      {String flutterApp,
      String appType,
      String buildMode,
      List<String> extraFlutterProcessArgs = const <String>[]}) async {
    final pathToPubspecFile = '$flutterApp\\pubspec.yaml';
    if (!fileSystemService.doesFileExist(pathToPubspecFile)) {
      throw BuildError(
          'The folder at $flutterApp does not contain a pubspec.yaml file. '
          'Please check if this is the correct folder or create the pubspec.yaml file.');
    }

    final pubspec =
        loadYaml(fileSystemService.readFileAsStringSync(pathToPubspecFile));

    if (pubspec['version'] == null) {
      throw BuildError(
          'The pubspec.yaml file for this project does not define a version. '
          'Versions are used by Test Sweets to keep track of builds. Please add a version for this app.');
    }

    final runningFlutterProcess = await flutterProcess.startWith(
        args: ['build', appType, '--$buildMode', ...extraFlutterProcessArgs]);

    final processStdoutCollector = Utf8CollectingStreamConsumer(stdout);
    final processStderrCollector = Utf8CollectingStreamConsumer(stderr);

    await runningFlutterProcess.stdout.pipe(processStdoutCollector);
    await runningFlutterProcess.stderr.pipe(processStderrCollector);

    final exitCode = await runningFlutterProcess.exitCode;

    if (exitCode != 0) {
      throw BuildError(processStderrCollector.collectAsString());
    }

    final processStdoutString = processStdoutCollector.collectAsString();
    return BuildInfo(
      pathToBuild: '$flutterApp\\' + findSubPathToBuild(processStdoutString),
      buildMode: buildMode,
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
}

class Utf8CollectingStreamConsumer implements StreamConsumer<List<int>> {
  final IOSink relayTo;
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