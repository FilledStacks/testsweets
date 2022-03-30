import 'package:flutter_test/flutter_test.dart';
import 'package:testsweets/src/services/test_integrity.dart';

import '../helpers/test_consts.dart';

void main() {
  group('ScrollableTestIntegrity -', () {
    group('startListeningReturnTrueIfCommandVerifiedOrFalseOnTimeout -', () {
      test('''
              When the timeoutTimer reaches the given duration, 
              Should execute the commandExecutingFails 
              which returns false from the completer''', () async {
        final testIntegrity = ScrollableTestIntegrity();

        final result = await testIntegrity
            .startListeningReturnTrueIfCommandVerifiedOrFalseOnTimeout(
                kTimeoutDuration);
        expect(result, false);
      });
      test('''
              When commandExecutingConfirmed executed before
              the timeoutTimer reaches the given duration, 
              Completer should return true''', () async {
        final testIntegrity = ScrollableTestIntegrity();

        final result = testIntegrity
            .startListeningReturnTrueIfCommandVerifiedOrFalseOnTimeout(
                kTimeoutDuration);
        testIntegrity.commandExecutingConfirmed();

        expect(await result, true);
      });
    });
    group('whenNotificationTypeMatchesConfirmCommand -', () {
      test('''
              When Notification Type Matches,
              Should call commandExecutingConfirmed''', () async {
        final testIntegrity = ScrollableTestIntegrity();

        final result = testIntegrity
            .startListeningReturnTrueIfCommandVerifiedOrFalseOnTimeout(
                kTimeoutDuration);
        testIntegrity
            .whenNotificationTypeMatchesConfirmCommand(kScrollEndNotification);

        expect(await result, true);
      });
    });
  });
}
