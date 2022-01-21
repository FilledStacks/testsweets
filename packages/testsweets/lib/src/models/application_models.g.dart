// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WidgetDescription _$$_WidgetDescriptionFromJson(Map<String, dynamic> json) =>
    _$_WidgetDescription(
      id: json['id'] as String?,
      viewName: json['viewName'] as String,
      originalViewName: json['originalViewName'] as String,
      name: json['name'] as String,
      widgetType: _$enumDecode(_$WidgetTypeEnumMap, json['widgetType']),
      position:
          WidgetPosition.fromJson(json['position'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_WidgetDescriptionToJson(
        _$_WidgetDescription instance) =>
    <String, dynamic>{
      'id': instance.id,
      'viewName': instance.viewName,
      'originalViewName': instance.originalViewName,
      'name': instance.name,
      'widgetType': _$WidgetTypeEnumMap[instance.widgetType],
      'position': instance.position,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$WidgetTypeEnumMap = {
  WidgetType.touchable: 'touchable',
  WidgetType.scrollable: 'scrollable',
  WidgetType.text: 'text',
  WidgetType.general: 'general',
  WidgetType.view: 'view',
  WidgetType.input: 'input',
};

_$_WidgetPosition _$$_WidgetPositionFromJson(Map<String, dynamic> json) =>
    _$_WidgetPosition(
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      capturedDeviceWidth: (json['capturedDeviceWidth'] as num?)?.toDouble(),
      capturedDeviceHeight: (json['capturedDeviceHeight'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$_WidgetPositionToJson(_$_WidgetPosition instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'capturedDeviceWidth': instance.capturedDeviceWidth,
      'capturedDeviceHeight': instance.capturedDeviceHeight,
    };
