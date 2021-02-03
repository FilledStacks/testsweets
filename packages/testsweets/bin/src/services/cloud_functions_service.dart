abstract class CloudFunctionsService {
  /// Gets a signed url for PUTing data to a new build file in cloud storage.
  ///
  /// The build file has the name `$guid/application.build` and is an object of the
  /// bucket with name `$projectId_testsweets_builds`. $guid is randomly generated
  /// string that is unique for this build file.
  ///
  /// The bucket `$projectId_testsweets_builds` will be created if it does not
  /// exist.
  ///
  /// The returned signed url expires after 20 minutes.
  Future<String> getV4BuildUploadSignedUrl(String projectId, String apiKey);

  factory CloudFunctionsService.makeInstance() {
    return _CloudFunctionsService();
  }
}

class _CloudFunctionsService implements CloudFunctionsService {
  @override
  Future<String> getV4BuildUploadSignedUrl(String projectId, String apiKey) {
    // TODO: implement getV4BuildUploadSignedUrl
    throw UnimplementedError();
  }
}
