import 'package:flutter_driver/driver_extension.dart';
import 'package:testsweets/src/locator.dart';

const bool DRIVE_MODE = bool.fromEnvironment(
  'DRIVE_MODE',
  defaultValue: false,
);

Future<void> setupTestSweets() async {
  if (DRIVE_MODE) {
    enableFlutterDriverExtension();
  }

  await setupLocator();
}
