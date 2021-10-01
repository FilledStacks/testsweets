import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/services/build_service.dart';
import 'package:testsweets/src/services/runnable_process.dart';
import 'package:testsweets/utils/error_messages.dart';

import '../helpers/test_consts.dart';
import '../helpers/test_helpers.dart';

void main() {
  group("BuildService Tests -", () {
    setUp(registerServices);
    tearDown(() => locator.reset());

    group("build -", () {
      test(
          "Should throw BuildError if the given app directory does not contain a pubspec.yaml file",
          () async {
        final buildService = BuildServiceImplementation();

        ;
        expect(
            () => buildService.build(appType: testAppType),
            throwsA(BuildError(
                ErrorMessages.thereIsNoPubspecyamlFile(testDirectoryPath))));
      });
      test(
          "Should throw BuildError if the pubspec.yaml file in the given app directory does not have a version",
          () {
        getAndRegisterFileSystemService(
            doesFileExist: true,
            readFileAsStringSyncResult: ksPubspecFileWithNoVersion,
            jsonFilesreadFileAsStringSyncResult: appAutomationKeysFile);
        final buildService = BuildServiceImplementation();

        expect(
            () => buildService.build(
                  appType: testAppType,
                ),
            throwsA(
                BuildError(ErrorMessages.thereIsNoVersionInPubspecyamlFile)));
      });

      test(
          "Should call the current flutterProcess with args [build, appType, --buildMode]",
          () async {
        //TODO: fix test name
        getAndRegisterFileSystemService(
            doesFileExist: true,
            readFileAsStringSyncResult: ksPubspecFileWithVersion,
            jsonFilesreadFileAsStringSyncResult: appAutomationKeysFile,
            jsonFilesDoesFileExist: true);

        getAndRegisterFlutterProcess();

        final flutterProcess = locator<FlutterProcess>();

        final instance = BuildServiceImplementation();
        await instance.build(
            appType: testAppType, extraFlutterProcessArgs: testExtraArgs);

        verify(flutterProcess
            .startWith(args: ['build', testAppType, '--profile'])).called(1);
      });
      test(
          "Should not read the pathToBuild from the flutter process when it is given",
          () async {
        final flutterProcess = getAndRegisterFlutterProcess();
        getAndRegisterFileSystemService(
          doesFileExist: true,
          readFileAsStringSyncResult: ksPubspecFileWithVersion,
          jsonFilesreadFileAsStringSyncResult: appAutomationKeysFile,
        );
        final instance = BuildServiceImplementation();
        final buildInfo = await instance.build(
            appType: testAppType,
            pathToBuild: testPathToBuild,
            extraFlutterProcessArgs: testExtraArgs);

        verifyNever(flutterProcess.startWith(args: anyNamed('args')));
        expect(buildInfo.pathToBuild, testPathToBuild);
      });

      test(
          "When the flutterProcess completes with an exit code of 0, Should return the correct buildInfo pathToBuild, buildMode, appType, version, and automationKeysJson",
          () async {
        getAndRegisterFileSystemService(
          doesFileExist: true,
          readFileAsStringSyncResult: ksPubspecFileWithVersion,
          jsonFilesreadFileAsStringSyncResult: appAutomationKeysFile,
        );
        final instance = BuildServiceImplementation();
        final buildInfo = await instance.build(
            appType: testAppType, extraFlutterProcessArgs: testExtraArgs);

        expect(buildInfo.pathToBuild,
            r'myApp\build\app\outputs\flutter-apk\abc.apk');
        expect(buildInfo.buildMode, testExtraArgs.first);
        expect(buildInfo.appType, testAppType);
        expect(buildInfo.version, '0.1.1');
        // expect(buildInfo.automationKeysJson, ['home_view_home']);
      });

      test(
          "When the flutterProcess completes with a non 0 exit code, Should throw BuildError with the contents of stderr of the flutter process as the message",
          () async {
        final instance = BuildServiceImplementation();
        final run = () => instance.build(
              appType: testAppType,
            );

        expect(
            run,
            throwsA(BuildError(
                ErrorMessages.thereIsNoPubspecyamlFile(testDirectoryPath))));
      });
    });
  });
}
