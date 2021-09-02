import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:testsweets/src/services/build_service.dart';
import 'package:testsweets/utils/error_messages.dart';

import '../bin/testsweets.dart' as ts;
import 'helpers/test_consts.dart';
import 'helpers/test_helpers.dart';

void main() {
  group('Testsweets test -', () {
    setUp(registerServices);
    tearDown(unregisterServices);
    group('main -', () {
      test('When args are less than two, should throw BuildError', () {
        expect(() => ts.main(['arg1']),
            throwsA(BuildError('Error: ${ErrorMessages.buildArgumentsError}')));
      });
      test(
          '''If the first argument of args list doesn\'t have one of these two words ['buildAndUpload', 'upload'], Shuold throw notValidCommand error''',
          () {
        expect(
            () => ts.main(['arg1', 'arg2']),
            throwsA(
                BuildError('Error: ${ErrorMessages.notValidCommand('arg1')}')));
      });
      test(
          'If upload command missing path, Should throw uploadCommandeMissingPath error',
          () {
        expect(
            () => ts.main(['upload', 'arg2']),
            throwsA(BuildError(
                'Error: ${ErrorMessages.uploadCommandeMissingPath}')));
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
          'If buildAndUpload command, Should call uploadBuild function from UploadService',
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
      test('When first is uploadKeys, Should ', () async {
        // await ts.main(['uploadKeys', testAppType], isMocking: true);
      });
    });
  });
}
