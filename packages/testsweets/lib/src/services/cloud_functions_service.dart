import '../locator.dart';
import 'http_service.dart';

abstract class CloudFunctionsService {
  Future<String> getV4BuildUploadSignedUrl(String projectId, String apiKey,
      [Map<String, String> extensionHeaders = const <String, String>{}]);

  Future<void> uploadAutomationKeys(
    String projectId,
    String apiKey,
    List<String> automationKeys,
  );

  Future<bool> doesBuildExistInProject(String projectId,
      {required String withVersion});

  factory CloudFunctionsService.makeInstance() {
    return _CloudFunctionsService();
  }
}

class _CloudFunctionsService implements CloudFunctionsService {
  final httpService = locator<HttpService>();

  @override
  Future<String> getV4BuildUploadSignedUrl(String projectId, String apiKey,
      [Map<String, String> extensionHeaders = const <String, String>{}]) async {
    final queryParameters = extensionHeaders.keys.map(
        (key) => '$key=${Uri.encodeQueryComponent(extensionHeaders[key]!)}');

    final endpoint =
        'https://us-central1-testsweets-38348.cloudfunctions.net/projects-api/getUploadUrlForBuild?projectId=$projectId&${queryParameters.join('&')}';
    print('Get signed url from $endpoint');
    print('');
    final ret = await httpService.get(to: endpoint);

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
