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
    final endpoint = await cloudFunctionsService.getV4BuildUploadSignedUrl(
        projectId, apiKey);

    final buildFileContents =
        fileSystemService.readFileAsBytesSync(buildInfo.pathToBuild);

    final headers = <String, String>{
      HttpHeaders.contentLengthHeader: buildFileContents.length.toString(),
      HttpHeaders.contentTypeHeader: 'application/octet-stream',
      'Host': 'storage.googleapis.com',
      'Date': HttpDate.format(timeService.now()),
      'x-goog-meta-buildMode': buildInfo.buildMode,
      'x-goog-meta-version': buildInfo.version,
      'x-goog-meta-appType': buildInfo.appType,
    };

    await httpService.putBinary(
        to: endpoint, data: buildFileContents, headers: headers);
  }
}
