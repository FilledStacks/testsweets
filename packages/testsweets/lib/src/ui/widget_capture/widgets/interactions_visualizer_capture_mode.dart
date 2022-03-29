import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:testsweets/src/extensions/widget_position_extension.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:testsweets/src/ui/shared/popup_menu/interaction_circle_with_popup_menu.dart';
import 'package:testsweets/src/ui/shared/utils.dart';

class InteractionsVisualizerCaptureMode extends StatelessWidget {
  final Function editActionSelected;
  final ValueListenable<List<Interaction>> descriptionsForViewNotifier;
  const InteractionsVisualizerCaptureMode({
    Key? key,
    required this.descriptionsForViewNotifier,
    required this.editActionSelected,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ValueListenableBuilder<List<Interaction>>(
        valueListenable: descriptionsForViewNotifier,
        builder: (_, descriptionsForView, __) {
          return Stack(
            children: [
              ...descriptionsForView
                  .where(InteractionUtils.notView)
                  .where((interaction) =>
                      InteractionUtils.visibleOnScreen(interaction, size))
                  .map(
                    (description) => Positioned(
                      top:
                          description.position.responsiveYPosition(size.height),
                      left:
                          description.position.responsiveXPosition(size.width),
                      child: InteractionCircleWithPopupMenu(
                          key: Key(description.automationKey),
                          description: description,
                          editActionSelected: editActionSelected),
                    ),
                  )
            ],
          );
        });
  }
}
