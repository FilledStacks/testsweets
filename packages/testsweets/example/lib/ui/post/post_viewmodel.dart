import 'dart:math';

import 'package:stacked/stacked.dart';

class PostViewModel extends BaseViewModel {
  String _post = 'Random Text Generator';
  String get post => _post;

  void getPost() {
    _post = _getRandomString(10);
    notifyListeners();
  }

  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String _getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}
