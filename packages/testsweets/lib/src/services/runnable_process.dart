import 'dart:io';

import 'package:flutter/foundation.dart';

class RunnableProcess {
  final String path;
  RunnableProcess(this.path);

  Future<Process> startWith({@required List<String> args}) {
    return Process.start(path, args);
  }
}

class FlutterProcess extends RunnableProcess {
  FlutterProcess(String path) : super(path);
}
