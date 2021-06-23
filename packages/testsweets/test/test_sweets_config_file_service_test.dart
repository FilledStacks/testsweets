import 'dart:convert';

import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/services/build_service.dart';
import 'package:testsweets/src/services/runnable_process.dart';
import 'package:testsweets/src/services/test_sweets_config_file_service.dart';
import 'package:testsweets/utils/error_messages.dart';
import 'helpers/test_consts.dart';
import 'helpers/test_helpers.dart';

void main() {
  group("ConfigFileService Tests -", () {
    setUp(registerServices);
    tearDown(() => locator.reset());
    test(
        "Should throw BuildError if the given app directory does not contain a .testsweets file",
        () async {
      final mockFileSystemService =
          getAndRegisterFileSystemService(doesFileExist: false);
      final configFileService = TestSweetsConfigFileServiceImplementaion();

      expect(mockFileSystemService.doesFileExist(testDirectoryPath), false);
      expect(
          () => configFileService
              .getValueFromConfigFileByKey(ConfigFileKeyType.ApiKey),
          throwsA(BuildError(ErrorMessages.projectConfigNotCreated)));
    });
    test(
        "Should split any list of strings by the '=' sign to List<MapEntry<String, String>>",
        () async {
      TestSweetsConfigUtils testSweetsConfigUtils = TestSweetsConfigUtils();
      var result = testSweetsConfigUtils
          .splittingStringOnEqualSign(testsweetFileContent);
      expect(result[0].value, '3OezzTovG9xFTE5Xw2w1');
    });
    test(
        "Should split any list of strings by the '=' sign to List<MapEntry<String, String>>",
        () async {
      TestSweetsConfigUtils testSweetsConfigUtils = TestSweetsConfigUtils();
      var result = testSweetsConfigUtils
          .splittingStringOnEqualSign(testsweetFileContent);
      expect(result[0].value, '3OezzTovG9xFTE5Xw2w1');
    });
    test("get value from map by key", () async {
      TestSweetsConfigUtils testSweetsConfigUtils = TestSweetsConfigUtils();
      var result = testSweetsConfigUtils.getStringValueFromMapByKey(
          testsweetFileContentListOfMapEntries, ConfigFileKeyType.ProjectId);
      expect(result, '3OezzTovG9xFTE5Xw2w1');
    });
    test("deserialize Config File by key", () async {
      TestSweetsConfigUtils testSweetsConfigUtils = TestSweetsConfigUtils();
      var result = testSweetsConfigUtils.deserializeConfigFileByKey(
          testsweetFileContentRaw, ConfigFileKeyType.ProjectId);

      expect(result, '3OezzTovG9xFTE5Xw2w1');
    });
  });
}
