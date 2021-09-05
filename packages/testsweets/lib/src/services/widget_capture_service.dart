import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:testsweets/src/services/cloud_functions_service.dart';
import 'package:testsweets/src/services/test_sweets_config_file_service.dart';

/// A service that facilitates the capturing of widgets on device
class WidgetCaptureService {
  final _cloudFunctionsService = locator<CloudFunctionsService>();
  final _testSweetsConfigFileService = locator<TestSweetsConfigFileService>();

  final Map<String, WidgetDescription> widgetDescriptionMap =
      Map<String, WidgetDescription>();
  final bool verbose;

  WidgetCaptureService({this.verbose = false});

  /// Captures a widgets description to the backend as well as locally in the [widgetDescriptionMap]
  Future<void> captureWidgetDescription({
    required WidgetDescription description,
  }) async {
    log('description: $description');

    final projectId = _testSweetsConfigFileService
        .getValueFromConfigFileByKey(ConfigFileKeyType.ProjectId);

    final descriptionId =
        await _cloudFunctionsService.uploadWidgetDescriptionToProject(
      projectId: projectId,
      description: description,
    );

    log('descriptionId from Cloud: $descriptionId');

    widgetDescriptionMap[description.viewName] =
        description.copyWith(id: descriptionId);
  }

  void log(String message) {
    if (verbose) print('captureWidgetDescription | $message');
  }
}
