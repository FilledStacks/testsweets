import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:testsweets/src/extensions/capture_widget_status_enum_extension.dart';
import 'package:testsweets/src/ui/shared/busy_indecator.dart';
import 'package:testsweets/src/ui/shared/widgets_visualizer.dart';

import 'package:testsweets/src/ui/widget_capture/widget_capture_viewmodel.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_widgets/info_form.dart';

import 'widget_capture_widgets/draggable_widget.dart';
import 'widget_capture_widgets/type_selector.dart';

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
    return ViewModelBuilder<WidgetCaptureViewModel>.reactive(
      onModelReady: (model) => model.loadWidgetDescriptions(),
      builder: (context, model, _) => Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            child,
            if (model.captureWidgetStatusEnum.widgetTypeSelector)
              TypeSelector(),
            if (model.captureWidgetStatusEnum.infoFormMode) ...[
              DraggableWidget(),
              InfoForm(),
            ],
            WidgetsVisualizer(
              widgetDescriptions: model.descriptionsForView,
            ),
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
