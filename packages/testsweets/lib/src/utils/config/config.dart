import './config_io.dart' if (dart.library.html) './config_web.dart' as config;

abstract class AppConfig {
  T? getValue<T extends Object>(String key);

  Future<void> setValue(String key, Object? value);

  Future<Map<String, Object?>?> fetchDataFromSource();

  /// Returns platform specific app config file. Getting this doesn't require
  /// `WidgetsFlutterBinding.ensureInitialized()` to be called.
  static Future<AppConfig> getAppConfig(String packageName) {
    return config.getAppConfig(packageName);
  }
}
