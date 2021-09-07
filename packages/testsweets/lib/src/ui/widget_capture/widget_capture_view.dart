import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:testsweets/src/constants/app_constants.dart';
import 'package:testsweets/src/ui/shared/shared_colors.dart';
import 'package:testsweets/src/ui/shared/widgets/inspect_layout_widget.dart';
import 'package:testsweets/src/ui/shared/widgets/widget_description_dialog_widget.dart';
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
        SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
          model.initialise(projectId);
        });
      },
      builder: (context, model, _) => Overlay(
        initialEntries: [
          OverlayEntry(
            builder: (context) => Stack(
              children: [
                child,
                if (model.inspectLayoutEnable) InspectLayoutView(),
                if (!model.hasWidgetDescription &&
                    model.captureViewEnabled &&
                    !model.inspectLayoutEnable)
                  _WidgetDescriptionCaptureLayer(),
                if (model.hasWidgetDescription &&
                    model.captureViewEnabled &&
                    !model.inspectLayoutEnable)
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
                if (model.hasWidgetDescription &&
                    model.captureViewEnabled &&
                    !model.inspectLayoutEnable)
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
                          width: WidgetDescriptionVisualSize,
                          height: WidgetDescriptionVisualSize,
                          decoration: BoxDecoration(
                            color: Colors.pink,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      )),
                if (model.hasWidgetDescription &&
                    model.captureViewEnabled &&
                    !model.inspectLayoutEnable)
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
                        decoration:
                            InputDecoration(hintText: 'Enter widget name'),
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (!model.captureViewEnabled)
                        Column(
                          children: [
                            MaterialButton(
                              onPressed: model.toggleInspectLayout,
                              color: kcLightPink,
                              child: Text('Inspect View',
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                            ),
                            MaterialButton(
                              onPressed: model.toggleCaptureView,
                              color: kcMainButton,
                              child: Text('Start Capture',
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                            ),
                          ],
                        ),
                      if (model.captureViewEnabled)
                        Column(
                          children: [
                            MaterialButton(
                              onPressed: model.toggleCaptureView,
                              color: Colors.red,
                              child: Text('Stop Capture'),
                            ),
                            if (model.captureViewEnabled &&
                                model.hasWidgetDescription)
                              MaterialButton(
                                color: Colors.pinkAccent,
                                child: model.isBusy
                                    ? CircularProgressIndicator()
                                    : Text('Save Widget'),
                                onPressed: model.saveWidgetDescription,
                              )
                          ],
                        ),
                    ],
                  ),
                ),
                AnimatedPositioned(
                  duration: Duration(milliseconds: 500),
                  child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      switchInCurve: Curves.bounceIn,
                      switchOutCurve: Curves.bounceOut,
                      child: model.showDescription
                          ? WidgetDescriptionDialog(
                              description: model.activeWidgetDescription,
                              onPressed: model.closeWidgetDescription,
                            )
                          : SizedBox.shrink()),
                )
              ],
            ),
          ),
        ],
      ),
      viewModelBuilder: () => WidgetCaptureViewModel(projectId: projectId),
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
