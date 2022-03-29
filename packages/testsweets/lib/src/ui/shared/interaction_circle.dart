import 'package:flutter/material.dart';

import 'package:testsweets/src/constants/app_constants.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/extensions/widget_type_extension.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';

class InteractionCircle extends StatelessWidget {
  final WidgetType widgetType;
  final double transparency;
  final bool minify;
  final bool driverMode;
  const InteractionCircle({
    Key? key,
    required this.widgetType,
    this.transparency = 1.0,
    this.minify = false,
    this.driverMode = false,
  })  : assert(transparency <= 1 && transparency >= 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: minify
            ? WIDGET_DESCRIPTION_VISUAL_SIZE / 1.2
            : WIDGET_DESCRIPTION_VISUAL_SIZE,
        height: WIDGET_DESCRIPTION_VISUAL_SIZE,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                color: minify
                    ? kcPrimaryWhite
                    : widgetType.getColorOfWidgetType.withOpacity(transparency),
                width: 2)),
        child: driverMode
            ? Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                    color: widgetType.getColorOfWidgetType,
                    shape: BoxShape.circle),
              )
            : Text(widgetType.returnFirstLetterOfWidgetTypeCapitalized,
                textAlign: TextAlign.center,
                style: minify
                    ? tsLargeBold().copyWith(
                        color: kcPrimaryWhite,
                      )
                    : tsExtraLarge().copyWith(
                        color: widgetType.getColorOfWidgetType
                            .withOpacity(transparency),
                      )));
  }
}
