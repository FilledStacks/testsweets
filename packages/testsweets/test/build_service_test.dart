import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/models/build_info.dart';
import 'package:testsweets/src/services/build_service.dart';
import 'package:testsweets/src/services/file_system_service.dart';
import 'package:testsweets/src/services/runnable_process.dart';
import 'package:testsweets/src/services/test_sweets_config_file_service.dart';
import 'helpers/stubed_proccess.dart';
import 'helpers/test_helpers.dart';
import 'helpers/test_helpers.mocks.dart';

void main() {
  group("BuildService Tests -", () {
    setUp(registerServices);
    tearDown(() => locator.reset());

    group("build -", () {
      test(
          "Should throw BuildError if the given app directory does not contain a pubspec.yaml file",
          () async {
        final directoryPath = 'myApp';

        final mockFileSystemService =
            getAndRegisterFileSystemService(doesFileExist: false);
        final mockBuildService = BuildServiceImplementaion();

        expect(mockFileSystemService.doesFileExist(directoryPath), false);
        expect(
            () => mockBuildService.build(
                flutterApp: directoryPath, appType: 'apk'),
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

        final instance = BuildServiceImplementaion();

        expect(
            () => instance.build(
                  flutterApp: directoryPath,
                  appType: 'apk',
                ),
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

        final instance = BuildServiceImplementaion();
        final run =
            () => instance.build(flutterApp: directoryPath, appType: 'apk');
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

        final instance = BuildServiceImplementaion();
        await instance.build(flutterApp: directoryPath, appType: 'apk');

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

        final instance = BuildServiceImplementaion();
        final buildInfo = await instance.build(
          flutterApp: directoryPath,
          appType: 'apk',
          pathToBuild: pathToBuild,
        );

        verifyNever(() => flutterProcess.startWith(args: anyNamed('args')));
        expect(buildInfo.pathToBuild, pathToBuild);
      });

      test(
          "When the flutterProcess completes with an exit code of 0, Should return the correct buildInfo pathToBuild, buildMode, appType, version, and automationKeysJson",
          () async {
        final directoryPath = 'myApp';
        final instance = BuildServiceImplementaion();
        final buildInfo = await instance.build(
          flutterApp: directoryPath,
          appType: 'apk',
        );

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

      test(
          "When the flutterProcess completes with a non 0 exit code, Should throw BuildError with the contents of stderr of the flutter process as the message",
          () async {
        final directoryPath = 'myApp';

        final instance = BuildServiceImplementaion();
        final run = () => instance.build(
              flutterApp: directoryPath,
              appType: 'apk',
            );

        expect(
            run,
            throwsA(BuildError(
                'The folder at myApp does not contain a pubspec.yaml file. Please check if this is the correct folder or create the pubspec.yaml file.')));
      });
    });
  });
}
