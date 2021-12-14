import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'login_viewmodel.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Color> colorItems = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.purple,
      Colors.orange,
      Colors.black,
    ];

    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 150,
              child: Scrollbar(
                isAlwaysShown: true,
                child: ListView.builder(
                  itemCount: colorItems.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(10),
                  itemBuilder: (context, index) => Container(
                    width: 150,
                    color: colorItems[index],
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  TextField(
                      decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.red, width: 3.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.red, width: 3.0),
                    ),
                  )),
                  MaterialButton(
                    color: Colors.blue,
                    child: Text(
                      'Go to Home',
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: model.navigateToOtherView,
                  ),
                ],
              ),
            ),
            Container(
              height: 200,
              child: Scrollbar(
                child: ListView.builder(
                  itemCount: colorItems.length,
                  padding: EdgeInsets.all(10),
                  itemBuilder: (context, index) => Container(
                    height: 50,
                    color: colorItems[index],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}
