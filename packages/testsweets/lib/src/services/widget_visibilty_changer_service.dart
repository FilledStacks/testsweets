import 'dart:async';

import 'package:testsweets/testsweets.dart';

import 'sweetcore_command.dart';

class WidgetVisibiltyChangerService {
  final Completer completer = Completer();
  SweetcoreCommand? latestSweetcoreCommand;
  List<WidgetDescription>? execute(List<WidgetDescription> widgetDescriptions) {
    if (latestSweetcoreCommand == null) return null;
    completer.complete('success');
    return widgetDescriptions
        .map((e) => e.copyWith(visibility: !e.visibility))
        .toList();
  }
}
