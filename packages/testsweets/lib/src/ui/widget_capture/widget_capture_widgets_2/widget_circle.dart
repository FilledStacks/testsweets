import 'package:flutter/material.dart';
import 'package:testsweets/src/constants/app_constants.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/extensions/widget_type_flutter_extension.dart';
import 'package:testsweets/src/extensions/widget_type_string_extension.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';

class WidgetCircle extends StatelessWidget {
  final WidgetType widgetType;
  const WidgetCircle({
    Key? key,
    required this.widgetType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: WIDGET_DESCRIPTION_VISUAL_SIZE,
        height: WIDGET_DESCRIPTION_VISUAL_SIZE,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border:
                Border.all(color: widgetType.getColorOfWidgetType, width: 2)),
        child: Text(widgetType.returnFirstLetterOfWidgetTypeCapitalized,
            textAlign: TextAlign.center, style: positionWidgetStyle));
  }
}
