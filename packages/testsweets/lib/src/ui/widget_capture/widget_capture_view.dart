import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/extensions/capture_widget_status_enum_extension.dart';
import 'package:testsweets/src/ui/shared/busy_indecator.dart';
import 'package:testsweets/src/ui/shared/route_banner.dart';
import 'package:testsweets/src/ui/shared/utils.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_widgets/widgets_visualizer.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_view_form.dart';

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
      staticChild: child,
      disposeViewModel: false,
      onModelReady: (model) async {
        await model.loadWidgetDescriptions();
        model.screenCenterPosition = WidgetPosition(
            capturedDeviceHeight: size.height,
            capturedDeviceWidth: size.width,
            x: size.width / 2,
            y: size.height / 2);
      },
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // Client app
            child!,

            Align(
              alignment: Alignment.topLeft,
              child: RouteBanner(
                isCaptured: model.currentViewIsCaptured,
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
