import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:testsweets/src/extensions/capture_widget_status_enum_extension.dart';
import 'package:testsweets/src/ui/shared/busy_indecator.dart';
import 'package:testsweets/src/ui/shared/widgets_visualizer.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_view.form.dart';

import 'package:testsweets/src/ui/widget_capture/widget_capture_viewmodel.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_widgets/info_form.dart';

import 'widget_capture_widgets/draggable_widget.dart';

@FormView(fields: [
  FormTextField(name: 'widgetName'),
])
class WidgetCaptureView extends StatelessWidget with $WidgetCaptureView {
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
      onModelReady: (model) {
        model.loadWidgetDescriptions();
        return listenToFormUpdated(model);
      },
      builder: (context, model, _) => Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            child,
            model.captureWidgetStatusEnum.infoFormMode
                ? DraggableWidget()
                : WidgetsVisualizer(
                    widgetDescriptions: model.descriptionsForView,
                  ),
            InfoForm(
              focusNode: widgetNameFocusNode,
              textEditingController: widgetNameController,
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
