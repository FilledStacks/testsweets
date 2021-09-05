import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:testsweets/src/services/cloud_functions_service.dart';
import 'package:testsweets/src/services/test_sweets_config_file_service.dart';

/// A service that facilitates the capturing of widgets on device
class WidgetCaptureService {
  final _cloudFunctionsService = locator<CloudFunctionsService>();
  final _testSweetsConfigFileService = locator<TestSweetsConfigFileService>();

  final Map<String, List<WidgetDescription>> widgetDescriptionMap =
      Map<String, List<WidgetDescription>>();
  final bool verbose;

  WidgetCaptureService({this.verbose = false});

  /// Captures a widgets description to the backend as well as locally in the [widgetDescriptionMap]
  Future<void> captureWidgetDescription({
    required WidgetDescription description,
    required String projectId,
  }) async {
    log('description:$description projectId:$projectId');

    final descriptionId =
        await _cloudFunctionsService.uploadWidgetDescriptionToProject(
      projectId: projectId,
      description: description,
    );

    log('descriptionId from Cloud: $descriptionId');

    addWidgetDescriptionToMap(description.copyWith(id: descriptionId));
  }

  /// Gets all the widget descriptions the project and stores them in a map
  Future<void> loadWidgetDescriptions({required String projectId}) async {
    final widgetDescriptions = await _cloudFunctionsService
        .getWidgetDescriptionForProject(projectId: projectId);

    for (final description in widgetDescriptions) {
      addWidgetDescriptionToMap(description);
    }
  }

  void addWidgetDescriptionToMap(WidgetDescription description) {
    if (widgetDescriptionMap.containsKey(description.viewName)) {
      widgetDescriptionMap[description.viewName]?.add(description);
    } else {
      widgetDescriptionMap[description.viewName] = [description];
    }
  }

  void log(String message) {
    if (verbose) print('captureWidgetDescription | $message');
  }
}
