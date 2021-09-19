import 'package:testsweets/src/extensions/string_extension.dart';
import 'package:testsweets/src/services/validate_widget_description.dart';

class ValidateWidgetDescriptionViewName implements ValidateWidgetDescription {
  @override
  String ifTextNotValidConvertToValidText(String text) {
    final trimmerText = text.trim();
    assert(trimmerText.isNotEmpty);
    if (trimmerText == '/')
      return 'initialView';
    else
      return trimmerText.replaceAll('/', '').replaceAllMapped(
          RegExp(r'[/\-_\s]+([.\S])'), (match) => match.group(1)!.inCaps);
  }

  @override
  String deValidate(String text) {
    return '';
  }
}
