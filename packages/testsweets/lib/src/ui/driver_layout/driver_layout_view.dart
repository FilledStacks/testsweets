import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';

import 'package:testsweets/src/ui/driver_layout/hittable_stack.dart';
import 'package:testsweets/src/ui/shared/busy_indecator.dart';
import 'package:testsweets/src/ui/shared/route_banner.dart';

import 'driver_layout_viewmodel.dart';
import 'widgets/interaction_visualizer_driver_mode.dart';

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
      onModelReady: (model) {
        SchedulerBinding.instance
            ?.addPostFrameCallback((_) => model.initialise());
      },
      builder: (context, model, _) {
        return Scaffold(
          body: HittableStack(
            children: [
              NotificationListener(
                onNotification: model.onClientNotifiaction,
                child: child,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: RouteBanner(
                  isCaptured: model.currentViewCaptured,
                  routeName: model.currentViewName,
                ),
              ),
              const InteractionsVisualizerDriverMode(),
              BusyIndicator(
                enable: model.isBusy,
              )
            ],
          ),
        );
      },
      viewModelBuilder: () => DriverLayoutViewModel(projectId: projectId),
    );
  }
}
