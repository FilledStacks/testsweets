import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testsweets/src/services/test_integrity.dart';

import '../helpers/test_consts.dart';

void main() {
  group('TestIntegrity -', () {
    group('startListeningReturnTrueIfCommandVerifiedOrFalseOnTimeout -', () {
      test('''
              When the timeoutTimer reaches the given duration, 
              Should execute the commandExecutingFails 
              which returns false from the completer''', () async {
        final testIntegrity = TestIntegrity();

        final result = await testIntegrity
            .trueIfCommandVerifiedOrFalseIfTimeout(kTimeoutDuration);
        expect(result, false);
      });
      test('''
              When commandExecutingConfirmed executed before
              the timeoutTimer reaches the given duration, 
              Completer should return true''', () async {
        final testIntegrity = TestIntegrity();

        final result = testIntegrity
            .trueIfCommandVerifiedOrFalseIfTimeout(kTimeoutDuration);
        testIntegrity.confirmCommand();

        expect(await result, true);
      });
    });
    group('whenNotificationTypeMatchesConfirmCommand -', () {
      test('''
              When Notification Type Matches,
              Should call commandExecutingConfirmed''', () async {
        final testIntegrity = TestIntegrity();

        testIntegrity.triggeringNotificationType = ScrollEndNotification;

        final result = testIntegrity
            .trueIfCommandVerifiedOrFalseIfTimeout(kTimeoutDuration);
        testIntegrity
            .whenNotificationTypeMatchesConfirmCommand(kScrollEndNotification);

        expect(await result, true);
      });
    });
  });
}
