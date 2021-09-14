import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:testsweets/src/ui/driver_layout/driver_layout_view.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_view.dart';

class TestSweetsOverlayView extends StatelessWidget {
  final Widget child;

  /// The projectId as seen in the settings of the TestSweets project
  final String projectId;

  /// Puts the overlay into widget capture mode
  final bool captureWidgets;

  const TestSweetsOverlayView({
    Key? key,
    required this.child,
    required this.projectId,
    this.captureWidgets = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: kDebugMode
          ? captureWidgets
              ? WidgetCaptureView(child: child, projectId: projectId)
              : DriverLayoutView(child: child, projectId: projectId)
          : child,
    );
  }
}
