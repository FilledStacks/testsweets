import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:testsweets/testsweets.dart';

import 'app/app.locator.dart';
import 'app/app.router.dart';

const bool FLUTTER_DRIVER = bool.fromEnvironment(
  'FLUTTER_DRIVER',
  defaultValue: true,
);

Future<void> main() async {
  if (FLUTTER_DRIVER) {
    enableFlutterDriverExtension();
  }

  await setupTestSweets();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: (context, child) => TestSweetsOverlayView(
        projectId: '5EEL6eC4M7DK80Tu49bd',
        child: child!,
        captureWidgets: true,
      ),
      initialRoute: Routes.signUpView,
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorObservers: [
        TestSweetsNavigatorObserver(),
      ],
    );
  }
}
