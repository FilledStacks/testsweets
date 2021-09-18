import 'package:testsweets/src/extensions/string_extension.dart';

abstract class ValidateWidgetDescription {
  String ifTextNotValidConvertToValidText(String text);
  String deValidate(String text);
}

class ValidateWidgetDescriptionName implements ValidateWidgetDescription {
  @override
  String ifTextNotValidConvertToValidText(String text) {
    assert(text.trim().isNotEmpty);
    return text.trim().replaceAllMapped(
        RegExp(r'[/\-_\s]+([.\S])'), (match) => match.group(1)!.inCaps);
  }

  @override
  String deValidate(String text) {
    assert(text.trim().isNotEmpty);
    return text.trim().replaceAllMapped(RegExp(r'[A-Z][a-z0-9]+'),
        (match) => match.group(0)!.firstLetterInSmallLetter);
  }
}

class ValidateWidgetDescriptionViewName implements ValidateWidgetDescription {
  @override
  String ifTextNotValidConvertToValidText(String text) {
    // TODO: implement deValidate
    throw UnimplementedError();
  }

  @override
  String deValidate(String text) {
    // TODO: implement deValidate
    throw UnimplementedError();
  }
}
