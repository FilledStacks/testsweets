import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:testsweets/src/ui/shared/busy_indecator.dart';
import 'package:testsweets/src/ui/shared/route_banner.dart';

import 'package:testsweets/src/ui/widget_capture/widget_capture_viewmodel.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_widgets/capture_overlay.dart';
import 'package:testsweets/testsweets.dart';

class WidgetCaptureView extends StatelessWidget {
  final String projectId;
  final String? apiKey;
  final Widget child;

  WidgetCaptureView({
    required this.child,
    required this.projectId,
    this.apiKey,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ViewModelBuilder<WidgetCaptureViewModel>.reactive(
      disposeViewModel: false,
      onModelReady: (model) async {
        await model.loadWidgetDescriptions();
        model.screenCenterPosition = WidgetPosition(
            capturedDeviceHeight: size.height,
            capturedDeviceWidth: size.width,
            x: size.width / 2,
            y: size.height / 2);
      },
      builder: (context, model, _) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            NotificationListener(
                onNotification: (notification) {
                  if (notification is Notification) {
                    model.onClientNotifiaction(notification);
                  }
                  return false;
                },
                child: child),
            Align(
              alignment: Alignment.topLeft,
              child: RouteBanner(
                isCaptured: model.currentViewCaptured,
                routeName: model.currentViewName,
              ),
            ),
            const CaptureOverlay(),
            BusyIndicator(
              enable: model.isBusy,
            )
          ],
        ),
      ),
      viewModelBuilder: () => WidgetCaptureViewModel(projectId: projectId),
    );
  }
}
