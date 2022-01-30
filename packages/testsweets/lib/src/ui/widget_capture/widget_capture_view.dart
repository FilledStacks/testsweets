import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:testsweets/src/enums/capture_widget_enum.dart';
import 'package:testsweets/src/extensions/capture_widget_status_enum_extension.dart';

import 'package:testsweets/src/ui/widget_capture/widget_capture_view.form.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_viewmodel.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_widgets/info_form.dart';

import 'widget_capture_widgets/draggable_bottom_sheet.dart';

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
        listenToFormUpdated(model);
        // widgetNameFocusNode.addListener(() {
        //   model.setWidgetNameFocused(widgetNameFocusNode.hasFocus);
        // });
      },
      builder: (context, model, _) => Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            child,
            if (model.captureWidgetStatusEnum.selectWidgetTypeMode)
              DraggableBottomSheet(),
            if (model.captureWidgetStatusEnum.infoFormMode)
              InfoForm(
                submitWidgetInfoForm: model.submitWidgetInfoForm,
                closeWidgetInfoForm: model.closeInfoForm,
              ),
          ],
        ),
      ),
      viewModelBuilder: () => WidgetCaptureViewModel(projectId: projectId),
    );
  }
}
