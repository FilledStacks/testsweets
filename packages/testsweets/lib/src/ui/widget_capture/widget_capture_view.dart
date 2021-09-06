import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:testsweets/src/constants/app_constants.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_view.form.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_viewmodel.dart';

import 'widget_capture_widgets/capture_view_layout.dart';
import 'widget_capture_widgets/main_view_layout.dart';
import 'widget_capture_widgets/widget_description_capture_layer.dart';

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
          builder: () => Overlay(
                initialEntries: [
                  OverlayEntry(
                      builder: (context) => Stack(
                            children: [
                              child,
                              if (!model.hasWidgetDesription &&
                                  model.captureViewEnabled)
                                WidgetDescriptionCaptureLayer(),
                              if (model.hasWidgetDesription &&
                                  model.captureViewEnabled) ...[
                                Positioned.fill(
                                  child: Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.pink,
                                        width: 5,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: model.descriptionTop,
                                    left: model.descriptionLeft,
                                    child: GestureDetector(
                                      onPanUpdate: (panEvent) {
                                        final x = panEvent.delta.dx;
                                        final y = panEvent.delta.dy;
                                        model.updateDescriptionPosition(x, y);
                                      },
                                      child: Container(
                                        width: WidgetDiscriptionVisualSize,
                                        height: WidgetDiscriptionVisualSize,
                                        decoration: BoxDecoration(
                                          color: Colors.pink,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    )),
                              ],
                              if (model.hasWidgetDesription &&
                                  model.captureViewEnabled)
                                AnimatedPositioned(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInCubic,
                                  left: 10,
                                  bottom: model.hasWidgetNameFocus ? null : 20,
                                  top: model.hasWidgetNameFocus ? 20 : null,
                                  child: SizedBox(
                                    width: 150,
                                    child: TextField(
                                      focusNode: widgetNameFocusNode,
                                      controller: widgetNameController,
                                      decoration: InputDecoration(
                                          hintText: 'Enter widget name'),
                                    ),
                                  ),
                                ),
                              Positioned(
                                  bottom: 20,
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    width: ScreenUtil().screenWidth,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        if (!model.captureViewEnabled)
                                          MainViewLayout(),
                                        if (model.captureViewEnabled)
                                          CaptureViewLayout(),
                                      ],
                                    ),
                                  ))
                            ],
                          ))
                ],
              )),
      viewModelBuilder: () => WidgetCaptureViewModel(projectId: projectId),
    );
  }
}
