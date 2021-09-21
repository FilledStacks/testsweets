import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';
import 'package:testsweets/src/constants/app_constants.dart';
import 'package:testsweets/src/ui/driver_layout/hittable_stack.dart';
import 'package:testsweets/src/ui/shared/busy_indecator.dart';

import 'driver_layout_viewmodel.dart';

class DriverLayoutView extends StatelessWidget {
  final Widget child;
  final String projectId;

  const DriverLayoutView({
    Key? key,
    required this.child,
    required this.projectId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DriverLayoutViewModel>.reactive(
      onModelReady: (model) =>
          SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
        model.initialise();
      }),
      builder: (context, model, _) => HittableStack(
        children: [
          child,
          BusyIndicator(
            enable: model.isBusy,
          ),
          ...model.descriptionsForView.map(
            (description) => Positioned(
              top:
                  description.position.y - (WIDGET_DESCRIPTION_VISUAL_SIZE / 2),
              left:
                  description.position.x - (WIDGET_DESCRIPTION_VISUAL_SIZE / 2),
              child: Container(
                key: Key(description.automationKey),
                width: WIDGET_DESCRIPTION_VISUAL_SIZE,
                height: WIDGET_DESCRIPTION_VISUAL_SIZE,
                decoration: BoxDecoration(
                  color: Color(0x01000000),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          )
        ],
      ),
      viewModelBuilder: () => DriverLayoutViewModel(projectId: projectId),
    );
  }
}
