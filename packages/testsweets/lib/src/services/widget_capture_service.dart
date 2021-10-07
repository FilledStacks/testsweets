import 'package:testsweets/src/app/app.logger.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:testsweets/src/services/cloud_functions_service.dart';

/// A service that facilitates the capturing of widgets on device
class WidgetCaptureService {
  final log = getLogger('WidgetCaptureService');

  final _cloudFunctionsService = locator<CloudFunctionsService>();

  final List<WidgetDescription> widgetDescriptionsStore = [];
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
    widgetDescriptionsStore.clear();
    for (final description in widgetDescriptions) {
      addWidgetDescriptionToMap(description: description);
    }
  }

  void addWidgetDescriptionToMap({required WidgetDescription description}) {
    widgetDescriptionsStore.add(description);
  }

  List<WidgetDescription> getDescriptionsForView({
    required String currentRoute,
  }) {
    final matchedList = widgetDescriptionsStore
        .where((element) => element.originalViewName == currentRoute)
        .toList();

    // if any of the widgets view have a parentView we should add its widgets too
    if (matchedList.any((element) => element.originalParentViewName != null)) {
      log.v('Fetching parent view');
      final parentRoute = matchedList
          .firstWhere((element) => element.originalParentViewName != null)
          .originalParentViewName!;
      return matchedList + getDescriptionsForView(currentRoute: parentRoute);
    }

    log.v('currentRoute:$currentRoute matchedList:$matchedList');
    return matchedList;
  }

  bool checkCurrentViewIfAlreadyCaptured(String originalViewName) =>
      widgetDescriptionsStore
          .any((element) => element.originalViewName == originalViewName);

  /// Updates a widget description to the backend as well as locally in the [widgetDescriptionMap]
  Future<void> updateWidgetDescription({
    required WidgetDescription description,
    required String projectId,
  }) async {
    log.i('description:$description projectId:$projectId');

    final widgetToUpdate = widgetDescriptionsStore
        .firstWhere((element) => element.id == description.id);

    final descriptionId = await _cloudFunctionsService.updateWidgetDescription(
        projectId: projectId,
        newwidgetDescription: description,
        oldwidgetDescription: widgetToUpdate);

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
