import 'package:flutter/material.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/extensions/widget_type_flutter_extension.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_widgets/widget_circle.dart';

class WidgetCard extends StatelessWidget {
  final WidgetType widgetType;
  final bool selected;
  final void Function(WidgetType) onTap;
  const WidgetCard(
      {Key? key,
      required this.widgetType,
      required this.onTap,
      this.selected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 8),
      alignment: Alignment.bottomCenter,
      child: Material(
        type: MaterialType.card,
        color: widgetType.getColorOfWidgetType,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: widgetType.getColorOfWidgetType.withOpacity(0.7),
          borderRadius: BorderRadius.circular(12),
          onTap: () => onTap(widgetType),
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WidgetCircle(
                  minify: true,
                  widgetType: widgetType,
                ),
                Expanded(
                  child: Text(widgetType.getTitleOfWidgetType,
                      textAlign: TextAlign.center, style: tsNormalBold()),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
