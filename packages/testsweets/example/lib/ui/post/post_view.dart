import 'package:example/ui/post/post_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class PostView extends StatelessWidget {
  const PostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostViewModel>.reactive(
      disposeViewModel: false,
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.greenAccent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(model.post),
              SizedBox(height: 40),
              SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                  onPressed: model.getPost,
                  child: Text('Get New Post'),
                ),
              )
            ],
          ),
        ),
      ),
      viewModelBuilder: () => PostViewModel(),
    );
  }
}
