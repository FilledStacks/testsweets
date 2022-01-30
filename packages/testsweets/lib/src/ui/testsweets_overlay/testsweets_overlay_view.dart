import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:testsweets/src/setup_code.dart';
import 'package:testsweets/src/ui/driver_layout/driver_layout_view.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_view.dart';

class TestSweetsOverlayView extends StatelessWidget {
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
    this.captureWidgets,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: enabled
          ? (captureWidgets ?? !DRIVE_MODE)
              ? WidgetCaptureView(child: child, projectId: projectId)
              : DriverLayoutView(child: child, projectId: projectId)
          : child,
    );
  }
}
