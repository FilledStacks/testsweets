import 'package:flutter_driver/driver_extension.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/services/widget_visibilty_changer_service.dart';
import 'package:testsweets/src/services/sweetcore_command.dart';

const bool DRIVE_MODE = bool.fromEnvironment(
  'DRIVE_MODE',
  defaultValue: false,
);

Future<void> setupTestSweets() async {
  await setupLocator();

  if (DRIVE_MODE) {
    enableFlutterDriverExtension(
      handler: (message) async {
        ///
        /// take this message and await till the appropriate notification
        /// arrives to the  notification listener of the driver layout
        ///
        if (message != null) {
          final widgetVisibiltyChangerService =
              locator<WidgetVisibiltyChangerService>();
          widgetVisibiltyChangerService.automationKeyName =
              SweetcoreCommand.fromString(message);

          return await widgetVisibiltyChangerService.completer.future;
        }
        return 'Message is null';
      },
    );
  }
}
