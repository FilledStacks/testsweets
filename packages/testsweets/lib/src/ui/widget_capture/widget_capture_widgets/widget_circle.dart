import 'package:flutter/material.dart';

import 'package:testsweets/src/constants/app_constants.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/extensions/widget_type_flutter_extension.dart';
import 'package:testsweets/src/extensions/widget_type_string_extension.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';

class WidgetCircle extends StatelessWidget {
  final WidgetType widgetType;
  final double transparency;
  final bool minify;
  const WidgetCircle({
    Key? key,
    required this.widgetType,
    this.transparency = 1.0,
    this.minify = false,
  })  : assert(transparency <= 1 && transparency >= 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
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
        child: Text(widgetType.returnFirstLetterOfWidgetTypeCapitalized,
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
