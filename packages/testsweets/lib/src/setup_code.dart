import 'dart:async';

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
          final testIntegrity = locator.get<TestIntegrity>(param1: message);

          return await testIntegrity
              .startListeningReturnTrueIfCommandVerifiedOrFalseOnTimeout(
                  TEST_INTEGRITY_TIMEOUT)
              .then<String>((value) => value.toString());
        }
        return 'message is null $message';
      },
    );
  }
}
