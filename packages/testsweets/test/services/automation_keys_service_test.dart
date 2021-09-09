import 'package:test/test.dart';
import 'package:testsweets/src/services/automation_keys_service.dart';

import '../helpers/test_consts.dart';
import '../helpers/test_helpers.dart';

void main() {
  group('AutomationKeysService -', () {
    setUp(registerServices);
    tearDown(unregisterServices);
    group('extractKeysListFromJson -', () {
      test(
          'When give it a json of keys through FileSystemService , should return list of strings',
          () {
        getAndRegisterFileSystemService(
            doesFileExist: true,
            readFileAsStringSyncResult: appAutomationKeysFile);
        final automationKeysService = AutomationKeysServiceImplementation();
        final List<String> listOfKeys =
            automationKeysService.extractKeysListFromJson();
        expect(listOfKeys, testDynamicAutomationKeys + testAutomationKeys);
      });
    });
  });
}
