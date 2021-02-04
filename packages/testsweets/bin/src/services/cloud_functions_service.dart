import '../locator.dart';
import 'http_service.dart';

abstract class CloudFunctionsService {
  Future<String> getV4BuildUploadSignedUrl(String projectId, String apiKey,
      [Map extensionHeaders = const <String, String>{}]);

  factory CloudFunctionsService.makeInstance() {
    return _CloudFunctionsService();
  }
}

class _CloudFunctionsService implements CloudFunctionsService {
  final httpService = locator<HttpService>();

  @override
  Future<String> getV4BuildUploadSignedUrl(String projectId, String apiKey,
      [Map extensionHeaders = const <String, String>{}]) async {
    final endpoint =
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
}
