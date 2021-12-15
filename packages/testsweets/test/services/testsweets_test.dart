import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:testsweets/src/models/build_error.dart';
import 'package:testsweets/utils/error_messages.dart';

import '../../bin/testsweets.dart' as ts;
import '../helpers/dart_only_test_helpers.dart';
import '../helpers/test_consts.dart';

void main() {
  group('Testsweets test -', () {
    setUp(registerDartOnlyServices);
    tearDown(unregisterDartOnlyServices);
    group('main -', () {
      test('When args are less than one, should throw BuildError', () {
        expect(() => ts.main([]),
            throwsA(BuildError('Error: ${ErrorMessages.buildArgumentsError}')));
      });
      test(
          '''If the first argument of args list doesn\'t have one of these two words ['buildAndUpload', 'uploadApp','uploadKey'], Shuold throw notValidCommand error''',
          () {
        expect(
            () => ts.main(['upload', 'arg2']),
            throwsA(BuildError(
                'Error: ${ErrorMessages.notValidCommand('upload')}')));
      });
      test(
          'If uploadApp command missing path, Should throw uploadAppCommandeMissingPath error',
          () {
        expect(
            () => ts.main(['uploadApp', 'arg2']),
            throwsA(BuildError(
                'Error: ${ErrorMessages.uploadAppCommandeMissingPath}')));
      });
      test(
          'If buildAndUpload command, Should call build function from build service',
          () async {
        final buildService = getAndRegisterBuildServiceService();
        await ts.main(['buildAndUpload', testAppType], isMocking: true);
        verify(buildService.build(
            pathToBuild: '',
            appType: testAppType,
            extraFlutterProcessArgs:
                testExtraFlutterProcessArgsWithDebug[0].split(' ')));
      });
      test(
          'If buildAndUpload command, Should call uploadAutomationKeys function from cloudFunctionsService',
          () async {
        final cloudFunctionsService = getAndRegisterCloudFunctionsService();
        await ts.main(['buildAndUpload', testAppType], isMocking: true);
        verify(cloudFunctionsService.uploadAutomationKeys(
          testExtraFlutterProcessArgsWithDebug[0],
          testExtraFlutterProcessArgsWithDebug[0],
          testAutomationKeys,
        ));
      });
      test(
          'If buildAndUpload command, Should call uploadBuild function from UploadService',
          () async {
        final uploadService = getAndRegisterUploadService();
        await ts.main(['buildAndUpload', testAppType], isMocking: true);
        verify(uploadService.uploadBuild(
          testBuildInfo,
          testExtraFlutterProcessArgsWithDebug[0],
          testExtraFlutterProcessArgsWithDebug[0],
        ));
      });
      test(
          'When first item in args is "uploadKeys", Should not call build the app or uploadapp',
          () async {
        final uploadService = getAndRegisterUploadService();
        final buildService = getAndRegisterBuildServiceService();

        await ts.main(['uploadKeys', testAppType], isMocking: true);
        verifyNever(uploadService.uploadBuild(
          testBuildInfo,
          testExtraFlutterProcessArgsWithDebug[0],
          testExtraFlutterProcessArgsWithDebug[0],
        ));
        verifyNever(buildService.build(
            pathToBuild: '',
            appType: testAppType,
            extraFlutterProcessArgs:
                testExtraFlutterProcessArgsWithDebug[0].split(' ')));
      });
      group('onlyUploadAutomationKeys -', () {
        test('When passing "uploadKeys", Should be true', () async {
          expect(ts.onlyUploadAutomationKeys('uploadKeys'), true);
        });
      });
    });
  });
}
