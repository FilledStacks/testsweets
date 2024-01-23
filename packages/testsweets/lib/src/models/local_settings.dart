import 'package:hive/hive.dart';

class LocalSettings {
  final bool captureMode;
  const LocalSettings({
    required this.captureMode,
  });
}

class SettingsKeys {
  static const String localSettings = 'driverSettings';
}

class LocalSettingsAdapter extends TypeAdapter<LocalSettings> {
  @override
  final typeId = 0;

  @override
  LocalSettings read(BinaryReader reader) {
    final useFlutterDriver = reader.readBool();
    return LocalSettings(captureMode: useFlutterDriver);
  }

  @override
  void write(BinaryWriter writer, LocalSettings obj) {
    writer.writeBool(obj.captureMode);
  }
}
