import 'package:stacked/stacked.dart';

class RunConfigurationService with ListenableServiceMixin {
  bool _driveModeActive = false;

  bool get driveModeActive => _driveModeActive;

  set driveModeActive(bool value) {
    _driveModeActive = value;
    notifyListeners();
  }
}
