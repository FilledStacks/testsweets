import 'dart:ui';

import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';

import 'string_extension.dart';

extension WidgetTypeUtilty on WidgetType {
  String get returnFirstLetterOfWidgetTypeCapitalized =>
      this.toString().split('.').last[0].capitalizeFirstOfEach;
  Color get getColorOfWidgetType {
    switch (this) {
      case WidgetType.touchable:
        return kcPrimaryFuchsia;
      case WidgetType.input:
        return kcPrimaryPurple;
      case WidgetType.scrollable:
        return kcSecondaryGreen;

      default:
        return kcError;
    }
  }
}
