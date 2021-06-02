import 'dart:io';
import 'dart:typed_data';

import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/models/build_info.dart';
import 'package:testsweets/src/services/upload_service.dart';

import 'helpers/test_helpers.dart';

void main() {
  group("UploadService Tests -", () {
    setUp(registerServices);
    tearDown(() => locator.reset());

    group("uploadBuild(buildInfo, projectId, apiKey) -", () {
      final buildInfo = BuildInfo(
        pathToBuild: 'abc.apk',
        buildMode: 'debug',
        appType: 'apk',
        version: '1.2.0',
        automationKeysJson: [],
        dynamicKeysJson: [],
      );

      final projectId = 'testProjectId';
      final apiKey = 'testApiKey';
      final dummySignedUrl =
          'https://storage.googleapis.com/testProjectId/testGuid%2fapplication.build';

      final expectedObjectHeaders = <String, String>{
        HttpHeaders.contentLengthHeader: '2',
        HttpHeaders.contentTypeHeader: 'application/octet-stream',
        'Host': 'storage.googleapis.com',
        'Date': "Wed, 03 Feb 2021 13:47:14 GMT",
        'x-goog-meta-buildMode': 'debug',
        'x-goog-meta-version': '1.2.0',
        'x-goog-meta-appType': 'apk',
      };

      Stream<List<int>> makeBuildFile() async* {
        yield [0xaa, 0xbb];
      }

      final buildFile = makeBuildFile();

      setUp(registerServices);

      test(
          "Should throw BuildUploadError if there already exists a build with the same version number as the uploaded one",
          () {
        getAndRegisterCloudFunctionsService(
            doesBuildExistInProjectResult: true);
        final instance = UploadService.makeInstance();

        final run = () => instance.uploadBuild(buildInfo, projectId, apiKey);

        expect(
            run,
            throwsA(BuildUploadError(
                "You have already uploaded an APK with the version ${buildInfo.version}. Please update the version "
                "of your application, rebuild and upload the new one.")));
      });
      test(
          "Should upload the file with the correct data and headers to the signed endpoint returned by CloudFunctionsService.getV4BuildUploadSignedUrl",
          () async {
        getAndRegisterCloudFunctionsService(
            doesBuildExistInProjectResult: false);
        final httpService = getAndRegisterHttpService();
        final instance = UploadService.makeInstance();

        await instance.uploadBuild(buildInfo, projectId, apiKey);

        verify(() => httpService.putBinary(
            to: dummySignedUrl,
            data: buildFile,
            headers: expectedObjectHeaders,
            contentLength: 2)).called(1);
      });
    });
  });
}
