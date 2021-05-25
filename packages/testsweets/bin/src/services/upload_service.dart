import 'dart:io';

import '../models/build_info.dart';
import '../locator.dart';
import 'file_system_service.dart';
import 'time_service.dart';
import 'cloud_functions_service.dart';
import 'http_service.dart';

abstract class UploadService {
  Future<void> uploadBuild(
      BuildInfo buildInfo, String projectId, String apiKey);

  factory UploadService.makeInstance() {
    return _UploadService();
  }
}

class _UploadService implements UploadService {
  final cloudFunctionsService = locator<CloudFunctionsService>();
  final timeService = locator<TimeService>();
  final fileSystemService = locator<FileSystemService>();
  final httpService = locator<HttpService>();

  @override
  Future<void> uploadBuild(
      BuildInfo buildInfo, String projectId, String apiKey) async {
    await throwIfBuildIsDuplicate(projectId, buildInfo);
    final buildFileContents =
        fileSystemService.openFileForReading(buildInfo.pathToBuild);
    final buildFileSize =
        fileSystemService.getFileSizeInBytes(buildInfo.pathToBuild);

    final headers = <String, String>{
      HttpHeaders.contentLengthHeader: buildFileSize.toString(),
      HttpHeaders.contentTypeHeader: 'application/octet-stream',
      'Host': 'storage.googleapis.com',
      'Date': HttpDate.format(timeService.now()),
      'x-goog-meta-buildMode': buildInfo.buildMode,
      'x-goog-meta-version': buildInfo.version,
      'x-goog-meta-appType': buildInfo.appType,
    };

    final endpoint = await cloudFunctionsService.getV4BuildUploadSignedUrl(
        projectId, apiKey, headers);

    final ret = await httpService.putBinary(
        to: endpoint,
        data: buildFileContents,
        contentLength: buildFileSize,
        headers: headers);

    if (ret.body.contains('<Error>')) throw ret.body;
  }

  Future<void> throwIfBuildIsDuplicate(
      String projectId, BuildInfo buildInfo) async {
    final buildExists = await cloudFunctionsService
        .doesBuildExistInProject(projectId, withVersion: buildInfo.version);
    if (buildExists) {
      throw BuildUploadError(
          'You have already uploaded an ${buildInfo.appType.toUpperCase()} with the version ${buildInfo.version}. Please update the version '
          'of your application, rebuild and upload the new one.');
    }
  }
}

class BuildUploadError {
  final String message;
  BuildUploadError([this.message = ""]);

  @override
  String toString() => "BuildUploadError: $message";

  operator ==(other) =>
      other is BuildUploadError && other.message == this.message;

  int get hasCode => message.hashCode;
}
