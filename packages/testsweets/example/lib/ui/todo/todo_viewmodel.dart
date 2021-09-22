import 'dart:math';

import 'package:stacked/stacked.dart';

class TodoViewModel extends BaseViewModel {
  
  String _todo = 'Click to post a new Todo';
  String get todo => _todo;

  void postTodo() {
    _todo = _getRandomTodo(8);
    notifyListeners();
  }

  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String _getRandomTodo(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}
