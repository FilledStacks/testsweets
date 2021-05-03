import 'dart:convert';
import 'dart:io';

import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import '../bin/src/locator.dart';
import '../bin/src/services/build_service.dart';
import '../bin/src/services/file_system_service.dart';
import '../bin/src/services/runnable_process.dart';
import 'helpers.dart';

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
        final appAutomationKeysFilePath = 'myApp\\app_automation_keys.json';

        final fileSystemService = locator<FileSystemService>();
        when(() => fileSystemService.doesFileExist(pubspecFilePath))
            .thenReturn(false);

        when(() => fileSystemService.doesFileExist(appAutomationKeysFilePath))
            .thenReturn(true);
        when(() => fileSystemService.readFileAsStringSync(
            appAutomationKeysFilePath)).thenReturn(ksAppAutomationKeysFile);

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
        final appAutomationKeysFilePath = 'myApp\\app_automation_keys.json';

        final fileSystemService = locator<FileSystemService>();
        when(() => fileSystemService.doesFileExist(pubspecFilePath))
            .thenReturn(true);
        when(() => fileSystemService.readFileAsStringSync(pubspecFilePath))
            .thenReturn(ksPubspecFileWithNoVersion);

        when(() => fileSystemService.doesFileExist(appAutomationKeysFilePath))
            .thenReturn(true);
        when(() => fileSystemService.readFileAsStringSync(
            appAutomationKeysFilePath)).thenReturn(ksAppAutomationKeysFile);

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
        final pubspecFilePath = 'myApp\\pubspec.yaml';
        final appAutomationKeysFilePath = 'myApp\\app_automation_keys.json';

        final fileSystemService = locator<FileSystemService>();
        when(() => fileSystemService.doesFileExist(pubspecFilePath))
            .thenReturn(true);
        when(() => fileSystemService.readFileAsStringSync(pubspecFilePath))
            .thenReturn(ksPubspecFileWithVersion);

        when(() => fileSystemService.doesFileExist(appAutomationKeysFilePath))
            .thenReturn(false);

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
        when(() => fileSystemService.doesFileExist(pubspecFilePath))
            .thenReturn(true);
        when(() => fileSystemService.readFileAsStringSync(pubspecFilePath))
            .thenReturn(ksPubspecFileWithVersion);

        when(() => fileSystemService.doesFileExist(appAutomationKeysFilePath))
            .thenReturn(true);
        when(() => fileSystemService.readFileAsStringSync(
            appAutomationKeysFilePath)).thenReturn(ksAppAutomationKeysFile);

        final flutterProcess = locator<FlutterProcess>();
        when(() =>
                flutterProcess.startWith(args: ['build', 'apk', '--profile']))
            .thenAnswer((_) async => StubbedProcess(
                sExitCode: 0,
                sStdErr: '',
                sStdOut: 'build\\app\\outputs\\flutter-apk\\abc.apk'));

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
        final pubspecFilePath = 'myApp\\pubspec.yaml';
        final appAutomationKeysFilePath = 'myApp\\app_automation_keys.json';
        final pathToBuild = 'abc';

        final fileSystemService = locator<FileSystemService>();
        when(() => fileSystemService.doesFileExist(pubspecFilePath))
            .thenReturn(true);
        when(() => fileSystemService.readFileAsStringSync(pubspecFilePath))
            .thenReturn(ksPubspecFileWithVersion);

        when(() => fileSystemService.doesFileExist(appAutomationKeysFilePath))
            .thenReturn(true);
        when(() => fileSystemService.readFileAsStringSync(
            appAutomationKeysFilePath)).thenReturn(ksAppAutomationKeysFile);

        final flutterProcess = locator<FlutterProcess>();

        final instance = BuildService.makeInstance();
        final buildInfo = await instance.build(
          flutterApp: directoryPath,
          appType: 'apk',
          buildMode: 'profile',
          pathToBuild: pathToBuild,
        );

        verifyNever(
            () => flutterProcess.startWith(args: captureAny(named: 'args')));
        expect(buildInfo.pathToBuild, pathToBuild);
      });
      group("When the flutterProcess completes with an exit code of 0", () {
        test("Should return the correct build info", () async {
          final directoryPath = 'myApp';
          final pubspecFilePath = 'myApp\\pubspec.yaml';
          final appAutomationKeysFilePath = 'myApp\\app_automation_keys.json';

          final fileSystemService = locator<FileSystemService>();
          when(() => fileSystemService.doesFileExist(pubspecFilePath))
              .thenReturn(true);
          when(() => fileSystemService.readFileAsStringSync(pubspecFilePath))
              .thenReturn(ksPubspecFileWithVersion);

          when(() => fileSystemService.doesFileExist(appAutomationKeysFilePath))
              .thenReturn(true);
          when(() => fileSystemService.readFileAsStringSync(
              appAutomationKeysFilePath)).thenReturn(ksAppAutomationKeysFile);

          final flutterProcess = locator<FlutterProcess>();
          when(
              () => flutterProcess.startWith(args: [
                    'build',
                    'apk',
                    '--profile'
                  ])).thenAnswer((_) async => StubbedProcess(
              sExitCode: 0,
              sStdErr: '',
              sStdOut: "RunningGradle task 'assembleProfile'...\n"
                  "Running Gradle task 'assembleProfile'... Done           378,6s\n"
                  r"Built build\app\outputs\flutter-apk\abc.apk."));

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
          final pubspecFilePath = 'myApp\\pubspec.yaml';
          final appAutomationKeysFilePath = 'myApp\\app_automation_keys.json';

          final fileSystemService = locator<FileSystemService>();
          when(() => fileSystemService.doesFileExist(pubspecFilePath))
              .thenReturn(true);
          when(() => fileSystemService.readFileAsStringSync(pubspecFilePath))
              .thenReturn(ksPubspecFileWithVersion);

          when(() => fileSystemService.doesFileExist(appAutomationKeysFilePath))
              .thenReturn(true);
          when(() => fileSystemService.readFileAsStringSync(
              appAutomationKeysFilePath)).thenReturn(ksAppAutomationKeysFile);

          final flutterProcess = locator<FlutterProcess>();
          when(() =>
                  flutterProcess.startWith(args: ['build', 'apk', '--profile']))
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
