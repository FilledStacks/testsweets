import 'package:flutter_test/flutter_test.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/models/build_error.dart';
import 'package:testsweets/src/services/build_service.dart';
import 'package:testsweets/src/services/test_sweets_config_file_service.dart';
import 'package:testsweets/utils/error_messages.dart';

import '../helpers/test_consts.dart';
import '../helpers/test_helpers.dart';

void main() {
  group("ConfigFileService Tests -", () {
    setUp(registerServices);
    tearDown(() => locator.reset());
    test(
        "Should throw BuildError if the given app directory does not contain a .testsweets file",
        () async {
      getAndRegisterFileSystemService(doesFileExist: false);
      final configFileService = TestSweetsConfigFileService();

      expect(
          () => configFileService
              .getValueFromConfigFileByKey(ConfigFileKeyType.ApiKey),
          throwsA(BuildError(ErrorMessages.projectConfigNotCreated)));
    });
    group('TestSweetsConfigUtils functions -', () {
      group('getStringValueFromMapByKey -', () {
        test(
            "when given a list of strings, Should split by '=' sign to List<MapEntry<String, String>>",
            () async {
          TestSweetsConfigUtils testSweetsConfigUtils = TestSweetsConfigUtils();
          List<MapEntry<String, String>> result = testSweetsConfigUtils
              .splittingStringOnEqualSign(testsweetFileContent);
          expect(result[0].value, '3OezzTovG9xFTE5Xw2w1');
        });
      });
      group('getStringValueFromMapByKey -', () {
        test(
            "When given testsweetFileContentMapEntries and ProjectId key, should return 3OezzTovG9xFTE5Xw2w1",
            () async {
          TestSweetsConfigUtils testSweetsConfigUtils = TestSweetsConfigUtils();
          var result = testSweetsConfigUtils.getStringValueFromMapByKey(
              testsweetFileContentListOfMapEntries,
              ConfigFileKeyType.ProjectId);
          expect(result, '3OezzTovG9xFTE5Xw2w1');
        });
      });
      group('deserializeConfigFileByKey -', () {
        test(
            "When given testsweetFileContentRaw and ProjectId key, should return 3OezzTovG9xFTE5Xw2w1",
            () async {
          TestSweetsConfigUtils testSweetsConfigUtils = TestSweetsConfigUtils();
          var result = testSweetsConfigUtils.deserializeConfigFileByKey(
              testsweetFileContentRaw, ConfigFileKeyType.ProjectId);

          expect(result, '3OezzTovG9xFTE5Xw2w1');
        });
      });
    });
  });
}
