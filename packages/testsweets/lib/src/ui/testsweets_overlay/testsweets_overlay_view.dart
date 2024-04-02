import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:testsweets/src/ui/driver_layout/driver_layout_view.dart';
import 'package:testsweets/src/ui/testsweets_overlay/testsweets_overlay_viewmodel.dart';
import 'package:testsweets/testsweets.dart';

class TestSweetsOverlayView extends StackedView<TestSweetsOverlayViewModel> {
  final Widget child;

  /// The projectId as seen in the settings of the TestSweets project
  final String projectId;

  /// Puts the overlay into widget capture mode
  final bool? captureWidgets;

  /// When true we add the TestSweets overlay, default is true
  final bool enabled;
  TestSweetsOverlayView({
    Key? key,
    required this.child,
    required this.projectId,
    @Deprecated(
      'TestSweets will manage captureMode. This value is not used anymore',
    )
    this.captureWidgets,
    @Deprecated('Now we get this value from setupTestSweets function.')
    this.enabled = kDebugMode,
  }) : super(key: key);

  @override
  Widget builder(
      BuildContext context, TestSweetsOverlayViewModel viewModel, Widget? _) {
    return viewModel.enabled
        ? Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (_) => !viewModel.driveModeActive
                    ? WidgetCaptureView(
                        child: child,
                        projectId: projectId,
                      )
                    : DriverLayoutView(
                        child: child,
                        projectId: projectId,
                      ),
              ),
            ],
          )
        : child;
  }

  @override
  TestSweetsOverlayViewModel viewModelBuilder(BuildContext context) {
    return TestSweetsOverlayViewModel();
  }
}
