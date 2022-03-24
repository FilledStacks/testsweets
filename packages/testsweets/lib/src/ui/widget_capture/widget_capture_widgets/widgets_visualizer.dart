import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testsweets/src/constants/app_constants.dart';
import 'package:testsweets/src/extensions/capture_widget_status_enum_extension.dart';

import 'package:testsweets/src/extensions/widget_position_extension.dart';
import 'package:testsweets/src/extensions/interaction_extension.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:testsweets/src/ui/shared/popup_menu/popup_menu.dart';
import 'package:testsweets/src/ui/shared/route_banner.dart';
import 'package:testsweets/src/ui/shared/utils.dart';
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
                        .where(InteractionUtils.notView)
                        .where(visibleOnScreen)
                        .map(
                          (description) => Positioned(
                            top: description.position.offsetAfterScroll.dy,
                            left: description.position.offsetAfterScroll.dx,
                            child: PopupMenu(
                                description: description,
                                editActionSelected: editActionSelected),
                          ),
                        )
                  ],
                );
              }),
        if (model.captureWidgetStatusEnum.showDraggableWidget)
          DraggableWidget(),
      ],
    );
  }

  bool visibleOnScreen(Interaction interaction) {
    final unionSd = interaction.externalities?.reduce((sd, nextSd) {
      final result = sd.rect.expandToInclude(nextSd.rect);
      return sd.copyWith(
          rect: SerializableRect.fromLTWH(
              result.left, result.top, result.width, result.height));
    });

    final visible = unionSd?.rect.contains(
        interaction.position.offsetAfterScroll +
            Offset(WIDGET_DESCRIPTION_VISUAL_SIZE / 2,
                WIDGET_DESCRIPTION_VISUAL_SIZE / 2));

    return visible ?? true;
  }
}
