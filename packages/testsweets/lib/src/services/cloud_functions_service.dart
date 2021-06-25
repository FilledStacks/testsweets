import '../locator.dart';
import 'http_service.dart';

abstract class CloudFunctionsService {
  Future<String> getV4BuildUploadSignedUrl(String projectId, String apiKey,
      [Map extensionHeaders = const <String, String>{}]);

  Future<void> uploadAutomationKeys(
    String projectId,
    String apiKey,
    List<String> automationKeys,
  );

  Future<bool> doesBuildExistInProject(String projectId,
      {required String withVersion});
}

class CloudFunctionsServiceImplementation implements CloudFunctionsService {
  final httpService = locator<HttpService>();

  @override
  Future<String> getV4BuildUploadSignedUrl(String projectId, String apiKey,
      [Map extensionHeaders = const <String, String>{}]) async {
    final endpoint =
        // 'https://us-central1-testsweets-38348.cloudfunctions.net/projects-api/createUploadUrlForBuild';
        'https://us-central1-testsweets-38348.cloudfunctions.net/getV4BuildUploadSignedUrl';
    final ret = await httpService.postJson(to: endpoint, body: {
      'projectId': projectId,
      'apiKey': apiKey,
      'extensionHeaders': extensionHeaders,
    });

    if (ret.statusCode == 500) {
      throw ret.parseBodyAsJsonMap();
    } else if (ret.statusCode == 200) {
      return ret.parseBodyAsJsonMap()['url'];
    } else
      throw ret.body;
  }

  @override
  Future<void> uploadAutomationKeys(
      String projectId, String apiKey, List<String> automationKeys) async {
    final endpoint =
        'https://us-central1-testsweets-38348.cloudfunctions.net/projects-api/uploadAutomationKeys';

    final ret = await httpService.postJson(to: endpoint, body: {
      'projectId': projectId,
      'automationKeys': automationKeys,
    });

    if (ret.statusCode != 200) throw ret.body;
  }

  @override
  Future<bool> doesBuildExistInProject(String projectId,
      {required String withVersion}) async {
    final endpoint =
        'https://us-central1-testsweets-38348.cloudfunctions.net/doesBuildWithGivenVersionExist';
    final ret = await httpService.postJson(to: endpoint, body: {
      'projectId': projectId,
      'version': withVersion,
    });

    if (ret.statusCode == 200) return ret.parseBodyAsJsonMap()['exists'];

    throw ret.body;
  }
}
