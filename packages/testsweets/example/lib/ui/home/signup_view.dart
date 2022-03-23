import 'package:example/ui/signup/signup_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Color> colorItems = [
      Colors.purple,
      Colors.orange,
      Colors.black,
      Colors.red,
      Colors.blue,
    ];
    return ViewModelBuilder<SignUpViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Column(
          key: Key("ebraColumn1"),
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                  key: Key("ebralist1"),
                  itemCount: colorItems.length,
                  itemBuilder: (context, index) => Container(
                    width: 150,
                    height: 200,
                    color: colorItems[index],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: MaterialButton(
                  color: Colors.blue,
                  child: Text(
                    'Go to Login',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: model.navigateToOtherView,
                ),
              ),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => SignUpViewModel(),
    );
  }
}
