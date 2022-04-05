import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:testsweets/src/constants/app_constants.dart';
import 'package:testsweets/src/locator.dart';

import 'services/test_integrity.dart';
// import 'package:testsweets/src/services/widget_visibilty_changer_service.dart';
// import 'package:testsweets/src/services/sweetcore_command.dart';

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
        }
        return 'message is null $message';
      },
    );
  }
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
          'We couldn\'t extract the command from this message: $message');
  }
}
