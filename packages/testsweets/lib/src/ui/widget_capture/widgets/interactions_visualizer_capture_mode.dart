import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:testsweets/src/enums/capture_widget_enum.dart';
import 'package:testsweets/src/extensions/widget_position_extension.dart';
import 'package:testsweets/src/models/interaction.dart';
import 'package:testsweets/src/ui/shared/popup_menu/interaction_circle_with_popup_menu.dart';
import 'package:testsweets/src/ui/shared/utils.dart';

class InteractionsVisualizerCaptureMode extends StatelessWidget {
  final Function editActionSelected;
  final ValueListenable<List<Interaction>> descriptionsForViewNotifier;
  final CaptureWidgetState captureWidgetState;
  const InteractionsVisualizerCaptureMode({
    Key? key,
    required this.descriptionsForViewNotifier,
    required this.editActionSelected,
    required this.captureWidgetState,
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
                (interaction) {
                  return Positioned(
                    top: interaction.renderPosition
                        .responsiveYPosition(size.height),
                    left: interaction.renderPosition
                        .responsiveXPosition(size.width),
                    child: Opacity(
                      opacity:
                          captureWidgetState == CaptureWidgetState.createWidget
                              ? 0.4
                              : 1,
                      child: InteractionCircleWithPopupMenu(
                        key: Key(interaction.automationKey),
                        description: interaction,
                        editActionSelected: editActionSelected,
                        editMode: captureWidgetState ==
                                CaptureWidgetState.createWidget ||
                            captureWidgetState == CaptureWidgetState.editWidget,
                      ),
                    ),
                  );
                },
              )
            ],
          );
        });
  }
}
