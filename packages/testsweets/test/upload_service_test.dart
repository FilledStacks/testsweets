import 'dart:io';
import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/models/build_info.dart';

import 'test_helpers.dart';

void main() {
  setUp(registerServices);
  tearDown(() => locator.reset());

  group("UploadService Tests", () {
    group("uploadBuild(buildInfo, projectId, apiKey)", () {
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

      setUp(() {
        final timeService = locator<TimeService>();
      });

      void whenCloudFunctions_doesBuildExistInProjectItShouldReturn(
          bool valueToReturn) {
        final cloudFunctionsService = locator<CloudFunctionsService>();
        when(() => cloudFunctionsService.doesBuildExistInProject(captureAny(),
                withVersion: captureAny(named: 'withVersion')))
            .thenAnswer((invocation) async => valueToReturn);
      }

      test(
          "Should throw BuildUploadError if there already exists a build with the same version number as the uploaded one",
          () {
        whenCloudFunctions_doesBuildExistInProjectItShouldReturn(true);
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
        whenCloudFunctions_doesBuildExistInProjectItShouldReturn(false);
        final instance = UploadService.makeInstance();

        await instance.uploadBuild(buildInfo, projectId, apiKey);

        final httpService = locator<HttpService>();
        verify(() => httpService.putBinary(
            to: dummySignedUrl,
            data: buildFile,
            headers: expectedObjectHeaders,
            contentLength: 2)).called(1);
      });
    });
  });
}
