class ErrorMessages {
  static String thereIsNoPubspecyamlFile(String appPath) =>
      'The folder at $appPath does not contain a pubspec.yaml file. '
      'Please check if this is the correct folder or create the pubspec.yaml file.';
  static const String thereIsNoVersionInPubspecyamlFile =
      'The pubspec.yaml file for this project does not define a version. '
      'Versions are used by Test Sweets to keep track of builds. Please add a version for this app.';
  static const String notFoundAutomationKeys =
      'We did not find the automation keys to upload. Please make sure you have added '
      'the TestSweets generator into the pubspec. If you have then make sure you run '
      'flutter pub run build_runner build --delete-conflicting-outputs before you attempt '
      'to upload the build';
}
