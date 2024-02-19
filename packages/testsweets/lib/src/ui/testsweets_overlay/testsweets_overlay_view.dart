import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:testsweets/src/setup_code.dart';
import 'package:testsweets/src/ui/driver_layout/driver_layout_view.dart';
import 'package:testsweets/src/ui/mode_swap_banner.dart';
import 'package:testsweets/src/ui/testsweets_overlay/testsweets_overlay_viewmodel.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_view.dart';

class TestSweetsOverlayView extends StackedView<TestSweetsOverlayViewModel> {
  final Widget child;

  /// The projectId as seen in the settings of the TestSweets project
  final String projectId;

  /// Puts the overlay into widget capture mode
  final bool? captureWidgets;

  /// When true we add the TestSweets overlay, default is true
  final bool enabled;

  const TestSweetsOverlayView({
    Key? key,
    required this.child,
    required this.projectId,
    @Deprecated(
      'Capture mode can be updated by tapping on screen with 3 fingers. This property is not required anymore.',
    )
    this.captureWidgets,
    @Deprecated('Now we get this value from setupTestSweets function.')
    this.enabled = kDebugMode,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TestSweetsOverlayViewModel viewModel,
    Widget? _,
  ) {
    return viewModel.enabled
        ? Listener(
            onPointerDown: (_) => viewModel.addTouchPointer(),
            onPointerUp: (_) => viewModel.removeTouchPointer(),
            child: Overlay(
              initialEntries: [
                OverlayEntry(
                    builder: (_) => tsCaptureModeActive
                        ? WidgetCaptureView(
                            child: child,
                            projectId: projectId,
                            onRouteBannerLongPress: viewModel.toggleOverlayUI,
                          )
                        : DriverLayoutView(
                            child: child,
                            projectId: projectId,
                            onRouteBannerLongPress: viewModel.toggleOverlayUI,
                          )),
                OverlayEntry(
                  builder: (_) => viewModel.showModeSwapUI
                      ? ModeSwapBanner(
                          onClosePressed: viewModel.toggleOverlayUI,
                          onCaptureMode: viewModel.setCaptureMode,
                          captureModeActive: viewModel.captureMode,
                          showRestartMessage: viewModel.showRestartMessage,
                        )
                      : SizedBox.shrink(),
                )
              ],
            ),
          )
        : child;
  }

  @override
  TestSweetsOverlayViewModel viewModelBuilder(BuildContext context) {
    return TestSweetsOverlayViewModel(
      startingCaptureValue: tsCaptureModeActive,
    );
  }
}
