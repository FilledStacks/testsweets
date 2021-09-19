import 'package:testsweets/src/extensions/string_extension.dart';
import 'package:testsweets/src/services/validate_widget_description.dart';

class ValidateWidgetDescriptionName implements ValidateWidgetDescription {
  @override
  String ifTextNotValidConvertToValidText(String text) {
    final trimmerText = text.trim();
    assert(trimmerText.isNotEmpty);
    return trimmerText.replaceAllMapped(
        RegExp(r'[/\-_\s]+([.\S])'), (match) => match.group(1)!.inCaps);
  }

  @override
  String deValidate(String text) {
    final trimmerText = text.trim();
    assert(trimmerText.isNotEmpty);
    return trimmerText.replaceAllMapped(RegExp(r'[A-Z][a-z0-9]+'),
        (match) => ' ' + match.group(0)!.firstLetterInSmallLetter);
  }
}
