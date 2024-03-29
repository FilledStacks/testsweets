import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:testsweets/src/constants/app_constants.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/services/local_config_service.dart';

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

bool get tsCaptureModeActive =>
    FORCE_CAPTURE_MODE || locator<LocalConfigService>().captureMode;

Future<void> setupTestSweets({bool enabled = TEST_SWEETS_ENABLED}) async {
  await setupLocator();

  await locator<LocalConfigService>().setEnable(enabled);

  if (!enabled || tsCaptureModeActive) return;

  enableFlutterDriverExtension(
    handler: (message) async {
      ///
      /// take this message and await till the appropriate notification
      /// arrives to the  notification listener of the driver layout
      ///
      if (message == null) return 'message is null $message';

      final testIntegrity = locator<TestIntegrity>();

      testIntegrity.triggeringNotificationType =
          _getNotificationTypeFromCommandMessage(message);

      return await testIntegrity
          .trueIfCommandVerifiedOrFalseIfTimeout(
            TEST_INTEGRITY_TIMEOUT,
          )
          .then<String>(
            (value) => value.toString(),
          );
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
