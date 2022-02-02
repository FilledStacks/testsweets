import 'dart:ui';

import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';

extension WidgetTypeFlutterExtension on WidgetType {
  Color get getColorOfWidgetType {
    switch (this) {
      case WidgetType.touchable:
        return kcPrimaryFuchsia;
      case WidgetType.input:
        return kcYellow;
      case WidgetType.scrollable:
        return kcGreen;

      default:
        return kcError;
    }
  }

  String get getTitleOfWidgetType {
    switch (this) {
      case WidgetType.touchable:
        return 'Touchable';
      case WidgetType.input:
        return 'Input';
      case WidgetType.scrollable:
        return 'Scrollable';

      default:
        return 'Unknown';
    }
  }
}
