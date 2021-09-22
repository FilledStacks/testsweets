import 'package:example/app/app.router.dart';
import 'package:example/ui/main/main_viewmodel.dart';
import 'package:example/ui/post/post_view.dart';
import 'package:example/ui/todo/todo_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:testsweets/testsweets.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigatorObserver = TestSweetsNavigatorObserver();

    return ViewModelBuilder<MainViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: getViewForIndex(model.currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          currentIndex: model.currentIndex,
          onTap: (index) {
            model.setIndex(index);
            navigatorObserver.setBottomNavIndex(
              btmNavBarName: Routes.mainView,
              index: index,
            );
          },
          items: [
            BottomNavigationBarItem(
              label: 'post',
              icon: Icon(Icons.post_add),
            ),
            BottomNavigationBarItem(
              label: 'Todo',
              icon: Icon(Icons.list),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => MainViewModel(),
    );
  }

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return PostView();
      case 1:
        return TodoView();
      default:
        return PostView();
    }
  }
}
