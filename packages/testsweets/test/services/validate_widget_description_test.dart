import 'package:flutter_test/flutter_test.dart';
import 'package:testsweets/src/extensions/string_extension.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('ValidateWidgetDescriptionTest -', () {
    setUp(registerServices);
    tearDown(unregisterServices);

    group('ValidateWidgetDescriptionName -', () {
      group('ifTextNotValidConvertToValidText -', () {
        test(
            'When called and widget name is `   login email input`, Should convert to loginEmailInput',
            () {
          final result = '   login email input'.convertWidgetNameToValidFormat;
          expect(result, 'loginEmailInput');
        });
        test(
            'When called and widget name is `login email input`, Should convert to loginEmailInput',
            () {
          final result = 'login email input'.convertWidgetNameToValidFormat;
          expect(result, 'loginEmailInput');
        });
        test(
            'When called and widget name is `login Email input`, Should convert to loginEmailInput',
            () {
          final result = 'login Email input'.convertWidgetNameToValidFormat;
          expect(result, 'loginEmailInput');
        });
        test(
            'When called and widget name is `login         Email input`, Should convert to loginEmailInput',
            () {
          final result =
              'login           Email input'.convertWidgetNameToValidFormat;
          expect(result, 'loginEmailInput');
        });
        test(
            'When called and widget name is `login Email1 input`, Should convert to loginEmail1Input',
            () {
          final result = 'login Email1 input'.convertWidgetNameToValidFormat;
          expect(result, 'loginEmail1Input');
        });
        test(
            'When called and widget name is `login 1Email1 input`, Should convert to login1Email1Input',
            () {
          final result = 'login 1Email1 input'.convertWidgetNameToValidFormat;
          expect(result, 'login1Email1Input');
        });
      });
      group('deValidate -', () {
        test(
            'When called and widget name is `loginEmailInput`, Should convert to `login email input`',
            () {
          final result = 'loginEmailInput'.restoreWidgetNameToOriginal;
          expect(result, 'login email input');
        });
      });
    });
    group('ValidateWidgetDescriptionViewName -', () {
      test('When called and view name is `/`, Should convert to `initialView',
          () {
        final result = '/'.convertViewNameToValidFormat;
        expect(result, 'initialView');
      });
      test(
          'When called and view name is `/login-view`, Should convert to `loginView',
          () {
        final result = '/login-view'.convertViewNameToValidFormat;
        expect(result, 'loginView');
      });
    });
  });
}
