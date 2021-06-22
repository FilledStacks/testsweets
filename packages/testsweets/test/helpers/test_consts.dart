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

const String testDirectoryPath = 'myApp';
const String testPathToBuild = 'abc';
const String testAppType = 'apk';
const List<String> testExtraArgs = ['--profile'];
const int testContentLength = 2;
final testDataStream = Stream.value([1, 2, 3]);
final testDateTime = DateTime.utc(1993, 12, 12, 12);
