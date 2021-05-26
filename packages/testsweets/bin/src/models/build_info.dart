class BuildInfo {
  final String pathToBuild;

  /// Can be 'release', 'debug', or 'profile'.
  final String buildMode;

  /// Can be 'apk' or 'ipa'.
  final String appType;

  /// Should be the same as the version found in the
  /// `pubspec.yaml` file for the app.
  final String version;

  /// The parsed contents of the `app_automation_keys.json` file.
  ///
  /// This list also includes the automation keys generated
  final List<Map<String, dynamic>> automationKeysJson;

  /// The parsed contents of the `dynamic_keys.json' file.
  final List<Map<String, dynamic>> dynamicKeysJson;

  BuildInfo(
      {required this.pathToBuild,
      required this.buildMode,
      required this.appType,
      required this.version,
      required this.automationKeysJson,
      required this.dynamicKeysJson});

  @override
  String toString() {
    return {
      'pathToBuild': pathToBuild,
      'buildMode': buildMode,
      'appType': appType,
      'version': version,
      'automationKeysData': automationKeysJson,
      'dynamicKeysData': dynamicKeysJson,
    }.toString();
  }
}
