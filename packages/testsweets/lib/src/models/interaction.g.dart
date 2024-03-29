// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Interaction _$$_InteractionFromJson(Map<String, dynamic> json) =>
    _$_Interaction(
      id: json['id'] as String?,
      viewName: json['viewName'] as String,
      originalViewName: json['originalViewName'] as String,
      name: json['name'] as String? ?? '',
      widgetType: $enumDecode(_$WidgetTypeEnumMap, json['widgetType']),
      position: json['position'] == null
          ? const WidgetPosition(
              x: 0, y: 0, capturedDeviceHeight: 0, capturedDeviceWidth: 0)
          : WidgetPosition.fromJson(json['position'] as Map<String, dynamic>),
      widgetPositions: (json['widgetPositions'] as List<dynamic>?)
              ?.map((e) => WidgetPosition.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      visibility: json['visibility'] as bool? ?? true,
      targetIds: (json['targetIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      externalities: (json['externalities'] as List<dynamic>?)
          ?.map(
              (e) => ScrollableDescription.fromJson(e as Map<String, dynamic>))
          .toSet(),
    );

Map<String, dynamic> _$$_InteractionToJson(_$_Interaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'viewName': instance.viewName,
      'originalViewName': instance.originalViewName,
      'name': instance.name,
      'widgetType': _$WidgetTypeEnumMap[instance.widgetType]!,
      'position': instance.position,
      'widgetPositions': instance.widgetPositions,
      'visibility': instance.visibility,
      'targetIds': instance.targetIds,
      'externalities': instance.externalities?.toList(),
    };

const _$WidgetTypeEnumMap = {
  WidgetType.touchable: 'touchable',
  WidgetType.scrollable: 'scrollable',
  WidgetType.text: 'text',
  WidgetType.general: 'general',
  WidgetType.view: 'view',
  WidgetType.input: 'input',
};
