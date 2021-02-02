import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/services/build_service.dart';
import 'package:testsweets/src/services/file_system_service.dart';
import 'package:testsweets/src/services/runnable_process.dart';

class StubbedProcess implements Process {
  final int sExitCode;
  final String sStdErr;
  final String sStdOut;
  StubbedProcess(
      {@required this.sExitCode,
      @required this.sStdErr,
      @required this.sStdOut});

  @override
  // TODO: implement exitCode
  Future<int> get exitCode async => sExitCode;

  @override
  bool kill([ProcessSignal signal = ProcessSignal.sigterm]) {
    return true;
  }

  @override
  int get pid => throw UnimplementedError();

  @override
  Stream<List<int>> get stderr async* {
    yield utf8.encode(sStdErr);
  }

  @override
  IOSink get stdin => throw UnimplementedError();

  @override
  Stream<List<int>> get stdout async* {
    yield utf8.encode(sStdOut);
  }
}

class StubbedRunnableProcess implements RunnableProcess {
  final Process main;
  StubbedRunnableProcess(this.main);

  List<String> startedWithArgs = [];

  @override
  String get path => 'flutter';

  @override
  Future<Process> startWith({List<String> args}) async {
    startedWithArgs = args;
    return main;
  }
}

class MockFileSystemService extends Mock implements FileSystemService {}

class MockFlutterProcess extends Mock implements FlutterProcess {}

void setUpLocatorForTesting() {
  locator
      .registerLazySingleton<FileSystemService>(() => MockFileSystemService());
  locator.registerLazySingleton<FlutterProcess>(() => MockFlutterProcess());
}

const String ksPubspecFileWithNoVersion = """
name: myApp

environment:
  sdk: ">=2.7.0 <3.0.0"
""";

const String ksPubspecFileWithVersion = """
name: myApp

version: 0.1.1

environment:
  sdk: ">=2.7.0 <3.0.0"
""";

void main() {
  setUp(setUpLocatorForTesting);
  tearDown(() {
    locator.reset();
  });

  group("BuildService Tests", () {
    group("build", () {
      test(
          "Should throw BuildError if the given app directory does not contain a pubspec.yaml file",
          () {
        final directoryPath = 'myApp';
        final pubspecFilePath = 'myApp\\pubspec.yaml';

        final fileSystemService = locator<FileSystemService>();
        when(fileSystemService.doesFileExist(pubspecFilePath))
            .thenReturn(false);

        final instance = BuildService.makeInstance();
        final run = () => instance.build(
            flutterApp: directoryPath, appType: 'apk', buildMode: 'debug');
        expect(
            run,
            throwsA(BuildError(
                'The folder at $directoryPath does not contain a pubspec.yaml file. '
                'Please check if this is the correct folder or create the pubspec.yaml file.')));
      });
      test(
          "Should throw BuildError if the pubspec.yaml file in the given app directory does not have a version",
          () {
        final directoryPath = 'myApp';
        final pubspecFilePath = 'myApp\\pubspec.yaml';

        final fileSystemService = locator<FileSystemService>();
        when(fileSystemService.doesFileExist(pubspecFilePath)).thenReturn(true);
        when(fileSystemService.readFileAsStringSync(pubspecFilePath))
            .thenReturn(ksPubspecFileWithNoVersion);

        final instance = BuildService.makeInstance();
        final run = () => instance.build(
            flutterApp: directoryPath, appType: 'apk', buildMode: 'debug');
        expect(
            run,
            throwsA(BuildError(
                'The pubspec.yaml file for this project does not define a version. '
                'Versions are used by Test Sweets to keep track of builds. Please add a version for this app.')));
      });
      test(
          "Should call the current flutterProcess with args [build, appType, --buildMode]",
          () async {
        final directoryPath = 'myApp';
        final pubspecFilePath = 'myApp\\pubspec.yaml';

        final fileSystemService = locator<FileSystemService>();
        when(fileSystemService.doesFileExist(pubspecFilePath)).thenReturn(true);
        when(fileSystemService.readFileAsStringSync(pubspecFilePath))
            .thenReturn(ksPubspecFileWithVersion);

        final flutterProcess = locator<FlutterProcess>();
        when(flutterProcess.startWith(args: ['build', 'apk', '--profile']))
            .thenAnswer((_) async => StubbedProcess(
                sExitCode: 0,
                sStdErr: '',
                sStdOut: 'build\\app\\outputs\\flutter-apk\\abc.apk'));

        final instance = BuildService.makeInstance();
        await instance.build(
            flutterApp: directoryPath, appType: 'apk', buildMode: 'profile');

        verify(flutterProcess.startWith(args: ['build', 'apk', '--profile']))
            .called(1);
      });
      group("When the flutterProcess completes with an exit code of 0", () {
        test("Should return the correct build info", () async {
          final directoryPath = 'myApp';
          final pubspecFilePath = 'myApp\\pubspec.yaml';

          final fileSystemService = locator<FileSystemService>();
          when(fileSystemService.doesFileExist(pubspecFilePath))
              .thenReturn(true);
          when(fileSystemService.readFileAsStringSync(pubspecFilePath))
              .thenReturn(ksPubspecFileWithVersion);

          final flutterProcess = locator<FlutterProcess>();
          when(flutterProcess.startWith(args: [
            'build',
            'apk',
            '--profile'
          ])).thenAnswer((_) async => StubbedProcess(
              sExitCode: 0,
              sStdErr: '',
              sStdOut: "RunningGradle task 'assembleProfile'...\n"
                  "Running Gradle task 'assembleProfile'... Done           378,6s\n"
                  r"Built build\app\outputs\flutter-apk\abc.apk"));

          final instance = BuildService.makeInstance();
          final buildInfo = await instance.build(
              flutterApp: directoryPath, appType: 'apk', buildMode: 'profile');

          expect(buildInfo.pathToBuild,
              r'myApp\build\app\outputs\flutter-apk\abc.apk');
          expect(buildInfo.buildMode, 'profile');
          expect(buildInfo.appType, 'apk');
          expect(buildInfo.version, '0.1.1');
        });
      });
      group("When the flutterProcess completes with a non 0 exit code", () {
        test(
            "Should throw BuildError with the contents of stderr of the flutter process as the message",
            () async {
          final directoryPath = 'myApp';
          final pubspecFilePath = 'myApp\\pubspec.yaml';

          final fileSystemService = locator<FileSystemService>();
          when(fileSystemService.doesFileExist(pubspecFilePath))
              .thenReturn(true);
          when(fileSystemService.readFileAsStringSync(pubspecFilePath))
              .thenReturn(ksPubspecFileWithVersion);

          final flutterProcess = locator<FlutterProcess>();
          when(flutterProcess.startWith(args: ['build', 'apk', '--profile']))
              .thenAnswer((_) async =>
                  StubbedProcess(sExitCode: -1, sStdErr: 'abc', sStdOut: ''));

          final instance = BuildService.makeInstance();
          final run = () => instance.build(
              flutterApp: directoryPath, appType: 'apk', buildMode: 'profile');

          expect(run, throwsA(BuildError('abc')));
        });
      });
    });
  });
}
