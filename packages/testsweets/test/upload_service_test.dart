import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/services/build_service.dart';
import 'package:testsweets/src/services/file_system_service.dart';
import 'package:testsweets/src/services/runnable_process.dart';
import 'package:testsweets/utils/error_messages.dart';
import 'helpers/consts.dart';
import 'helpers/test_helpers.dart';

void main() {
  group("BuildService Tests -", () {
    setUp(registerServices);
    tearDown(() => locator.reset());

    group("build -", () {
      test(
          "Should throw BuildError if the given app directory does not contain a pubspec.yaml file",
          () {
        getAndRegisterFileSystemService(doesFileExist: false);

        final instance = BuildServiceImplementaion();
        final run =
            () => instance.build(flutterApp: directoryPath, appType: appType);
        expect(
            run(),
            throwsA(BuildError(
                ErrorMessages.thereIsNoPubspecyamlFile(directoryPath))));
      });
      test(
          "Should throw BuildError if the pubspec.yaml file in the given app directory does not have a version",
          () {
        getAndRegisterFileSystemService(
          doesFileExist: true,
          readFileAsStringSyncResult: ksPubspecFileWithNoVersion,
        );

        final instance = BuildServiceImplementaion();
        final run = () => instance.build(
              flutterApp: directoryPath,
              appType: appType,
            );
        expect(
            run,
            throwsA(
                BuildError(ErrorMessages.thereIsNoVersionInPubspecyamlFile)));
      });
      test(
          'Should throw BuildError if the given app directory does not contain an app_automation_keys.json file',
          () {
        getAndRegisterFileSystemService(
          doesFileExist: false,
          readFileAsStringSyncResult: ksPubspecFileWithVersion,
        );

        final instance = BuildServiceImplementaion();
        final run =
            () => instance.build(flutterApp: directoryPath, appType: appType);
        expect(run, throwsA(BuildError(ErrorMessages.notFoundAutomationKeys)));
      });
      test(
          "Should call the current flutterProcess with args [build, appType, --buildMode]",
          () async {
        final pubspecFilePath = 'myApp\\pubspec.yaml';
        final appAutomationKeysFilePath = 'myApp\\app_automation_keys.json';

        final fileSystemService = locator<FileSystemService>();
        getAndRegisterFileSystemService(
            doesFileExist: true,
            readFileAsStringSyncResult: ksAppAutomationKeysFile);

        getAndRegisterFlutterProcess();

        final flutterProcess = locator<FlutterProcess>();

        final instance = BuildServiceImplementaion();
        await instance.build(flutterApp: directoryPath, appType: appType);

        verify(() =>
                flutterProcess.startWith(args: ['build', appType, '--profile']))
            .called(1);
      });
      test(
          "Should not read the pathToBuild from the flutter process when it is given",
          () async {
        final flutterProcess = getAndRegisterFlutterProcess();

        final instance = BuildServiceImplementaion();
        final buildInfo = await instance.build(
          flutterApp: directoryPath,
          appType: appType,
          pathToBuild: pathToBuild,
        );

        verifyNever(() => flutterProcess.startWith(args: anyNamed('args')));
        expect(buildInfo.pathToBuild, pathToBuild);
      });
      group("When the flutterProcess completes with an exit code of 0", () {
        test(
            "Should return the correct buildInfo pathToBuild, buildMode, appType, version, and automationKeysJson",
            () async {
          getAndRegisterFileSystemService(doesFileExist: true);
          // final buildService = MockBuildService();
          // final testSweetsConfigFileService = MockTestSweetsConfigFileService();

          // final buildInfo = await buildService.build(
          //     flutterApp: directoryPath,
          //     appType: appType,
          //     extraFlutterProcessArgs: testSweetsConfigFileService
          //         .getValueFromConfigFileByKey(
          //             ConfigFileKeyType.FlutterBuildCommand)
          //         .split(' '),
          //     pathToBuild: r'myApp\build\app\outputs\flutter-apk\abc.apk');

          // expect(buildInfo.pathToBuild,
          //     r'myApp\build\app\outputs\flutter-apk\abc.apk');
          // expect(buildInfo.buildMode, 'profile');
          // expect(buildInfo.appType, appType);
          // expect(buildInfo.version, '0.1.1');
          // expect(
          //   buildInfo.dynamicKeysJson,
          //   [
          //     {
          //       "name": "home",
          //       "type": "view",
          //       "view": "home",
          //     },
          //     {
          //       "name": "orders",
          //       "type": "touchable",
          //       "view": "ready",
          //     }
          //   ],
          // );
        });
      });
      group("When the flutterProcess completes with a non 0 exit code", () {
        test(
            "Should throw BuildError with the contents of stderr of the flutter process as the message",
            () async {
          final instance = BuildServiceImplementaion();
          final run = () => instance.build(
                flutterApp: directoryPath,
                appType: appType,
              );

          expect(
              run,
              throwsA(BuildError(
                  ErrorMessages.thereIsNoPubspecyamlFile(directoryPath))));
        });
      });
    });
  });
}
