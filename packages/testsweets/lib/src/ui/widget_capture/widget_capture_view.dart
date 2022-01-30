import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';

import 'package:testsweets/src/ui/widget_capture/widget_capture_view.form.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_viewmodel.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_widgets_2/bottom_sheet_body.dart';

@FormView(fields: [FormTextField(name: 'widgetName')])
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
        widgetNameFocusNode.addListener(() {
          model.setWidgetNameFocused(widgetNameFocusNode.hasFocus);
        });
      },
      builder: (context, model, _) => ScreenUtilInit(
          builder: () => Scaffold(
                body: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    child,
                    SolidBottomSheet(
                      headerBar: SvgPicture.asset(
                        'packages/testsweets/assets/svgs/up_arrow_handle.svg',
                      ),
                      minHeight: 0,
                      maxHeight: 125,
                      toggleVisibilityOnTap: true,
                      body: BottomSheetBody(
                        onWidgetTypeTap: (widgetType) {},
                      ),
                    ),
                  ],
                ),
              )),
      viewModelBuilder: () => WidgetCaptureViewModel(projectId: projectId),
    );
  }
}
