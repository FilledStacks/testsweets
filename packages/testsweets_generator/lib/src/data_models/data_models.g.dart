// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AutomationKey _$_$_AutomationKeyFromJson(Map<String, dynamic> json) {
  return _$_AutomationKey(
    name: json['name'] as String,
    type: _$enumDecodeNullable(_$WidgetTypeEnumMap, json['type']),
    view: json['view'] as String,
  );
}

Map<String, dynamic> _$_$_AutomationKeyToJson(_$_AutomationKey instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': _$WidgetTypeEnumMap[instance.type],
      'view': instance.view,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$WidgetTypeEnumMap = {
  WidgetType.touchable: 'touchable',
  WidgetType.text: 'text',
  WidgetType.general: 'general',
  WidgetType.view: 'view',
  WidgetType.input: 'input',
};
