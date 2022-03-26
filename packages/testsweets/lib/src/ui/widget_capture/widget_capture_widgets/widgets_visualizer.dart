import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:testsweets/src/constants/app_constants.dart';

import 'package:testsweets/src/extensions/widget_position_extension.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:testsweets/src/ui/shared/popup_menu/popup_menu.dart';
import 'package:testsweets/src/ui/shared/utils.dart';

class WidgetsVisualizer extends StatelessWidget {
  final Function editActionSelected;
  final ValueListenable<List<Interaction>> descriptionsForViewNotifier;
  const WidgetsVisualizer({
    Key? key,
    required this.descriptionsForViewNotifier,
    required this.editActionSelected,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Interaction>>(
        valueListenable: descriptionsForViewNotifier,
        builder: (_, descriptionsForView, __) {
          return Stack(
            children: [
              ...descriptionsForView
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
        });
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
