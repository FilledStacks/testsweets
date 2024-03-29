import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:testsweets/src/app/logger.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/extensions/string_extension.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/services/cloud_functions_service.dart';
import 'package:testsweets/src/services/testsweets_route_tracker.dart';
import 'package:testsweets/src/utils/batch_processing/batch_processors.dart';
import 'package:testsweets/testsweets.dart';

/// A service that facilitates the capturing of widgets on device
class WidgetCaptureService {
  final log = getLogger('WidgetCaptureService');

  final _cloudFunctionsService = locator<CloudFunctionsService>();
  final _testSweetRouteTracker = locator<TestSweetsRouteTracker>();
  final _interactionsProcess = locator<InteractionsProcessor>();

  @visibleForTesting
  final widgetDescriptionMap = Map<String, List<Interaction>>();

  late String _projectId;

  set projectId(String projectId) {
    _projectId = projectId;
  }

  String get projectId => _projectId;

  WidgetCaptureService() {
    _interactionsProcess.batchProcessingStream.listen((eventsToProcess) {
      print('🍬 TESTSWEETS - Submit interactions $eventsToProcess');
      // _httpService.captureInteractions(
      //   projectId: projectId,
      //   events: eventsToProcess,
      // );
    });
  }

  /// Gets all the widget descriptions the project and stores them in a map
  Future<void> loadWidgetDescriptionsForProject({
    required Size size,
    required Orientation orientation,
  }) async {
    final widgetDescriptions =
        await _cloudFunctionsService.getWidgetDescriptionForProject(
      projectId: _projectId,
    );

    widgetDescriptionMap.clear();

    for (final description in widgetDescriptions) {
      addWidgetDescriptionToMap(description.setActivePosition(
        size: size,
        orientation: orientation,
      ));
    }
  }

  void addWidgetDescriptionToMap(Interaction description) {
    log.v(description);
    if (widgetDescriptionMap.containsKey(description.originalViewName)) {
      widgetDescriptionMap[description.originalViewName]?.add(description);
    } else {
      widgetDescriptionMap[description.originalViewName] = [description];
    }
  }

  Future<void> autoCaptureInteraction({
    required WidgetType type,
    required Offset position,
    required Size size,
    required Orientation orientation,
  }) async {
    final interaction = Interaction(
      widgetType: type,
      originalViewName: _testSweetRouteTracker.currentRoute,
      viewName: _testSweetRouteTracker.formatedCurrentRoute,
      widgetPositions: [
        WidgetPosition(
          x: position.dx,
          y: position.dy,
          capturedDeviceWidth: size.width,
          capturedDeviceHeight: size.height,
          orientation: orientation,
        )
      ],
    );

    _interactionsProcess.addItem(interaction.setActivePosition(
      size: size,
      orientation: orientation,
    ));
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

  Future<void> updateInteractionInDatabase({
    required Interaction updatedInteraction,
  }) async {
    log.i('updatedinteraction:$updatedInteraction projectId:$_projectId');

    await _cloudFunctionsService.updateInteraction(
      projectId: _projectId,
      interaction: updatedInteraction,
    );
  }

  Future<void> removeInteractionFromDatabase(Interaction interaction) async {
    log.i('Remove $interaction from DB');

    final interactionId = await _cloudFunctionsService.deleteWidgetDescription(
        projectId: _projectId, description: interaction);

    log.v('Remove interaction that have id: $interactionId from database');
  }

  Future<Interaction> captureView(String originalViewName) async {
    log.i('originalViewName:$originalViewName projectId:$_projectId');

    final viewInteraction = Interaction.view(
      viewName: originalViewName.convertViewNameToValidFormat,
      originalViewName: originalViewName,
    );

    final interactionId =
        await _cloudFunctionsService.uploadWidgetDescriptionToProject(
      projectId: _projectId,
      description: viewInteraction,
    );
    log.v('interactionId from Cloud: $interactionId');

    return viewInteraction.copyWith(id: interactionId);
  }

  List<Interaction> getDescriptionsForView({required String currentRoute}) {
    var viewDescriptions = widgetDescriptionMap[currentRoute];
    log.v(
      'currentRoute:$currentRoute viewDescriptions:${viewDescriptions?.join('\n')}',
    );

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
    log.i('In $routeName: ${interactions.length} ');
    widgetDescriptionMap[routeName] = interactions;
    log.i('Out $routeName: ${interactions.length} ');
  }
}
