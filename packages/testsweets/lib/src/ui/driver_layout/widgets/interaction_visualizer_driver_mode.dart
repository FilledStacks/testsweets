import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:testsweets/src/extensions/widget_position_extension.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:testsweets/src/ui/driver_layout/driver_layout_viewmodel.dart';

import 'package:testsweets/src/ui/shared/interaction_circle.dart';
import 'package:testsweets/src/ui/shared/utils.dart';

class InteractionsVisualizerDriverMode
    extends ViewModelWidget<DriverLayoutViewModel> {
  const InteractionsVisualizerDriverMode({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, viewModel) {
    final size = MediaQuery.of(context).size;
    return ValueListenableBuilder<List<Interaction>>(
        valueListenable: viewModel.descriptionsForViewNotifier,
        builder: (_, descriptionsForView, __) {
          return Stack(
            children: [
              ...descriptionsForView
                  .where((interaction) =>
                      InteractionUtils.visibleOnScreen(interaction, size))
                  .map(
                    (interaction) => Positioned(
                      top:
                          interaction.position.responsiveYPosition(size.height),
                      left:
                          interaction.position.responsiveXPosition(size.width),
                      child: GestureDetector(
                        onLongPress: () =>
                            viewModel.interactionOnTap(interaction),
                        child: InteractionCircle(
                          key: Key(interaction.automationKey),
                          driverMode: true,
                          transparency: interaction.visibility ? 1 : 0.5,
                          widgetType: interaction.widgetType,
                        ),
                      ),
                    ),
                  )
            ],
          );
        });
  }
}
