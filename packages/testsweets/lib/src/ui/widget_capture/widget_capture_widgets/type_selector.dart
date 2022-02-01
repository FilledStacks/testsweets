import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:testsweets/src/enums/widget_type.dart';

import 'package:testsweets/src/ui/widget_capture/widget_capture_widgets/widget_circle.dart';

import 'widget_card.dart';

class TypeSelector extends StatelessWidget {
  final void Function(WidgetType) onTap;
  const TypeSelector({
    Key? key,
    required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 82,
      child: ListView(
        padding: const EdgeInsets.all(16).copyWith(top: 8),
        itemExtent: 136,
        scrollDirection: Axis.horizontal,
        children: [
          WidgetCard(
              onTap: onTap,
              widgetCircle: WidgetCircle(
                widgetType: WidgetType.touchable,
              )),
          WidgetCard(
              onTap: onTap,
              widgetCircle: WidgetCircle(
                widgetType: WidgetType.scrollable,
              )),
          WidgetCard(
              onTap: onTap,
              widgetCircle: WidgetCircle(
                widgetType: WidgetType.input,
              )),
        ],
      ),
    );
  }
}
