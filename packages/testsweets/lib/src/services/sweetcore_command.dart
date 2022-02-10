import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:testsweets/src/enums/widget_type.dart';

part 'sweetcore_command.freezed.dart';

@freezed
class SweetcoreCommand with _$SweetcoreCommand {
  SweetcoreCommand._();
  factory SweetcoreCommand.scrollable({
    required String widgetName,
  }) = ScrollableCommand;

  factory SweetcoreCommand.fromString(String message) {
    final messageMap = json.decode(message) as Map<String, String>;
    final commandType = messageMap['commandType'];
    final widgetName = messageMap['widgetName'];
    switch (commandType) {
      case 'Scrollable':
        return SweetcoreCommand.scrollable(widgetName: widgetName!);
      default:
        throw Exception(
            'We couldn\'t recognize this command from this message: $message');
    }
  }
  WidgetType get toWidgetType {
    if (this is ScrollableCommand) return WidgetType.scrollable;

    return WidgetType.general;
  }
}
