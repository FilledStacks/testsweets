import 'dart:convert';

import 'package:testsweets/src/app/logger.dart';
import 'package:testsweets/src/models/application_models.dart';

import '../locator.dart';
import 'http_service.dart';

class CloudFunctionsService {
  final log = getLogger('CloudFunctionsService');
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
        'https://us-central1-testsweets-38348.cloudfunctions.net/projects-api/uploadWidgetDescription';

    final response = await httpService.postJson(
      to: endpoint,
      body: {
        'projectId': projectId,
        'widgetDescription': description.toJson(),
      },
    );

    print(
        'uploadWidgetDescriptionToProject response. ${response.statusCode} - ${response.body}');

    if (response.statusCode == 200) return response.parseBodyAsJsonMap()['id'];

    throw Exception(response.body);
  }

  Future<List<WidgetDescription>> getWidgetDescriptionForProject({
    required String projectId,
  }) async { 
    log.i('projectId:$projectId');

    final endpoint =
        'https://us-central1-testsweets-38348.cloudfunctions.net/projects-api/getWidgetDescriptionsForProject?projectId=$projectId';

    final response = await httpService.get(to: endpoint);

    if (response.statusCode == 200) {
      print('getWidgetDescriptionForProject | fetch success! Lets serialise');
      final jsonContent = response.body;
      final descriptionsJson = json.decode(jsonContent) as Iterable;
      return descriptionsJson
          .map((e) => WidgetDescription.fromJson(e))
          .toList();
    }

    throw Exception(response.body);
  }
}
