import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:testsweets/src/models/build_error.dart';
import 'package:testsweets/src/services/build_service.dart';
import 'package:testsweets/utils/error_messages.dart';

import '../helpers/dart_only_test_helpers.dart';
import '../helpers/test_consts.dart';

void main() {
  group("BuildService Tests -", () {
    setUp(registerDartOnlyServices);
    tearDown(unregisterDartOnlyServices);

    group("build -", () {
      test(
          "Should throw BuildError if the given app directory does not contain a pubspec.yaml file",
          () async {
        final buildService = BuildServiceImplementation();

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
        getAndRegisterFileSystemService(
            doesFileExist: true,
            readFileAsStringSyncResult: ksPubspecFileWithVersion,
            jsonFilesreadFileAsStringSyncResult: appAutomationKeysFile,
            jsonFilesDoesFileExist: true);

        final flutterProcess = getAndRegisterFlutterProcess();

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

        expect(buildInfo.pathToBuild, 'myApp');
        expect(buildInfo.buildMode, testExtraArgs.first);
        expect(buildInfo.appType, testAppType);
        expect(buildInfo.version, '0.1.1');
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
