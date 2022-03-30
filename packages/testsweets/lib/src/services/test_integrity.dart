import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:testsweets/src/app/logger.dart';

class TestIntegrity<T> {
  final log = getLogger('TestIntegrity');
  Completer<bool>? _completer;
  Timer? _timeoutTimer;

  static TestIntegrity fromString(String message) {
    final messageMap = json.decode(message) as Map<String, dynamic>;
    final commandType = messageMap['commandType'];
    switch (commandType) {
      case 'ScrollCommand':
        return ScrollableTestIntegrity();
      default:
        throw Exception(
            'We couldn\'t extract the command from this message: $message');
    }
  }

  void commandExecutingFails() {
    log.v('');
    _completer?.complete(false);
  }

  void commandExecutingConfirmed() {
    log.v('');
    _timeoutTimer?.cancel();
    _completer?.complete(true);
  }

  void whenNotificationTypeMatchesConfirmCommand(Notification notification) {
    log.v(notification.runtimeType);
    if (notification is T) {
      commandExecutingConfirmed();
    }
  }

  Future<bool> startListeningReturnTrueIfCommandVerifiedOrFalseOnTimeout(
      Duration timeoutDuration) {
    log.v('');
    _completer = Completer();

    _timeoutTimer = Timer(timeoutDuration, commandExecutingFails);

    return _completer!.future;
  }
}

class ScrollableTestIntegrity extends TestIntegrity<ScrollEndNotification> {}
