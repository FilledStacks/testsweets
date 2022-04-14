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
    ];
    List<Color> colorItems2 = [
      Colors.purple,
      Colors.orange,
      Colors.blueGrey,
    ];

    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, model, child) {
        final size = MediaQuery.of(context).size;

        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              Container(
                height: size.height,
                child: ListView(
                  children: [
                    Container(
                      height: 500,
                      color: colorItems2[2],
                    ),
                    Container(
                      height: 150,
                      color: Colors.white,
                      child: ListView.builder(
                        controller: ScrollController(),
                        itemCount: colorItems.length,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.all(10),
                        itemBuilder: (context, index) => Container(
                          width: 150,
                          color: colorItems[index],
                        ),
                      ),
                    ),
                    Container(
                      height: 500,
                      color: colorItems2[2],
                    ),
                    MaterialButton(
                      color: Colors.blue,
                      child: Text(
                        'Go to Home',
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: model.navigateToOtherView,
                    ),
                    Container(
                      height: 150,
                      color: Colors.white,
                      child: ListView.builder(
                        controller: ScrollController(),
                        itemCount: colorItems.length,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.all(10),
                        itemBuilder: (context, index) => Container(
                          width: 150,
                          color: colorItems2[index],
                        ),
                      ),
                    ),
                    Container(
                      height: 500,
                      color: colorItems2[2],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}
