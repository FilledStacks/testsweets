import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';
import 'package:testsweets/src/ui/driver_layout/hittable_stack.dart';
import 'package:testsweets/src/ui/route_banner/route_banner_view.dart';
import 'package:testsweets/src/ui/shared/busy_indecator.dart';

import 'driver_layout_viewmodel.dart';
import 'widgets/interaction_visualizer_driver_mode.dart';

class DriverLayoutView extends StatelessWidget {
  final Widget child;
  final String projectId;
  final Function()? onRouteBannerLongPress;

  const DriverLayoutView({
    Key? key,
    required this.child,
    required this.projectId,
    required this.onRouteBannerLongPress,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DriverLayoutViewModel>.reactive(
      onViewModelReady: (model) {
        SchedulerBinding.instance
            .addPostFrameCallback((_) => model.initialise(context));
      },
      builder: (context, model, _) {
        return Scaffold(
          body: HittableStack(
            children: [
              NotificationListener(
                onNotification: model.onClientNotifiaction,
                child: child,
              ),
              RouteBannerView(
                isCaptured: model.currentViewCaptured,
                onLongPress: onRouteBannerLongPress,
              ),
              const InteractionsVisualizerDriverMode(),
              BusyIndicator(
                center: model.isBusy,
              )
            ],
          ),
        );
      },
      viewModelBuilder: () => DriverLayoutViewModel(projectId: projectId),
    );
  }
}
