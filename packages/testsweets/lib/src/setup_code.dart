import 'package:flutter_driver/driver_extension.dart';
import 'package:testsweets/src/locator.dart';

const bool FLUTTER_DRIVER = bool.fromEnvironment(
  'FLUTTER_DRIVER',
  defaultValue: false,
);
Future<void> setupTestSweets() async {
  if (FLUTTER_DRIVER) {
    enableFlutterDriverExtension();
  }
  await setupLocator();
}
