// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DriverCommandImpl _$$DriverCommandImplFromJson(Map<String, dynamic> json) =>
    _$DriverCommandImpl(
      type: $enumDecode(_$DriverCommandTypeEnumMap, json['type']),
      name: json['name'] as String,
      value: json['value'],
    );

Map<String, dynamic> _$$DriverCommandImplToJson(_$DriverCommandImpl instance) =>
    <String, dynamic>{
      'type': _$DriverCommandTypeEnumMap[instance.type]!,
      'name': instance.name,
      'value': instance.value,
    };

const _$DriverCommandTypeEnumMap = {
  DriverCommandType.testIntegrity: 'testIntegrity',
  DriverCommandType.expectEvent: 'expectEvent',
  DriverCommandType.modeUpdate: 'modeUpdate',
};
