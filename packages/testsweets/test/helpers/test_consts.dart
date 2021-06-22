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
const String directoryPath = 'myApp';
const String pathToBuild = 'abc';
const String appType = 'apk';
const List<String> extraArgs = ['--profile'];
