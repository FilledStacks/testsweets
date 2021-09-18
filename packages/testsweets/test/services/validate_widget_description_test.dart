import 'package:test/test.dart';
import 'package:testsweets/src/services/validate_widget_description.dart';

import '../helpers/test_helpers.dart';

final _widgetDescriptionName = ValidateWidgetDescriptionName();
void main() {
  group('ValidateWidgetDescriptionTest -', () {
    setUp(registerServices);
    tearDown(unregisterServices);

    group('ValidateWidgetDescriptionName -', () {
      group('ifTextNotValidConvertToValidText -', () {
        test(
            'When called and widget name is `   login email input`, Should convert to loginEmailInput',
            () {
          final result = _widgetDescriptionName
              .ifTextNotValidConvertToValidText('   login email input');
          expect(result, 'loginEmailInput');
        });
        test(
            'When called and widget name is `login email input`, Should convert to loginEmailInput',
            () {
          final result = _widgetDescriptionName
              .ifTextNotValidConvertToValidText('login email input');
          expect(result, 'loginEmailInput');
        });
        test(
            'When called and widget name is `login Email input`, Should convert to loginEmailInput',
            () {
          final result = _widgetDescriptionName
              .ifTextNotValidConvertToValidText('login Email input');
          expect(result, 'loginEmailInput');
        });
        test(
            'When called and widget name is `login         Email input`, Should convert to loginEmailInput',
            () {
          final result = _widgetDescriptionName
              .ifTextNotValidConvertToValidText('login           Email input');
          expect(result, 'loginEmailInput');
        });
        test(
            'When called and widget name is `login Email1 input`, Should convert to loginEmail1Input',
            () {
          final result = _widgetDescriptionName
              .ifTextNotValidConvertToValidText('login Email1 input');
          expect(result, 'loginEmail1Input');
        });
        test(
            'When called and widget name is `login 1Email1 input`, Should convert to login1Email1Input',
            () {
          final result = _widgetDescriptionName
              .ifTextNotValidConvertToValidText('login 1Email1 input');
          expect(result, 'login1Email1Input');
        });
      });
    });
  });
}
