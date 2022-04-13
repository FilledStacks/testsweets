import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:testsweets/src/extensions/capture_widget_status_enum_extension.dart';

import 'package:testsweets/src/ui/shared/busy_indecator.dart';
import 'package:testsweets/src/ui/shared/route_banner.dart';

import 'package:testsweets/src/ui/widget_capture/widget_capture_viewmodel.dart';
import 'package:testsweets/testsweets.dart';

import 'widgets/draggable_widget.dart';
import 'widgets/interaction_form_and_visualizer.dart';

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

            /// Show the current route name and whether its captured or not
            Align(
              alignment: Alignment.topLeft,
              child: RouteBanner(
                isCaptured: model.currentViewCaptured,
                routeName: model.currentViewName,
              ),
            ),
            if (model.captureWidgetStatusEnum.showDraggableWidget)
              const DraggableWidget(),

            const InteractionFormAndVisualizer(),

            BusyIndicator(
              enable: model.busy(WidgetCaptureViewModel.sideBusyIndicator),
            ),
            BusyIndicator(
              enable:
                  model.busy(WidgetCaptureViewModel.fullScreenBusyIndicator),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => WidgetCaptureViewModel(projectId: projectId),
    );
  }
}
