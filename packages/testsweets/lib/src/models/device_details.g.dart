// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DeviceDetails _$$_DeviceDetailsFromJson(Map<String, dynamic> json) =>
    _$_DeviceDetails(
      screenWidth: (json['screenWidth'] as num).toDouble(),
      screenHeight: (json['screenHeight'] as num).toDouble(),
      orientation: $enumDecode(_$OrientationEnumMap, json['orientation']),
    );

Map<String, dynamic> _$$_DeviceDetailsToJson(_$_DeviceDetails instance) =>
    <String, dynamic>{
      'screenWidth': instance.screenWidth,
      'screenHeight': instance.screenHeight,
      'orientation': _$OrientationEnumMap[instance.orientation]!,
    };

const _$OrientationEnumMap = {
  Orientation.portrait: 'portrait',
  Orientation.landscape: 'landscape',
};
