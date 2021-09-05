import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_view.form.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_viewmodel.dart';

@FormView(fields: [FormTextField(name: 'widgetName')])
class WidgetCaptureView extends StatelessWidget with $WidgetCaptureView {
  final Widget child;

  WidgetCaptureView({required this.child});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WidgetCaptureViewModel>.reactive(
      onModelReady: (model) => listenToFormUpdated(model),
      builder: (context, model, _) => Stack(
        children: [
          child,
          if (!model.hasWidgetDesription) _WidgetDescriptionCaptureLayer(),
          if (model.hasWidgetDesription)
            Positioned.fill(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: MaterialButton(
                  color: Colors.pinkAccent,
                  onPressed: model.saveWidgetDescription,
                ),
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.pink,
                    width: 5,
                  ),
                ),
              ),
            ),
          if (model.hasWidgetDesription)
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
          if (model.hasWidgetDesription)
            Positioned(
              left: 10,
              bottom: 15,
              child: SizedBox(
                width: 150,
                child: TextField(
                  controller: widgetNameController,
                  decoration: InputDecoration(hintText: 'Enter widget name'),
                ),
              ),
            )
        ],
      ),
      viewModelBuilder: () => WidgetCaptureViewModel(),
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
        child: Text('Capture Mode Active'),
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
