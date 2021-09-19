import 'package:test/test.dart';
import 'package:testsweets/src/services/validate_widget_description.dart';

import '../helpers/test_helpers.dart';

final _widgetDescriptionName = ValidateWidgetDescriptionName();
final _widgetDescriptionView = ValidateWidgetDescriptionViewName();
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
      group('deValidate -', () {
        test(
            'When called and widget name is `loginEmailInput`, Should convert to `login email input`',
            () {
          final result = _widgetDescriptionName.deValidate('loginEmailInput');
          expect(result, 'login email input');
        });
      });
    });
    group('ValidateWidgetDescriptionViewName -', () {
      test('When called and view name is `/`, Should convert to `initialView',
          () {
        final result =
            _widgetDescriptionView.ifTextNotValidConvertToValidText('/');
        expect(result, 'initialView');
      });
      test(
          'When called and view name is `/login-view`, Should convert to `loginView',
          () {
        final result = _widgetDescriptionView
            .ifTextNotValidConvertToValidText('/login-view');
        expect(result, 'loginView');
      });
    });
  });
}
