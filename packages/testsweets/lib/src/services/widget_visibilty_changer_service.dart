import 'package:testsweets/testsweets.dart';

import 'sweetcore_command.dart';

class WidgetVisibiltyChangerService {
  SweetcoreCommand? latestSweetcoreCommand;
  WidgetDescription? execute(WidgetDescription widgetDescription) {
    if (latestSweetcoreCommand == null) return null;

    return widgetDescription.copyWith(
        visibility: !widgetDescription.visibility);
  }
}
