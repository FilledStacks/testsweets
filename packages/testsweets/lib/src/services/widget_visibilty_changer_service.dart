import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:testsweets/src/app/logger.dart';
import 'package:testsweets/src/enums/handler_message_response.dart';
import 'package:testsweets/testsweets.dart';
import 'sweetcore_command.dart';

class WidgetVisibiltyChangerService {
  final log = getLogger('WidgetVisibiltyChangerService');

  Completer? completer;

  SweetcoreCommand? sweetcoreCommand;

  void completeCompleter(HandlerMessageResponse message) {
    log.i(message);

    /// Reset the sweetcore command to prevent duplicated calls
    /// incase there is another scroll event
    sweetcoreCommand = null;

    /// This message is not used right now but I'll leave it here
    /// incase we want to debug the returned message in the [DriverManager]
    completer!.complete(message.name);
  }

  Iterable<WidgetDescription>? runToggleVisibiltyChecker(
      Notification notification,
      String automationKeyName,
      List<WidgetDescription> viewWidgets) {
    final targetedWidgets =
        filterTargetedWidgets(automationKeyName, viewWidgets);

    if (targetedWidgets.isEmpty) {
      completeCompleter(HandlerMessageResponse.foundAutomationKeyWithNoTargets);
      return null;
    } else {
      completeCompleter(HandlerMessageResponse.foundAutomationKeyWithTargets);
      return toggleVisibilty(targetedWidgets, viewWidgets);
    }
  }

  Iterable<WidgetDescription> toggleVisibilty(
      Iterable<WidgetDescription> targetedWidgets,
      List<WidgetDescription> originalWidgets) {
    log.i(targetedWidgets);

    final toggledWidgets =
        targetedWidgets.map((e) => e.copyWith(visibility: !e.visibility));

    return updateViewWidgetsList(toggledWidgets, originalWidgets);
  }

  Iterable<WidgetDescription> updateViewWidgetsList(
      Iterable<WidgetDescription> widgetAfterToggleVisibilty,
      List<WidgetDescription> originalWidgets) {
    for (var widget in widgetAfterToggleVisibilty) {
      final widgetIndex =
          originalWidgets.indexWhere((element) => element.id == widget.id);
      originalWidgets[widgetIndex] = widget;
    }
    return originalWidgets;
  }

  Iterable<WidgetDescription> filterTargetedWidgets(String automationKeyName,
      Iterable<WidgetDescription> descriptionsForView) {
    final triggerWidget = descriptionsForView.firstWhere(
      (element) => element.automationKey == automationKeyName,
    );
    return descriptionsForView
        .where((element) => triggerWidget.targetIds.contains(element.id));
  }
}
