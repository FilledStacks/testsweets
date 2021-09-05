import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'login_viewmodel.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: MaterialButton(
            color: Colors.blue,
            child: Text(
              'Go to Home',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: model.navigateToOtherView,
          ),
        ),
      ),
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}
