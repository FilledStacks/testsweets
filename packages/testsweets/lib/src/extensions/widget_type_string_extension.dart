import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/extensions/string_extension.dart';

extension WidgetTypeStringExtension on WidgetType {
  String get returnFirstLetterOfWidgetTypeCapitalized =>
      this.toString().split('.').last[0].capitalizeFirstOfEach;

  String get shortName => this.toString().split('.').last;
}
