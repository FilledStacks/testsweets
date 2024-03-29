import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:testsweets_shared/src/enums/driver_command_type.dart';

part 'driver_command_result.freezed.dart';
part 'driver_command_result.g.dart';

@freezed
class DriverCommandResult with _$DriverCommandResult {
  factory DriverCommandResult({
    required DriverCommandType type,
    required bool success,
  }) = _DriverCommandResult;

  factory DriverCommandResult.fromJson(Map<String, dynamic> json) =>
      _$DriverCommandResultFromJson(json);
}
