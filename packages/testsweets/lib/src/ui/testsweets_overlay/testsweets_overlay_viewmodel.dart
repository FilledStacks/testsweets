import 'package:stacked/stacked.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/services/local_config_service.dart';
import 'package:testsweets/src/services/run_configuration_service.dart';

class TestSweetsOverlayViewModel extends ReactiveViewModel {
  final _localConfigService = locator<LocalConfigService>();
  final _runConfigurationService = locator<RunConfigurationService>();

  bool get enabled => _localConfigService.enabled;

  bool get driveModeActive => _runConfigurationService.driveModeActive;

  @override
  List<ListenableServiceMixin> get listenableServices => [
        _runConfigurationService,
      ];
}
