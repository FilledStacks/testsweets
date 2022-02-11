import 'dart:async';

import 'package:testsweets/testsweets.dart';

import 'sweetcore_command.dart';

class WidgetVisibiltyChangerService {
  final Completer completer = Completer();

  SweetcoreCommand? latestSweetcoreCommand;

  Iterable<WidgetDescription>? toggleVisibilty(
      Iterable<WidgetDescription> widgetDescriptions) {
    if (latestSweetcoreCommand == null) return null;

    /// This message is not used right now but I'll leave it here
    /// incase we want to debug the returned message in the [DriverManager]
    completer.complete('success');
    return widgetDescriptions.map((e) => e.copyWith(visibility: !e.visibility));
  }
}
