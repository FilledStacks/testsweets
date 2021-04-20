// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AutomationKey _$_$_AutomationKeyFromJson(Map<String, dynamic> json) {
  return _$_AutomationKey(
    name: json['name'] as String,
    type: _$enumDecode(_$WidgetTypeEnumMap, json['type']),
    view: json['view'] as String,
  );
}

Map<String, dynamic> _$_$_AutomationKeyToJson(_$_AutomationKey instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': _$WidgetTypeEnumMap[instance.type],
      'view': instance.view,
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
  WidgetType.text: 'text',
  WidgetType.general: 'general',
  WidgetType.view: 'view',
  WidgetType.input: 'input',
  WidgetType.scrollable: 'scrollable',
};
