import 'package:testsweets/src/models/application_models.dart';

import '../locator.dart';
import 'http_service.dart';

class CloudFunctionsService {
  final httpService = locator<HttpService>();

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

  Future<void> uploadAutomationKeys(
    String projectId,
    String apiKey,
    List<String> automationKeys,
  ) async {
    final endpoint =
        'https://us-central1-testsweets-38348.cloudfunctions.net/projects-api/uploadAutomationKeys';

    final ret = await httpService.postJson(to: endpoint, body: {
      'projectId': projectId,
      'automationKeys': automationKeys,
    });

    if (ret.statusCode != 200) throw ret.body;
  }

  Future<bool> doesBuildExistInProject(
    String projectId, {
    required String withVersion,
  }) async {
    final endpoint =
        'https://us-central1-testsweets-38348.cloudfunctions.net/doesBuildWithGivenVersionExist';
    final ret = await httpService.postJson(
      to: endpoint,
      body: {
        'projectId': projectId,
        'version': withVersion,
      },
    );

    if (ret.statusCode == 200) return ret.parseBodyAsJsonMap()['exists'];

    throw ret.body;
  }

  Future<String> uploadWidgetDescriptionToProject({
    required String projectId,
    required WidgetDescription description,
  }) async {
    final endpoint =
        'https://us-central1-testsweets-38348.cloudfunctions.net/uploadWidgetDescription';
    final ret = await httpService.postJson(
      to: endpoint,
      body: {
        'projectId': projectId,
        'widgetDescription': description.toJson(),
      },
    );

    if (ret.statusCode == 200) return ret.parseBodyAsJsonMap()['id'];

    throw ret.body;
  }
}
