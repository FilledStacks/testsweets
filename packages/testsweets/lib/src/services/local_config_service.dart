import 'package:stacked/stacked_annotations.dart';
import 'package:testsweets/src/utils/config/config.dart';

const String _kLocalConfigCaptureModeKey = 'captureModeKey';
const String _kLocalConfigEnabledKey = 'enabledKey';

class LocalConfigService with InitializableDependency {
  late AppConfig _config;

  @override
  Future<void> init() async {
    // TODO: Get package name when we do capturing on Windows
    _config = await AppConfig.getAppConfig('PACKAGE_NAME_NOT_SET');
  }

  bool get captureMode =>
      _config.getValue<bool>(_kLocalConfigCaptureModeKey) ?? false;

  bool get enabled => _config.getValue<bool>(_kLocalConfigEnabledKey) ?? true;

  Future<void> setCaptureMode(bool value) async {
    await _config.setValue(_kLocalConfigCaptureModeKey, value);
  }

  Future<void> setEnable(bool value) async {
    await _config.setValue(_kLocalConfigEnabledKey, value);
  }
}
