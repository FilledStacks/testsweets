import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:testsweets/src/app/logger.dart';

class TestIntegrity {
  final log = getLogger('TestIntegrity');
  Completer<bool>? _completer;
  Timer? _timeoutTimer;
  Type? triggeringNotificationType;

  void failCommand() {
    // log.v('');
    _completer?.complete(false);
  }

  void confirmCommand() {
    // log.v('');
    _timeoutTimer?.cancel();
    _completer?.complete(true);
  }

  void whenNotificationTypeMatchesConfirmCommand(Notification notification) {
    // log.v(notification.runtimeType);

    if (triggeringNotificationType != null &&
        triggeringNotificationType == notification.runtimeType) {
      confirmCommand();
    }
  }

  Future<bool> trueIfCommandVerifiedOrFalseIfTimeout(Duration timeoutDuration) {
    // log.v('');
    _completer = Completer();

    _timeoutTimer = Timer(timeoutDuration, failCommand);

    return _completer!.future;
  }
}
