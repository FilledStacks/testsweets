// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:convert';
import 'dart:html' as html;

import 'config.dart' show AppConfig;

class _AppConfigWeb extends AppConfig {
  /// Using dart's API for web browser's local storage
  /// Reference: https://developer.mozilla.org/en-US/docs/Web/API/Window/localStorage
  /// Reference: https://api.dart.dev/stable/3.2.5/dart-html/Window/localStorage.html
  final html.Storage _configStorage;
  Map<String, Object?> _cachedConfig = {};

  _AppConfigWeb(this._configStorage);

  @override
  T? getValue<T extends Object>(String key) {
    return _cachedConfig[key] as dynamic;
  }

  @override
  Future<void> setValue(String key, Object? value) async {
    _cachedConfig[key] = value;
    _update();
  }

  void _update() async {
    _configStorage['app_config'] = json.encode(_cachedConfig);
  }

  @override
  Future<Map<String, Object?>?> fetchDataFromSource() async {
    final data = _configStorage['app_config'];
    if (data == null || data.isEmpty) return null;
    return json.decode(data);
  }

  Future<void> _load() async {
    _cachedConfig = await fetchDataFromSource() ?? {};
  }

  @override
  String toString() {
    return '_AppConfigWeb: Storing data in window.localStorage["app_config"]';
  }
}

Future<AppConfig> getAppConfig(String packageName) async {
  final config = _AppConfigWeb(html.window.localStorage);
  await config._load();
  return config;
}
