import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:testsweets_shared/src/enums/driver_command_type.dart';

part 'driver_command.freezed.dart';
part 'driver_command.g.dart';

@freezed
class DriverCommand with _$DriverCommand {
  factory DriverCommand({
    required DriverCommandType type,
    required String name,
    dynamic value,
  }) = _DriverCommand;

  factory DriverCommand.fromJson(Map<String, dynamic> json) =>
      _$DriverCommandFromJson(json);
}

@freezed
class ExpectEventDataModel with _$ExpectEventDataModel {
  factory ExpectEventDataModel({
    required String key,
    required String value,
  }) = _ExpectEventDataModel;

  factory ExpectEventDataModel.fromJson(Map<String, dynamic> json) =>
      _$ExpectEventDataModelFromJson(json);
}
