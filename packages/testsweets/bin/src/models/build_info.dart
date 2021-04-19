class BuildInfo {
  final String pathToBuild;

  /// Can be 'release', 'debug', or 'profile'.
  final String buildMode;

  /// Can be 'apk' or 'ipa'.
  final String appType;

  /// Shoul;d be the same as the version found in the
  /// `pubspec.yaml` file for the app.
  final String version;

  BuildInfo(
      {required this.pathToBuild,
      required this.buildMode,
      required this.appType,
      required this.version});

  @override
  String toString() {
    return {
      'pathToBuild': pathToBuild,
      'buildMode': buildMode,
      'appType': appType,
      'version': version,
    }.toString();
  }
}
