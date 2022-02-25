import 'dart:async';

import 'package:testsweets/testsweets.dart';

import 'sweetcore_command.dart';

class WidgetVisibiltyChangerService {
  final Completer completer = Completer();

  SweetcoreCommand? sweetcoreCommand;

  void completeCompleter() {
    /// This message is not used right now but I'll leave it here
    /// incase we want to debug the returned message in the [DriverManager]
    completer.complete('success');
  }

  Iterable<WidgetDescription>? toggleVisibilty(
      Iterable<WidgetDescription> widgetDescriptions) {
    if (sweetcoreCommand == null) return null;

    completeCompleter();

    return widgetDescriptions.map((e) => e.copyWith(visibility: !e.visibility));
  }
}
