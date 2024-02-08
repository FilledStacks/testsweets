import 'dart:collection';

import 'package:stacked/stacked.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/services/local_config_service.dart';
import 'package:testsweets/testsweets.dart';

class TestSweetsOverlayViewModel extends BaseViewModel {
  final _localConfigService = locator<LocalConfigService>();

  final bool startingCaptureValue;
  TestSweetsOverlayViewModel({required this.startingCaptureValue});

  bool _showModeSwapUI = false;
  bool get showModeSwapUI => _showModeSwapUI;

  bool get showRestartMessage =>
      startingCaptureValue != _localConfigService.captureMode;

  Queue<bool> _touchQueue = Queue<bool>();

  void addTouchPointer() {
    _touchQueue.add(true);

    if (_touchQueue.length >= 3) {
      _showModeSwapUI = !_showModeSwapUI;
      rebuildUi();
    }
  }

  void removeTouchPointer() {
    _touchQueue.removeFirst();
  }

  bool get captureMode => tsCaptureModeActive;

  Future<void> setCaptureMode(bool value) async {
    _localConfigService.setCaptureMode(value);
    rebuildUi();
  }

  void toggleOverlayUI() {
    _showModeSwapUI = !_showModeSwapUI;
    rebuildUi();
  }
}
