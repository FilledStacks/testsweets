import 'package:flutter/material.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/extensions/widget_type_flutter_extension.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_widgets/widget_circle.dart';

class WidgetCard extends StatelessWidget {
  final WidgetCircle widgetCircle;

  final void Function(WidgetType) onTap;
  const WidgetCard({Key? key, required this.widgetCircle, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 8),
      alignment: Alignment.bottomCenter,
      child: Material(
        type: MaterialType.card,
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor:
              widgetCircle.widgetType.getColorOfWidgetType.withOpacity(0.7),
          borderRadius: BorderRadius.circular(24),
          onTap: () => onTap(widgetCircle.widgetType),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                border: Border.all(
                    color: widgetCircle.widgetType.getColorOfWidgetType),
                borderRadius: BorderRadius.circular(24)),
            child: Row(
              children: [
                const SizedBox(
                  width: 2,
                ),
                widgetCircle,
                Expanded(
                  child: Text(widgetCircle.widgetType.getTitleOfWidgetType,
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
