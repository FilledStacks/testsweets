import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:testsweets_generator/src/exceptions/key_format_exception.dart';

import 'data_models/data_models.dart';

const String InvalidFormatExceptionMessage =
    '''The key {0} passed in is not in a valid format. Please check the documentation for correct format.
A key has to be split into 3 parts [view]_[type]_[name]. The view is automatically added by the generator. 
The key in your code should look as follows [type]_[name] .i.e. input_email.''';

const String DynamicFormatMessage = '\n\n{0} is not in the correct format.';

const String InvalidTypeExceptionMessage =
    '''The type defined in your key does not exist. Please ensure that you are using one of the following keys.
  touchable: A widget that you want to tap on
  text: A widget that displays text you want to read
  general: Any widget where you might want to check it's visibility
  view: The widget that's shown as the view in the navigation stack
  input: A widget that takes input
  scrollable: A widget that can be scrolled
''';

const String DynamicInvalidTypeException =
    '\n\n{0} is not 1 of the types defined';

class AutomationKeyCreator {
  const AutomationKeyCreator();

  List<AutomationKey> getAutomationKeysFromStrings(List<String> keyValues) {
    List<AutomationKey> out = [];
    for (var keyValue in keyValues) {
      final automationKey = getAutomationKeyFromKeyValue(keyValue);
      if (automationKey != null) out.add(automationKey);
    }

    return out;
  }

  @visibleForTesting
  AutomationKey? getAutomationKeyFromKeyValue(String? key) {
    if (key == null || key == '' || !key.contains('_')) {
      return null;
    }

    var keyParts = key.split('_');
    if (keyParts.length == 2 && keyParts.last.toLowerCase() == 'view') {
      return AutomationKey(
        view: keyParts.first,
        type: WidgetType.view,
        name: keyParts.first,
      );
    }

    if (keyParts.length != 3) {
      throw KeyFormatException(
          InvalidFormatExceptionMessage.replaceAll('{0}', key));
    }

    var keyTypeString = keyParts[1];

    var types = WidgetType.values;
    var matchesType = types.any((type) =>
        type.toString().split('.').last.toLowerCase() == keyTypeString);

    if (!matchesType)
      throw KeyFormatException(InvalidTypeExceptionMessage +
          DynamicInvalidTypeException.replaceAll('{0}', keyTypeString));

    var viewName = keyParts[0];

    return AutomationKey(
      view: viewName,
      type: _getTypeFromString(keyTypeString),
      name: keyParts.last,
    );
  }

  WidgetType _getTypeFromString(String value) {
    return WidgetType.values.firstWhere(
        (element) => element.toString().toLowerCase().contains(value));
  }
}
