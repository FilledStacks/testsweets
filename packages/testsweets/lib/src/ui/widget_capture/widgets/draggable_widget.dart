import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:testsweets/src/extensions/widget_position_extension.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_viewmodel.dart';

import '../../shared/interaction_circle.dart';

class DraggableWidget extends ViewModelWidget<WidgetCaptureViewModel> {
  const DraggableWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetCaptureViewModel model) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return model.inProgressInteraction == null
        ? const SizedBox()
        : Positioned(
            top: model.inProgressInteraction!.renderPosition
                .responsiveYPosition(size.height),
            left: model.inProgressInteraction!.renderPosition
                .responsiveXPosition(size.width),
            child: GestureDetector(
              onPanUpdate: (panEvent) {
                final x = panEvent.globalPosition.dx;
                final y = panEvent.globalPosition.dy;
                model.updateDescriptionPosition(
                    x: x,
                    y: y,
                    currentWidth: size.width,
                    currentHeight: size.height,
                    orientation: orientation);
              },
              child: InteractionCircle(
                transparency: model.inProgressInteraction!.visibility ? 1 : 0.5,
                widgetType: model.inProgressInteraction!.widgetType,
              ),
            ));
  }
}
