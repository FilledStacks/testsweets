@Skip(
    'These are not unit tests. We should refactor and re-write the tests to fail for only one reason')
// TODO: Re-write unit tests. Use the FilledStacks guide to unit testing https://youtu.be/5BFlo9k3KNU
import 'dart:convert';
import 'dart:io';

import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/services/build_service.dart';
import 'package:testsweets/src/services/dynamic_keys_generator_service.dart';
import 'package:testsweets/src/services/file_system_service.dart';
import 'package:testsweets/src/services/runnable_process.dart';
import 'helpers/test_helpers.dart';

class StubbedProcess implements Process {
  final int sExitCode;
  final String sStdErr;
  final String sStdOut;
  StubbedProcess(
      {required this.sExitCode, required this.sStdErr, required this.sStdOut});

  @override
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
  Future<Process> startWith({required List<String> args}) async {
    startedWithArgs = args;
    return main;
  }
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

const String ksAppAutomationKeysFile = """
[
  {
    "name": "home",
    "type": "view",
    "view": "home"
  }
]
""";

void main() {
  group("BuildService Tests -", () {
    setUp(registerServices);
    tearDown(() => locator.reset());

    group("build -", () {
      test(
          "Should throw BuildError if the given app directory does not contain a pubspec.yaml file",
          () {
        final directoryPath = 'myApp';

        getAndRegisterFileSystemService(doesFileExist: false);

        final instance = BuildService.makeInstance();
        final run = () => instance.build(
            flutterApp: directoryPath, appType: 'apk', buildMode: 'debug');
        expect(
            run(),
            throwsA(BuildError(
                'The folder at $directoryPath does not contain a pubspec.yaml file. '
                'Please check if this is the correct folder or create the pubspec.yaml file.')));
      });
      test(
          "Should throw BuildError if the pubspec.yaml file in the given app directory does not have a version",
          () {
        final directoryPath = 'myApp';

        getAndRegisterFileSystemService(
          doesFileExist: true,
          readFileAsStringSyncResult: ksPubspecFileWithNoVersion,
        );

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
          'Should throw BuildError if the given app directory does not contain an app_automation_keys.json file',
          () {
        final directoryPath = 'myApp';

        getAndRegisterFileSystemService(
          doesFileExist: false,
          readFileAsStringSyncResult: ksPubspecFileWithVersion,
        );

        final instance = BuildService.makeInstance();
        final run = () => instance.build(
            flutterApp: directoryPath, appType: 'apk', buildMode: 'debug');
        expect(
            run,
            throwsA(BuildError(
                'We did not find the automation keys to upload. Please make sure you have added '
                'the TestSweets generator into the pubspec. If you have then make sure you run '
                'flutter pub run build_runner build --delete-conflicting-outputs before you attempt '
                'to upload the build')));
      });
      test(
          "Should call the current flutterProcess with args [build, appType, --buildMode]",
          () async {
        final directoryPath = 'myApp';
        final pubspecFilePath = 'myApp\\pubspec.yaml';
        final appAutomationKeysFilePath = 'myApp\\app_automation_keys.json';

        final fileSystemService = locator<FileSystemService>();
        getAndRegisterFileSystemService(
            doesFileExist: true,
            readFileAsStringSyncResult: ksAppAutomationKeysFile);

        getAndRegisterFlutterProcess();

        final flutterProcess = locator<FlutterProcess>();

        final instance = BuildService.makeInstance();
        await instance.build(
            flutterApp: directoryPath, appType: 'apk', buildMode: 'profile');

        verify(() =>
                flutterProcess.startWith(args: ['build', 'apk', '--profile']))
            .called(1);
      });
      test(
          "Should not read the pathToBuild from the flutter process when it is given",
          () async {
        final directoryPath = 'myApp';
        final pathToBuild = 'abc';

        final flutterProcess = getAndRegisterFlutterProcess();

        final instance = BuildService.makeInstance();
        final buildInfo = await instance.build(
          flutterApp: directoryPath,
          appType: 'apk',
          buildMode: 'profile',
          pathToBuild: pathToBuild,
        );

        verifyNever(() => flutterProcess.startWith(args: anyNamed('args')));
        expect(buildInfo.pathToBuild, pathToBuild);
      });
      group("When the flutterProcess completes with an exit code of 0", () {
        final directoryPath = 'myApp';

        test(
            "Should return the correct buildInfo pathToBuild, buildMode, appType, version, and automationKeysJson",
            () async {
          final instance = BuildService.makeInstance();
          final buildInfo = await instance.build(
              flutterApp: directoryPath, appType: 'apk', buildMode: 'profile');

          expect(buildInfo.pathToBuild,
              r'myApp\build\app\outputs\flutter-apk\abc.apk');
          expect(buildInfo.buildMode, 'profile');
          expect(buildInfo.appType, 'apk');
          expect(buildInfo.version, '0.1.1');
          expect(
            buildInfo.automationKeysJson,
            [
              {
                "name": "home",
                "type": "view",
                "view": "home",
              },
              {
                "name": "orders",
                "type": "touchable",
                "view": "ready",
              }
            ],
          );
        });
      });
      group("When the flutterProcess completes with a non 0 exit code", () {
        test(
            "Should throw BuildError with the contents of stderr of the flutter process as the message",
            () async {
          final directoryPath = 'myApp';

          final instance = BuildService.makeInstance();
          final run = () => instance.build(
              flutterApp: directoryPath, appType: 'apk', buildMode: 'profile');

          expect(
              run,
              throwsA(BuildError(
                  'The folder at myApp does not contain a pubspec.yaml file. Please check if this is the correct folder or create the pubspec.yaml file.')));
        });
      });
    });
  });
}
