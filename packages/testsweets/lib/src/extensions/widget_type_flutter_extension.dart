import 'dart:ui';

import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';

extension WidgetTypeFlutterExtension on WidgetType {
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
