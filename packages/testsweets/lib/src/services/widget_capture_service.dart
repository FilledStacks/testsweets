import 'package:flutter/material.dart';
import 'package:testsweets/src/app/logger.dart';
import 'package:testsweets/src/extensions/string_extension.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:testsweets/src/services/cloud_functions_service.dart';

/// A service that facilitates the capturing of widgets on device
class WidgetCaptureService {
  final log = getLogger('WidgetCaptureService');

  final _cloudFunctionsService = locator<CloudFunctionsService>();

  @visibleForTesting
  final widgetDescriptionMap = Map<String, List<Interaction>>();
  late String _projectId;

  set projectId(String projectId) {
    _projectId = projectId;
  }

  final bool verbose;
  WidgetCaptureService({this.verbose = false}) {
    if (verbose) {
      projectId = 'projectId';
    }
  }

  /// Gets all the widget descriptions the project and stores them in a map
  Future<void> loadWidgetDescriptionsForProject() async {
    final widgetDescriptions = await _cloudFunctionsService
        .getWidgetDescriptionForProject(projectId: _projectId);

    widgetDescriptionMap.clear();

    for (final description in widgetDescriptions) {
      addWidgetDescriptionToMap = description;
    }
  }

  set addWidgetDescriptionToMap(Interaction description) {
    log.v(description);
    if (widgetDescriptionMap.containsKey(description.originalViewName)) {
      widgetDescriptionMap[description.originalViewName]?.add(description);
    } else {
      widgetDescriptionMap[description.originalViewName] = [description];
    }
  }

  Future<Interaction> saveInteractionInDatabase(Interaction interaction) async {
    log.i('interaction:$interaction projectId:$_projectId');

    final interactionId =
        await _cloudFunctionsService.uploadWidgetDescriptionToProject(
      projectId: _projectId,
      description: interaction,
    );

    log.i('interactionId from Cloud: $interactionId');
    return interaction.copyWith(id: interactionId);
  }

  Future<void> updateInteractionInDatabase(Interaction interaction) async {
    log.i('interaction:$interaction projectId:$_projectId');

    final interactionToUpdate =
        widgetDescriptionMap[interaction.originalViewName]
            ?.firstWhere((element) => element.id == interaction.id);

    await _cloudFunctionsService.updateWidgetDescription(
        projectId: _projectId,
        newwidgetDescription: interaction,
        oldwidgetDescription: interactionToUpdate!);
  }

  /// Delete a widget descriptions from the project as well as locally
  Future<String?> removeWidgetDescription(
      {required Interaction description}) async {
    try {
      final interactionId =
          await _cloudFunctionsService.deleteWidgetDescription(
              projectId: _projectId, description: description);

      log.i('interactionId from Cloud: $interactionId');
      return null;
    } catch (e) {
      log.e(e);
      return e.toString();
    }
  }

  Future<Interaction?> checkViewIfExistOrCaptureIt(
      String originalViewName) async {
    if (!checkCurrentViewIfAlreadyCaptured(originalViewName)) {
      log.i('originalViewName:$originalViewName projectId:$_projectId');

      final viewInteraction = Interaction.view(
          viewName: originalViewName.convertViewNameToValidFormat,
          originalViewName: originalViewName);

      final interactionId =
          await _cloudFunctionsService.uploadWidgetDescriptionToProject(
        projectId: _projectId,
        description: viewInteraction,
      );
      log.v('interactionId from Cloud: $interactionId');

      return viewInteraction.copyWith(id: interactionId);
    } else {
      return null;
    }
  }

  List<Interaction> getDescriptionsForView({required String currentRoute}) {
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

  void syncRouteInteractions(String routeName, List<Interaction> interactions) {
    widgetDescriptionMap.update(
      routeName,
      (_) => interactions,
      ifAbsent: () => interactions,
    );
  }
}
