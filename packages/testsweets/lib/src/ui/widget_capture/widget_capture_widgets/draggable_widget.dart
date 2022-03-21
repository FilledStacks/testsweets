import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:testsweets/src/extensions/widget_description_extension.dart';
import 'package:testsweets/src/extensions/widget_position_extension.dart';

import 'package:testsweets/src/ui/widget_capture/widget_capture_viewmodel.dart';

import 'widget_circle.dart';

class DraggableWidget extends ViewModelWidget<WidgetCaptureViewModel> {
  const DraggableWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetCaptureViewModel model) {
    final size = MediaQuery.of(context).size;
    return model.inProgressInteraction == null
        ? const SizedBox()
        : Positioned(
            top: model.inProgressInteraction!.position.offsetAfterScroll.dy,
            left: model.inProgressInteraction!.position.offsetAfterScroll.dx,
            child: GestureDetector(
              onPanUpdate: (panEvent) {
                final x = panEvent.globalPosition.dx;
                final y = panEvent.globalPosition.dy;
                model.updateDescriptionPosition(x, y, size.width, size.height);
              },
              child: WidgetCircle(
                transparency: model.inProgressInteraction!.visibility ? 1 : 0.5,
                widgetType: model.inProgressInteraction!.widgetType,
              ),
            ));
  }
}
