// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_command_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DriverCommandResultImpl _$$DriverCommandResultImplFromJson(
        Map<String, dynamic> json) =>
    _$DriverCommandResultImpl(
      type: $enumDecode(_$DriverCommandTypeEnumMap, json['type']),
      success: json['success'] as bool,
    );

Map<String, dynamic> _$$DriverCommandResultImplToJson(
        _$DriverCommandResultImpl instance) =>
    <String, dynamic>{
      'type': _$DriverCommandTypeEnumMap[instance.type]!,
      'success': instance.success,
    };

const _$DriverCommandTypeEnumMap = {
  DriverCommandType.testIntegrity: 'testIntegrity',
  DriverCommandType.expectEvent: 'expectEvent',
  DriverCommandType.modeUpdate: 'modeUpdate',
};
