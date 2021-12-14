import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:testsweets/src/enums/capture_widget_enum.dart';
import 'package:testsweets/src/extensions/capture_widget_status_enum_extension.dart';
import 'package:testsweets/src/ui/shared/busy_indecator.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_view.form.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_viewmodel.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_widgets/stop_inspect_controllers.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_widgets/widget_description_dialog.dart';
import 'package:testsweets/src/ui/widget_inspector.dart';

import 'widget_capture_widgets/capture_controllers.dart';
import 'widget_capture_widgets/capture_layout.dart';
import 'widget_capture_widgets/inspect_controllers.dart';
import 'widget_capture_widgets/intro_controllers.dart';

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

  final List<String> _classesOfInterest = [
    (GestureDetector).toString(),
    (TextField).toString(),
  ];

  List<WidgetInfo> getElements(BuildContext context) {
    var widgetsOfInterest = <WidgetInfo>[];
    widgetsOfInterest.clear();

    int indentation = 0;

    void visitor(Element element) {
      indentation++;

      Key? key = element.widget.key;
      String className = element.widget.runtimeType.toString();

      if (element.findRenderObject() is RenderBox) {
        RenderBox box = element.findRenderObject() as RenderBox;
        var offset = box.getTransformTo(null).getTranslation();

        print('$className');

        if (_classesOfInterest.contains(className)) {
          widgetsOfInterest.add(WidgetInfo(
            indentation: indentation,
            size: box.size,
            paintBounds: box.paintBounds.shift(
              Offset(offset.x, offset.y),
            ),
            key: key,
            className: className,
          ));
        }
      }

      element.visitChildren(visitor);
    }

    context.visitChildElements(visitor);

    return widgetsOfInterest;
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WidgetCaptureViewModel>.reactive(
      onModelReady: (model) {
        listenToFormUpdated(model);

        widgetNameFocusNode.addListener(() {
          model.setWidgetNameFocused(widgetNameFocusNode.hasFocus);
        });

        // model.setCaptureCallback(() {});
      },
      builder: (context, model, _) {
        if (model.rebuildAutomaticCapturedWidgets) {
          SchedulerBinding.instance?.addPostFrameCallback((_) {
            Future.delayed(Duration(seconds: 2)).then(
                (value) => model.setWidgetsOfInterest(getElements(context)));
          });
        }
        return ScreenUtilInit(
            builder: () => Overlay(
                  initialEntries: [
                    OverlayEntry(
                        builder: (context) => Stack(
                              fit: StackFit.expand,
                              children: [
                                child,
                                if (model.captureWidgetStatusEnum
                                    .isAtInspectModeMode)
                                  InspectControllers(
                                      widgetNameController:
                                          widgetNameController,
                                      widgetNameFocusNode: widgetNameFocusNode),
                                if (model
                                    .captureWidgetStatusEnum.isAtCaptureMode)
                                  CaptureLayout(
                                      widgetNameController:
                                          widgetNameController,
                                      widgetNameFocusNode: widgetNameFocusNode),
                                if (model.captureWidgetStatusEnum ==
                                    CaptureWidgetStatusEnum.idle)
                                  IntroControllers(),
                                if (model.captureWidgetStatusEnum ==
                                    CaptureWidgetStatusEnum.inspectMode)
                                  StopInspectControllers(),
                                Positioned(
                                    bottom: 20,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                      width: ScreenUtil().screenWidth,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          if (model.captureWidgetStatusEnum ==
                                                  CaptureWidgetStatusEnum
                                                      .captureMode ||
                                              model.captureWidgetStatusEnum ==
                                                  CaptureWidgetStatusEnum
                                                      .captureModeWidgetsContainerShow ||
                                              model.captureWidgetStatusEnum ==
                                                  CaptureWidgetStatusEnum
                                                      .captureModeAddWidget)
                                            CaptureControllers(),
                                        ],
                                      ),
                                    )),
                                AnimatedPositioned(
                                  duration: Duration(milliseconds: 500),
                                  bottom: model.captureWidgetStatusEnum ==
                                          CaptureWidgetStatusEnum
                                              .inspectModeDialogShow
                                      ? 20
                                      : -200,
                                  child: AnimatedSwitcher(
                                    duration: Duration(milliseconds: 500),
                                    child: model.captureWidgetStatusEnum ==
                                            CaptureWidgetStatusEnum
                                                .inspectModeDialogShow
                                        ? Center(
                                            child: WidgetDescriptionDialog(
                                              updateTextControllerText: () {
                                                widgetNameController.text =
                                                    model.widgetDescription!
                                                        .name;
                                              },
                                            ),
                                          )
                                        : SizedBox.shrink(),
                                  ),
                                ),
                                BusyIndicator(
                                  enable: model.isBusy,
                                ),
                              ],
                            ))
                  ],
                ));
      },
      viewModelBuilder: () => WidgetCaptureViewModel(projectId: projectId),
    );
  }
}
