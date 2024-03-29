import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:testsweets/src/constants/app_constants.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/services/events_service.dart';
import 'package:testsweets/src/services/local_config_service.dart';
import 'package:testsweets/src/services/run_configuration_service.dart';
import 'package:testsweets_shared/testsweets_shared.dart';

import 'services/test_integrity.dart';
// import 'package:testsweets/src/services/widget_visibilty_changer_service.dart';
// import 'package:testsweets/src/services/sweetcore_command.dart';

@Deprecated(
    '''With the ability to swap between capture and automate this value is not required anymore
    
    You can use tsCaptureModelActive to check if the app is in capture mode
    ''')
const bool DRIVE_MODE = bool.fromEnvironment(
  'DRIVE_MODE',
  defaultValue: false,
);

const bool FORCE_CAPTURE_MODE = bool.fromEnvironment(
  'FORCE_CAPTURE_MODE',
  defaultValue: false,
);

const bool TEST_SWEETS_ENABLED = bool.fromEnvironment(
  'TEST_SWEETS_ENABLED',
  defaultValue: !kReleaseMode,
);

Future<void> setupTestSweets({bool enabled = TEST_SWEETS_ENABLED}) async {
  await setupLocator();

  await locator<LocalConfigService>().setEnable(enabled);

  if (!enabled) return;

  enableFlutterDriverExtension(
    enableTextEntryEmulation: false,
    handler: (message) async {
      ///
      /// take this message and await till the appropriate notification
      /// arrives to the  notification listener of the driver layout
      ///
      if (message == null) return 'message is null $message';

      // Expect command updates
      // 1. Create DriverCommand model
      // - type: expectEvent, testIntegrity
      // - data: Map<String, dynamic>
      //    - testIntegrity: { name: string }
      //    - exptectEvent: { name: string, value: dynamic }

      final driverCommand = DriverCommand.fromJson(json.decode(message));

      switch (driverCommand.type) {
        case DriverCommandType.testIntegrity:
          final testIntegrity = locator<TestIntegrity>();

          testIntegrity.triggeringNotificationType =
              _getNotificationTypeFromCommandMessage(message);

          return await testIntegrity
              .trueIfCommandVerifiedOrFalseIfTimeout(
            TEST_INTEGRITY_TIMEOUT,
          )
              .then<String>(
            (value) {
              final commandResult = DriverCommandResult(
                success: value,
                type: DriverCommandType.testIntegrity,
              );

              return json.encode(commandResult);
            },
          );
        case DriverCommandType.expectEvent:
          final eventService = locator<EventsService>();
          final expectEventData = ExpectEventDataModel.fromJson(
              driverCommand.value as Map<String, dynamic>);

          final eventMatch = eventService.matchEvent(
            name: driverCommand.name,
            key: expectEventData.key,
            value: expectEventData.value,
          );

          final commandResult = DriverCommandResult(
            type: DriverCommandType.expectEvent,
            success: eventMatch,
          );

          return json.encode(commandResult);

        case DriverCommandType.modeUpdate:
          locator<RunConfigurationService>().driveModeActive =
              driverCommand.value;

          final commandResult = DriverCommandResult(
            type: DriverCommandType.modeUpdate,
            success: true,
          );

          return json.encode(commandResult);
      }
    },
  );
}

Type _getNotificationTypeFromCommandMessage(String message) {
  final messageMap = json.decode(message) as Map<String, dynamic>;
  final commandType = messageMap['commandType'];
  switch (commandType) {
    case 'ScrollCommand':
      return ScrollStartNotification;
    case 'TapCommand':
    case 'EnterTextCommand':
      return KeepAliveNotification;
    default:
      throw Exception(
        'We couldn\'t extract the command from this message: $message',
      );
  }
}
