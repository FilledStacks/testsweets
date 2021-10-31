import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:testsweets/src/app/app.logger.dart';
import 'package:testsweets/src/setup_code.dart';
import 'package:testsweets/src/ui/driver_layout/driver_layout_view.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_view.dart';

class TestSweetsOverlayView extends StatefulWidget {
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
  State<TestSweetsOverlayView> createState() => _TestSweetsOverlayViewState();
}

class _TestSweetsOverlayViewState extends State<TestSweetsOverlayView> {
  final log = getLogger('_TestSweetsOverlayViewState');

  @override
  Widget build(BuildContext context) {
    return Material(
      child: widget.enabled
          ? (widget.captureWidgets ?? !DRIVE_MODE)
              ? WidgetCaptureView(
                  child: widget.child,
                  projectId: widget.projectId,
                )
              : DriverLayoutView(
                  child: widget.child,
                  projectId: widget.projectId,
                )
          : widget.child,
    );
  }
}
