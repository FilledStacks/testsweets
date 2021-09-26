import 'package:example/ui/todo/todo_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TodoView extends StatelessWidget {
  const TodoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TodoViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.redAccent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(model.todo),
              SizedBox(height: 40),
              SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                  onPressed: model.postTodo,
                  child: Text('Add New Todo'),
                ),
              )
            ],
          ),
        ),
      ),
      viewModelBuilder: () => TodoViewModel(),
    );
  }
}
