import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:testsweets/testsweets.dart';

part 'scrollable_description.freezed.dart';
part 'scrollable_description.g.dart';

@freezed
class ScrollableDescription with _$ScrollableDescription {
  factory ScrollableDescription(
      {required Axis axis,
      required SerializableRect rect,
      required double scrollExtentByPixels,
      required double maxScrollExtentByPixels,
      @Default(false) bool nested}) = _ScrollableDescription;

  factory ScrollableDescription.fromNotification({
    required Offset globalPosition,
    required Offset localPosition,
    required ScrollDirection scrollDirection,
    required ScrollMetrics metrics,
  }) {
    final position = -metrics.extentBefore;
    final topLeftPointOfList = globalPosition - localPosition;

    final rect = SerializableRect.fromLTWH(
      topLeftPointOfList.dx,
      topLeftPointOfList.dy,
      // viewportDimension The extent of the viewport along the axisDirection.
      metrics.axis == Axis.horizontal ? metrics.viewportDimension : 0,
      metrics.axis == Axis.vertical ? metrics.viewportDimension : 0,
    );

    return ScrollableDescription(
        axis: metrics.axis,
        rect: rect,
        scrollExtentByPixels: position,
        maxScrollExtentByPixels: metrics.maxScrollExtent);
  }
  factory ScrollableDescription.fromJson(Map<String, dynamic> json) =>
      _$ScrollableDescriptionFromJson(json);
}
