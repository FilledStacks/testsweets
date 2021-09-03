class ErrorMessages {
  static String thereIsNoPubspecyamlFile(String appPath) =>
      'The folder at $appPath does not contain a pubspec.yaml file. '
      'Please check if this is the correct folder or create the pubspec.yaml file.';
  static String notValidCommand(String command) =>
      '$command is not a valid command, You can use either \'buildAndUpload\' or \'uploadApp\' or \'uploadKeys\'';
  static const String thereIsNoVersionInPubspecyamlFile =
      'The pubspec.yaml file for this project does not define a version. '
      'Versions are used by Test Sweets to keep track of builds. Please add a version for this app.';
  static const String notFoundAutomationKeys =
      'We did not find the automation keys to upload. Please make sure you have added '
      'the TestSweets generator into the pubspec. If you have then make sure you run '
      'flutter pub run build_runner build --delete-conflicting-outputs before you attempt '
      'to upload the build';
  static const String errorParsingAutomationKeys =
      "Error parsing automation keys";
  static const String projectConfigNotCreated =
      '''Project config is not created . If you forgot to setup your .testsweets file please
           create one. It requires three values, your projectId (found in your project settings)
           your apiKey (found in your project settings) and your flutterBuildCommand (the part
           of the command after flutter pub build apk).''';
  static const String uploadAppCommandeMissingPath =
      "When using 'uploadApp' you must provide the path to your build with the --path or -p argument after the apiKey\n\n";
  static const String buildArgumentsError = '''
Expected arguments to have the form: buildAndUpload appType

Where:
  appType can be apk or ipa

you need to add .testsweets file at the root of your project containing the folowing parameters
You can find both the API key and the project id for your project in the project
settings tab in Test Sweets(all three parameters are required*).
example:  projectId=3OezzTovG9xxxxxxxxx
          apiKey=e3747a0e-xxxx-xxxx-xxxx-xxxxxxxxxxxx
          flutterBuildCommand=--debug -t lib/main_profile.dart


The 'buildAndUpload' command will build your application with `flutter build`. Normal
positional `flutter build` arguments, like --flavor, can be passed to the command just after
the apiKey.

You can use the 'uploadApp' command if you already have a build (apk or ipa) and all you want
to do is upload it. The path to the build must be specified with the '--path' positional
argument after the apiKey.

For example:
  \$ flutter pub run testsweets buildAndUpload apk'
''';
}
