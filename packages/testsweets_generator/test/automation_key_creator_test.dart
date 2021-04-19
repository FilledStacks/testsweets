import 'package:test/test.dart';
import 'package:testsweets_generator/src/automation_key_creator.dart';
import 'package:testsweets_generator/src/data_models/data_models.dart';
import 'package:testsweets_generator/src/exceptions/key_format_exception.dart';

void main() {
  group('AutomationKeyCreatorTest -', () {
    group('getAutomationKeyFromKeyValue -', () {
      test('When called with empty string should return null', () {
        var creator = const AutomationKeyCreator();
        expect(creator.getAutomationKeyFromKeyValue(''), null);
      });

      test(
          'When called with string with only 1 underscore and the last word is not "view", should throw exception with InvalidFormatExceptionMessage as message',
          () {
        var creator = const AutomationKeyCreator();
        var wrongKey = 'abc_abc';
        expect(
            () => creator.getAutomationKeyFromKeyValue(wrongKey),
            throwsA(predicate((e) =>
                e is KeyFormatException &&
                e.message ==
                    InvalidFormatExceptionMessage +
                        DynamicFormatMessage.replaceAll('{0}', wrongKey))));
      });

      test('When called with login_view should return login as VIEW', () {
        var creator = const AutomationKeyCreator();
        var automationkey = creator.getAutomationKeyFromKeyValue('login_view')!;

        expect(automationkey.view, 'login');
      });
      test('When called with login_view should return view as TYPE', () {
        var creator = const AutomationKeyCreator();
        var automationkey = creator.getAutomationKeyFromKeyValue('login_view')!;

        expect(automationkey.type, WidgetType.view);
      });
      test('When called with login_view should return login as NAME', () {
        var creator = const AutomationKeyCreator();
        var automationkey = creator.getAutomationKeyFromKeyValue('login_view')!;

        expect(automationkey.name, 'login');
      });

      test(
          'When called with invalid type in key, should throw exception with InvalidTypeExceptionMessage',
          () {
        var creator = const AutomationKeyCreator();

        var wrongTypeValue = 'wrongType';
        var wrongTypeKey = 'abc_$wrongTypeValue\_abc';
        expect(
            () => creator.getAutomationKeyFromKeyValue(wrongTypeKey),
            throwsA(predicate((e) =>
                e is KeyFormatException &&
                e.message ==
                    InvalidTypeExceptionMessage +
                        DynamicInvalidTypeException.replaceAll(
                            '{0}', wrongTypeValue))));
      });

      test(
          'When called with home_input_email should return AutomationKey with home as VIEW',
          () {
        var creator = const AutomationKeyCreator();
        var automationkey =
            creator.getAutomationKeyFromKeyValue('home_input_email')!;

        expect(automationkey.view, 'home');
      });

      test('When called with home_input_email should return input as TYPE', () {
        var creator = const AutomationKeyCreator();
        var automationkey =
            creator.getAutomationKeyFromKeyValue('home_input_email')!;

        expect(automationkey.type, WidgetType.input);
      });

      test('When called with home_input_email should return email as the NAME',
          () {
        var creator = const AutomationKeyCreator();
        var automationkey =
            creator.getAutomationKeyFromKeyValue('home_input_email')!;

        expect(automationkey.name, 'email');
      });
    });

    group('getAutomationKeysFromStrings -', () {
      test(
          'Given a list of valid keys should return AutomationKeys for all items',
          () {
        var creator = const AutomationKeyCreator();
        var listKeys = [
          'login_input_email',
          'login_input_password',
          'login_touchable_login',
        ];
        var automationKeys = creator.getAutomationKeysFromStrings(listKeys);
        expect(automationKeys.length, 3);
      });
    });
  });
}
