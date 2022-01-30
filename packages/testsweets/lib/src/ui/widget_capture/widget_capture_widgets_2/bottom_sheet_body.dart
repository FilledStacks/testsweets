import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_widgets/widget_circle.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_widgets_2/widget_card.dart';

class BottomSheetBody extends StatelessWidget {
  final void Function(WidgetType) onWidgetTypeTap;
  const BottomSheetBody({Key? key, required this.onWidgetTypeTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Text('Select the widget type to add',
                textAlign: TextAlign.left, style: tsMedium()),
          ),
          SizedBox(
            height: 82,
            child: ListView(
              padding: const EdgeInsets.all(16),
              itemExtent: 136,
              scrollDirection: Axis.horizontal,
              children: [
                WidgetCard(
                    onTap: onWidgetTypeTap,
                    widgetCircle: WidgetCircle(
                      widgetType: WidgetType.touchable,
                    )),
                WidgetCard(
                    onTap: onWidgetTypeTap,
                    widgetCircle: WidgetCircle(
                      widgetType: WidgetType.scrollable,
                    )),
                WidgetCard(
                    onTap: onWidgetTypeTap,
                    widgetCircle: WidgetCircle(
                      widgetType: WidgetType.input,
                    )),
              ],
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: kcBottomSheetBackground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
    );
  }
}
