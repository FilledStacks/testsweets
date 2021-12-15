import 'package:flutter_test/flutter_test.dart';
import 'package:testsweets/src/services/automation_keys_service.dart';

import '../helpers/dart_only_test_helpers.dart';
import '../helpers/test_consts.dart';

void main() {
  group('AutomationKeysService -', () {
    setUp(registerDartOnlyServices);
    tearDown(unregisterDartOnlyServices);
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
