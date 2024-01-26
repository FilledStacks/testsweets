// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widget_position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WidgetPosition _$$_WidgetPositionFromJson(Map<String, dynamic> json) =>
    _$_WidgetPosition(
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      capturedDeviceWidth: (json['capturedDeviceWidth'] as num?)?.toDouble(),
      capturedDeviceHeight: (json['capturedDeviceHeight'] as num?)?.toDouble(),
      xDeviation: (json['xDeviation'] as num?)?.toDouble(),
      yDeviation: (json['yDeviation'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$_WidgetPositionToJson(_$_WidgetPosition instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'capturedDeviceWidth': instance.capturedDeviceWidth,
      'capturedDeviceHeight': instance.capturedDeviceHeight,
      'xDeviation': instance.xDeviation,
      'yDeviation': instance.yDeviation,
    };
