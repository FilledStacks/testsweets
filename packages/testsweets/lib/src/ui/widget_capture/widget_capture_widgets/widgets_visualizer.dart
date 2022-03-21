import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testsweets/src/constants/app_constants.dart';
import 'package:testsweets/src/extensions/capture_widget_status_enum_extension.dart';

import 'package:testsweets/src/extensions/widget_position_extension.dart';
import 'package:testsweets/src/extensions/widget_description_extension.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:testsweets/src/ui/shared/popup_menu/popup_menu.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_viewmodel.dart';

import 'draggable_widget.dart';

class WidgetsVisualizer extends StatelessWidget {
  final Function editActionSelected;
  const WidgetsVisualizer({
    Key? key,
    required this.editActionSelected,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = context.watch<WidgetCaptureViewModel>();
    return Stack(
      fit: StackFit.expand,
      children: [
        if (model.captureWidgetStatusEnum.showWidgets)
          ValueListenableBuilder(
              valueListenable: model.descriptionsForViewNotifier,
              builder: (context, descriptionsForView, _) {
                return Stack(
                  children: [
                    ...model.viewInteractions
                        .where((interaciton) => interaciton.notView)
                        .where(visibleOnScreen)
                        .map(
                          (description) => Positioned(
                            top: description.position.offsetAfterScroll.dy,
                            left: description.position.offsetAfterScroll.dx,
                            child: PopupMenu(
                                description: description,
                                editActionSelected: editActionSelected),
                          ),
                        ),
                  ],
                );
              }),
        if (model.captureWidgetStatusEnum.showDraggableWidget)
          DraggableWidget(),
      ],
    );
  }

  bool visibleOnScreen(Interaction interaction) {
    final unionRect = interaction.externalities?.reduce((rect, nextRect) {
      final result = rect.expandToInclude(nextRect);
      return SerializableRect.fromLTWH(
          result.left, result.top, result.width, result.height);
    });

    final visible = unionRect?.contains(interaction.position.offsetAfterScroll +
        Offset(WIDGET_DESCRIPTION_VISUAL_SIZE / 2,
            WIDGET_DESCRIPTION_VISUAL_SIZE / 2));

    return visible ?? true;
  }
}
