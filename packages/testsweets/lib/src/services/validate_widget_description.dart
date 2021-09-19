import 'package:testsweets/src/extensions/string_extension.dart';

abstract class ValidateWidgetDescription {
  String ifTextNotValidConvertToValidText(String text);
  String deValidate(String text);
}

class ValidateWidgetDescriptionName implements ValidateWidgetDescription {
  @override
  String ifTextNotValidConvertToValidText(String text) {
    final trimmerText = text.trim();
    assert(trimmerText.isNotEmpty);
    return trimmerText.trim().replaceAllMapped(
        RegExp(r'[/\-_\s]+([.\S])'), (match) => match.group(1)!.inCaps);
  }

  @override
  String deValidate(String text) {
    final trimmerText = text.trim();
    assert(trimmerText.isNotEmpty);
    return trimmerText.trim().replaceAllMapped(RegExp(r'[A-Z][a-z0-9]+'),
        (match) => ' ' + match.group(0)!.firstLetterInSmallLetter);
  }
}

class ValidateWidgetDescriptionViewName implements ValidateWidgetDescription {
  @override
  String ifTextNotValidConvertToValidText(String text) {
    final trimmerText = text.trim();
    assert(trimmerText.isNotEmpty);
    if (trimmerText == '/')
      return 'initialView';
    else
      return trimmerText.trim().replaceAll('/', '').replaceAllMapped(
          RegExp(r'[/\-_\s]+([.\S])'), (match) => match.group(1)!.inCaps);
  }

  @override
  String deValidate(String text) {
    // TODO: implement deValidate
    throw UnimplementedError();
  }
}
