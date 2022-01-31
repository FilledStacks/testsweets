import 'package:testsweets/src/app/logger.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:testsweets/src/services/cloud_functions_service.dart';

/// A service that facilitates the capturing of widgets on device
class WidgetCaptureService {
  final log = getLogger('WidgetCaptureService');

  final _cloudFunctionsService = locator<CloudFunctionsService>();

  final Map<String, List<WidgetDescription>> widgetDescriptionMap =
      Map<String, List<WidgetDescription>>();
  final bool verbose;

  WidgetCaptureService({this.verbose = false});

  /// Captures a widgets description to the backend as well as locally in the [widgetDescriptionMap]
  Future<void> captureWidgetDescription({
    required WidgetDescription description,
    required String projectId,
  }) async {
    log.i('description:$description projectId:$projectId');
    final descriptionId =
        await _cloudFunctionsService.uploadWidgetDescriptionToProject(
      projectId: projectId,
      description: description,
    );

    log.i('descriptionId from Cloud: $descriptionId');

    addWidgetDescriptionToMap(
        description: description.copyWith(id: descriptionId));
  }

  /// Gets all the widget descriptions the project and stores them in a map
  Future<void> loadWidgetDescriptionsForProject(
      {required String projectId}) async {
    final widgetDescriptions = await _cloudFunctionsService
        .getWidgetDescriptionForProject(projectId: projectId);
    widgetDescriptionMap.clear();
    for (final description in widgetDescriptions) {
      addWidgetDescriptionToMap(description: description);
    }
  }

  void addWidgetDescriptionToMap({required WidgetDescription description}) {
    if (widgetDescriptionMap.containsKey(description.originalViewName)) {
      widgetDescriptionMap[description.originalViewName]?.add(description);
    } else {
      widgetDescriptionMap[description.originalViewName!] = [description];
    }
  }

  List<WidgetDescription> getDescriptionsForView({
    required String currentRoute,
  }) {
    var viewDescriptions = widgetDescriptionMap[currentRoute];
    log.v('currentRoute:$currentRoute viewDescriptions:$viewDescriptions');

    final potentialParentRoute = currentRoute.replaceAll(RegExp('[0-9]'), '');

    if (currentRoute != potentialParentRoute) {
      final additionalDescriptions = widgetDescriptionMap[potentialParentRoute];
      if (additionalDescriptions != null) {
        log.v('Parent route has descriptions: $potentialParentRoute');

        viewDescriptions = [...?viewDescriptions, ...additionalDescriptions];
      }
    }

    return viewDescriptions ?? [];
  }

  bool checkCurrentViewIfAlreadyCaptured(String originalViewName) =>
      widgetDescriptionMap.containsKey(originalViewName)
          ? widgetDescriptionMap[originalViewName]!
              .any((element) => element.name == '')
          : false;

  /// Updates a widget description to the backend as well as locally in the [widgetDescriptionMap]
  Future<void> updateWidgetDescription({
    required WidgetDescription description,
    required String projectId,
  }) async {
    log.i('description:$description projectId:$projectId');

    final widgetToUpdate = widgetDescriptionMap[description.originalViewName]
        ?.firstWhere((element) => element.id == description.id);

    final descriptionId = await _cloudFunctionsService.updateWidgetDescription(
        projectId: projectId,
        newwidgetDescription: description,
        oldwidgetDescription: widgetToUpdate!);

    log.i('descriptionId from Cloud: $descriptionId');
  }

  /// Delete a widget descriptions from the project as well as locally
  Future<void> deleteWidgetDescription(
      {required String projectId,
      required WidgetDescription description}) async {
    final descriptionId = await _cloudFunctionsService.deleteWidgetDescription(
        projectId: projectId, description: description);

    log.i('descriptionId from Cloud: $descriptionId');
  }
}
