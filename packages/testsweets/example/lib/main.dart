import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:testsweets/testsweets.dart';

import 'app/app.locator.dart';
import 'app/app.router.dart';

Future<void> main() async {
  await setupTestSweets();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TestSweetsOverlayView(
      projectId: 'fGuFgPNXDnu56FEoe8Rn',
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: Routes.signUpView,
        navigatorKey: StackedService.navigatorKey,
        onGenerateRoute: StackedRouter().onGenerateRoute,
        navigatorObservers: [
          TestSweetsNavigatorObserver.instance,
        ],
      ),
    );
  }
}
