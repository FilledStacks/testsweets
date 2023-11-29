import 'package:flutter/material.dart';
import 'package:testsweets/src/enums/widget_type.dart';

import 'widget_card.dart';

class TypeSelector extends StatelessWidget {
  final void Function(WidgetType) onTap;
  final WidgetType? selectedWidgetType;
  const TypeSelector({
    Key? key,
    required this.onTap,
    this.selectedWidgetType,
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
            selected: selectedWidgetType == WidgetType.touchable,
            onTap: onTap,
            widgetType: WidgetType.touchable,
          ),
          WidgetCard(
            selected: selectedWidgetType == WidgetType.scrollable,
            onTap: onTap,
            widgetType: WidgetType.scrollable,
          ),
          WidgetCard(
            selected: selectedWidgetType == WidgetType.input,
            onTap: onTap,
            widgetType: WidgetType.input,
          ),
        ],
      ),
    );
  }
}
