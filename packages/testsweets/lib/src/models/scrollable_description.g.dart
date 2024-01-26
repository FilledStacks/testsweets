// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scrollable_description.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ScrollableDescription _$$_ScrollableDescriptionFromJson(
        Map<String, dynamic> json) =>
    _$_ScrollableDescription(
      axis: $enumDecode(_$AxisEnumMap, json['axis']),
      rect: SerializableRect.fromJson(json['rect'] as Map<String, dynamic>),
      scrollExtentByPixels: (json['scrollExtentByPixels'] as num).toDouble(),
      maxScrollExtentByPixels:
          (json['maxScrollExtentByPixels'] as num).toDouble(),
      nested: json['nested'] as bool? ?? false,
    );

Map<String, dynamic> _$$_ScrollableDescriptionToJson(
        _$_ScrollableDescription instance) =>
    <String, dynamic>{
      'axis': _$AxisEnumMap[instance.axis]!,
      'rect': instance.rect,
      'scrollExtentByPixels': instance.scrollExtentByPixels,
      'maxScrollExtentByPixels': instance.maxScrollExtentByPixels,
      'nested': instance.nested,
    };

const _$AxisEnumMap = {
  Axis.horizontal: 'horizontal',
  Axis.vertical: 'vertical',
};
