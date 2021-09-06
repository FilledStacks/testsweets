import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:testsweets/src/constants/app_constants.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';
import 'package:testsweets/src/ui/shared/cta_button.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_view.form.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_viewmodel.dart';

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
          key: Key(MediaQuery.of(context).size.toString()),
          builder: () => Overlay(
                initialEntries: [
                  OverlayEntry(
                      builder: (context) => Stack(
                            children: [
                              child,
                              if (!model.hasWidgetDesription &&
                                  model.captureViewEnabled)
                                _WidgetDescriptionCaptureLayer(),
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
                                          _MainViewLayout(),
                                        if (model.captureViewEnabled)
                                          _CaptureViewLayout(),
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

class _MainViewLayout extends ViewModelWidget<WidgetCaptureViewModel> {
  const _MainViewLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetCaptureViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CtaButton(
          title: 'Inspect View',
          fillColor: kcPrimaryFuchsia,
          onTap: model.toggleCaptureView,
        ),
        const SizedBox(
          height: 16,
        ),
        CtaButton(
          title: 'Start Capture',
          fillColor: kcPrimaryPurple,
          onTap: model.toggleCaptureView,
        ),
      ],
    );
  }
}

class _CaptureViewLayout extends ViewModelWidget<WidgetCaptureViewModel> {
  const _CaptureViewLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetCaptureViewModel model) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CtaButton(
            title: 'Add Widget',
            fillColor: kcPassedTestGreenColor,
            onTap: model.toggleCaptureView,
          ),
          CtaButton(
            title: 'Exit Capture',
            fillColor: kcPrimaryPurple,
            onTap: model.toggleCaptureView,
          ),
        ],
      ),
    );
  }
}

/// The widget that sits at the top and allows you to tap on screen and add a [WidgetDescription]
/// to the view
class _WidgetDescriptionCaptureLayer
    extends ViewModelWidget<WidgetCaptureViewModel> {
  const _WidgetDescriptionCaptureLayer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetCaptureViewModel model) {
    return Positioned.fill(
        child: GestureDetector(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.bottomRight,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            border: Border.all(
          color: Colors.blue,
          width: 5,
        )),
      ),
      onTapUp: (touchEvent) {
        var localTouchPosition = (context.findRenderObject() as RenderBox)
            .globalToLocal(touchEvent.globalPosition);

        model.addWidgetAtTap(
          x: localTouchPosition.dx,
          y: localTouchPosition.dy,
        );
      },
    ));
  }
}
