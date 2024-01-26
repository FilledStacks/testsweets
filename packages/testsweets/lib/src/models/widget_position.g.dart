// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widget_position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WidgetPosition _$$_WidgetPositionFromJson(Map<String, dynamic> json) =>
    _$_WidgetPosition(
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      yDeviation: (json['yDeviation'] as num?)?.toDouble(),
      xDeviation: (json['xDeviation'] as num?)?.toDouble(),
      deviceBuckets: (json['deviceBuckets'] as List<dynamic>?)
              ?.map((e) => DeviceDetails.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      capturedDeviceWidth: (json['capturedDeviceWidth'] as num?)?.toDouble(),
      capturedDeviceHeight: (json['capturedDeviceHeight'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$_WidgetPositionToJson(_$_WidgetPosition instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'yDeviation': instance.yDeviation,
      'xDeviation': instance.xDeviation,
      'deviceBuckets': instance.deviceBuckets,
      'capturedDeviceWidth': instance.capturedDeviceWidth,
      'capturedDeviceHeight': instance.capturedDeviceHeight,
    };
