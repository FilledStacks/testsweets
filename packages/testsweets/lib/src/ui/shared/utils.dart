import 'package:flutter/widgets.dart';
import 'package:testsweets/src/constants/app_constants.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/extensions/widget_position_extension.dart';
import 'package:testsweets/testsweets.dart';

class Utils {
  static double halfOfLengthMinusWidgetRadius(double length) {
    return length / 2 - WIDGET_DESCRIPTION_VISUAL_SIZE / 2;
  }
}

class InteractionUtils {
  static bool notView(Interaction interaction) {
    return interaction.widgetType != WidgetType.view;
  }

  static bool visibleOnScreen(Interaction interaction, Size screenSize) {
    // final unionSd = interaction.externalities?.reduce((sd, nextSd) {
    //   final result = sd.rect.expandToInclude(nextSd.rect);
    //   return sd.copyWith(
    //       rect: SerializableRect.fromLTWH(
    //     result.left,
    //     result.top,
    //     result.width,
    //     result.height,
    //   ));
    // });

    final visible = screenSize.contains(
        interaction.renderPosition.responsiveOffset(screenSize) +
            Offset(WIDGET_DESCRIPTION_VISUAL_SIZE / 2,
                WIDGET_DESCRIPTION_VISUAL_SIZE / 2));

    return visible;
  }
}
