import 'package:flutter/material.dart';

import 'package:testsweets/src/constants/app_constants.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/extensions/widget_type_extension.dart';
import 'package:testsweets/src/extensions/string_extension.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';

class WidgetCircle extends StatelessWidget {
  final WidgetType widgetType;
  final double transparency;
  final bool selected;
  const WidgetCircle({
    Key? key,
    required this.widgetType,
    this.transparency = 1.0,
    this.selected = true,
  })  : assert(transparency <= 1 && transparency >= 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: WIDGET_DESCRIPTION_VISUAL_SIZE,
        height: WIDGET_DESCRIPTION_VISUAL_SIZE,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                color: selected
                    ? widgetType.getColorOfWidgetType.withOpacity(transparency)
                    : kcPrimaryWhite,
                width: 2)),
        child: Text(widgetType.returnFirstLetterOfWidgetTypeCapitalized,
            textAlign: TextAlign.center,
            style: tsExtraLarge().copyWith(
              color: selected
                  ? widgetType.getColorOfWidgetType.withOpacity(transparency)
                  : kcPrimaryWhite,
            )));
  }
}
