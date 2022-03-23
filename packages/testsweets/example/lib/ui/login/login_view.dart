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
                    ...List.generate(
                      3,
                      (index) => Container(
                        height: 500,
                        color: colorItems[index],
                      ),
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
                    ...List.generate(
                      3,
                      (index) => Container(
                        height: 500,
                        color: colorItems[index],
                      ),
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
