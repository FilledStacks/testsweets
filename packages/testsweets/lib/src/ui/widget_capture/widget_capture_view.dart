import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:testsweets/src/constants/app_constants.dart';
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
      builder: (context, model, _) => Overlay(
        initialEntries: [
          OverlayEntry(
              builder: (context) => Stack(
                    children: [
                      child,
                      if (!model.hasWidgetDesription &&
                          model.captureViewEnabled)
                        _WidgetDescriptionCaptureLayer(),
                      if (model.hasWidgetDesription && model.captureViewEnabled)
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
                      if (model.hasWidgetDesription && model.captureViewEnabled)
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
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            )),
                      if (model.hasWidgetDesription && model.captureViewEnabled)
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
                          right: 20,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (!model.captureViewEnabled)
                                MaterialButton(
                                  onPressed: model.toggleCaptureView,
                                  color: Colors.green,
                                  child: Text('Capture Widget'),
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
                                        model.hasWidgetDesription)
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
                          ))
                    ],
                  ))
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
