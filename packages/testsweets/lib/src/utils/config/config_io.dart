import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;
import 'config.dart' show AppConfig;

class _AppConfigIO extends AppConfig {
  final File _configJsonFile;
  Map<String, Object?> _cachedConfig = {};

  _AppConfigIO._(this._configJsonFile);

  @override
  T? getValue<T extends Object>(String key) {
    return _cachedConfig[key] as dynamic;
  }

  @override
  Future<void> setValue(String key, Object? value) async {
    _cachedConfig[key] = value;
    await _update();
  }

  Future<void> _update() async {
    await _configJsonFile.writeAsString(json.encode(_cachedConfig));
  }

  @override
  Future<Map<String, Object?>?> fetchDataFromSource() async {
    final data = await _configJsonFile.readAsString();
    if (data.isEmpty) return null;
    return json.decode(data);
  }

  Future<void> _load() async {
    _cachedConfig = await fetchDataFromSource() ?? {};
  }

  @override
  String toString() {
    return '_AppConfigIO: Storing data in ${_configJsonFile.absolute.path}';
  }
}

/// Returns Application documents directory for a platform before `WidgetsFlutterBinding.ensureInitialized` or `runApp`
/// is used.
Future<Directory> getPlatformDocumentsDirectoryPath(
  String applicationPackageName,
) async {
  if (Platform.isAndroid) {
    final tempDirInAppDataContainer = Directory.systemTemp.absolute.path;
    // Reference: app data files path is created like path_provider gets it from flutter PathUtil java https://github.com/flutter/engine/blob/57d6b518f9205027256391e3c71529ee510598cf/shell/platform/android/io/flutter/util/PathUtils.java#L17
    final appDocumentsDirectory = path.normalize(path.join(tempDirInAppDataContainer, '..', 'files'));
    return Directory(appDocumentsDirectory);
  } else if (Platform.isIOS || Platform.isMacOS) {
    final tempDirInAppDataContainer = Directory.systemTemp.absolute.path;
    final appDocumentsDirectory = path.normalize(path.join(tempDirInAppDataContainer, '..', 'Documents'));
    return Directory(appDocumentsDirectory);
  } else if (Platform.isWindows) {
    // For storing app config locally for a user, windows had in the reference document to use the env variable LOCALAPPDATA.
    // Reference: https://web.archive.org/web/20120905053951/http://download.microsoft.com/download/e/6/a/e6aa654f-cccb-421e-9b50-3392e9886084/VistaFileSysNamespaces.pdf
    final userLocalDataDir = Platform.environment['LOCALAPPDATA'];
    if (userLocalDataDir == null) throw Exception('Unexpected exception');
    final lastIndexOfDot = applicationPackageName.lastIndexOf('.');
    final name = applicationPackageName.substring(lastIndexOfDot + 1);
    final parent = applicationPackageName.substring(0, lastIndexOfDot);
    // This is how path_provider makes app support data directory path: com.example.app_name as com.example/app_name
    final appLocalpathName = path.join(userLocalDataDir, parent, name);
    return Directory(appLocalpathName);
  }
  // return getPlatformDocumentsDirectoryPathFromPlugin();
  throw UnimplementedError(
    'Default documents directory path was not setup for other platforms',
  );
}

/// Returns path of config file that is inside application's official document directory
Future<File> getApplicationConfigFile(String packageName) async {
  final documentsDirectory = await getPlatformDocumentsDirectoryPath(
    packageName,
  );
  await documentsDirectory.create(recursive: true);
  final configJsonFile = File(
    path.join(documentsDirectory.path, 'app_config.json'),
  );
  if (!await configJsonFile.exists()) {
    await configJsonFile.create();
  }
  return configJsonFile;
}

Future<AppConfig> getAppConfig(String packageName) async {
  final file = await getApplicationConfigFile(packageName);
  final config = _AppConfigIO._(file);
  await config._load();
  return config;
}
