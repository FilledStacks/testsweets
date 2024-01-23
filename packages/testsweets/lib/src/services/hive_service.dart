import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:testsweets/src/models/local_settings.dart';

class HiveService with InitializableDependency {
  late final Box<LocalSettings> localSettingsBox;

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(LocalSettingsAdapter());

    localSettingsBox =
        await Hive.openBox<LocalSettings>(SettingsKeys.localSettings);
  }

  bool get captureMode =>
      localSettingsBox.get(SettingsKeys.localSettings)?.captureMode ?? true;

  void setCaptureMode(bool value) {
    localSettingsBox.put(
        SettingsKeys.localSettings, LocalSettings(captureMode: value));
  }
}
