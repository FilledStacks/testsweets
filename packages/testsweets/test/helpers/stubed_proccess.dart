import 'dart:convert';
import 'dart:io';

import 'package:testsweets/src/services/runnable_process.dart';

class StubbedProcess implements Process {
  final int sExitCode;
  final String sStdErr;
  final String sStdOut;
  StubbedProcess(
      {required this.sExitCode, required this.sStdErr, required this.sStdOut});

  @override
  Future<int> get exitCode async => sExitCode;

  @override
  bool kill([ProcessSignal signal = ProcessSignal.sigterm]) {
    return true;
  }

  @override
  int get pid => throw UnimplementedError();

  @override
  Stream<List<int>> get stderr async* {
    yield utf8.encode(sStdErr);
  }

  @override
  IOSink get stdin => throw UnimplementedError();

  @override
  Stream<List<int>> get stdout async* {
    yield utf8.encode(sStdOut);
  }
}

class StubbedRunnableProcess implements RunnableProcess {
  final Process main;
  StubbedRunnableProcess(this.main);

  List<String> startedWithArgs = [];

  @override
  String get path => 'flutter';

  @override
  Future<Process> startWith({required List<String> args}) async {
    startedWithArgs = args;
    return main;
  }
}

const String ksPubspecFileWithNoVersion = """
name: myApp

environment:
  sdk: ">=2.7.0 <3.0.0"
""";

const String ksPubspecFileWithVersion = """
name: myApp

version: 0.1.1

environment:
  sdk: ">=2.7.0 <3.0.0"
""";

const String ksAppAutomationKeysFile = """
[
  {
    "name": "home",
    "type": "view",
    "view": "home"
  }
]
""";
