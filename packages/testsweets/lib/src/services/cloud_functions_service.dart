import 'dart:convert';

import 'package:testsweets/src/app/logger.dart';
import 'package:testsweets/src/models/application_models.dart';

import 'http_service.dart';

class CloudFunctionsService {
  final log = getLogger('CloudFunctionsService');

  // This service is being passed in here because we can't get it from the locator
  // given that when running the command we need the dartOnlyLocator and when running
  // and using the package we need the normal flutter locator
  final HttpService httpService;
  CloudFunctionsService({required this.httpService});

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
    log.i('WidgetDescription:$description , projectId:$projectId');

    final endpoint =
        'https://us-central1-testsweets-38348.cloudfunctions.net/projects-api/uploadWidgetDescription';

    final response = await httpService.postJson(
      to: endpoint,
      body: {
        'projectId': projectId,
        'widgetDescription': description.toJson(),
      },
    );

    log.i(
        'uploadWidgetDescriptionToProject response. ${response.statusCode} - ${response.body}');

    if (response.statusCode == 200) return response.parseBodyAsJsonMap()['id'];

    throw Exception(response.body);
  }

  Future<List<WidgetDescription>> getWidgetDescriptionForProject({
    required String projectId,
  }) async {
    log.i('projectId:$projectId');

    final endpoint =
        'https://us-central1-testsweets-38348.cloudfunctions.net/projects-api/getWidgetDescription?projectId=$projectId';

    final response = await httpService.get(to: endpoint);

    if (response.statusCode == 200) {
      log.i('getWidgetDescriptionForProject | fetch success! Lets serialise');
      final jsonContent = response.body;
      final descriptionsJson = json.decode(jsonContent) as Iterable;
      return descriptionsJson
          .map((e) => WidgetDescription.fromJson(e))
          .toList();
    }

    throw Exception(response.body);
  }

  Future<String> updateWidgetDescription({
    required String projectId,
    required WidgetDescription oldwidgetDescription,
    required WidgetDescription newwidgetDescription,
  }) async {
    log.i(
        'oldwidgetDescription:$oldwidgetDescription, newwidgetDescription:$newwidgetDescription, projectId:$projectId');

    final endpoint =
        'https://us-central1-testsweets-38348.cloudfunctions.net/projects-api/updateWidgetDescription';

    final response = await httpService.postJson(
      to: endpoint,
      body: {
        'projectId': projectId,
        'newwidgetDescription': newwidgetDescription.toJson(),
        'oldwidgetDescription': oldwidgetDescription.toJson(),
      },
    );

    if (response.statusCode == 200) {
      log.i('updateWidgetDescription | Success!');
      return response.parseBodyAsJsonMap()['id'];
    }

    throw Exception(response.body);
  }

  Future<String> deleteWidgetDescription({
    required String projectId,
    required WidgetDescription description,
  }) async {
    log.i('WidgetDescription:$description , projectId:$projectId');

    final endpoint =
        'https://us-central1-testsweets-38348.cloudfunctions.net/projects-api/deleteWidgetDescription';

    final response = await httpService.postJson(
      to: endpoint,
      body: {
        'projectId': projectId,
        'widgetDescription': description.toJson(),
      },
    );

    if (response.statusCode == 200) {
      log.i('deleteWidgetDescription | Success!');
      return response.parseBodyAsJsonMap()['id'];
    }

    throw Exception(response.body);
  }
}
