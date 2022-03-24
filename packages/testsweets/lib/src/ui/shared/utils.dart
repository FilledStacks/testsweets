import 'package:testsweets/src/constants/app_constants.dart';
import 'package:testsweets/src/enums/widget_type.dart';
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
}
