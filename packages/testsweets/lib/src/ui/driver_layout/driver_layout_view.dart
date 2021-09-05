import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';
import 'package:testsweets/src/constants/app_constants.dart';
import 'package:testsweets/src/ui/driver_layout/hittable_stack.dart';

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
        model.registerForRouteChanges();
      }),
      builder: (context, model, _) => HittableStack(
        children: [
          child,
          ...model.descriptionsForView.map(
            (description) => Positioned(
              top: description.position.x,
              left: description.position.y,
              child: Container(
                key: Key(description.name),
                width: WidgetDiscriptionVisualSize,
                height: WidgetDiscriptionVisualSize,
                decoration: BoxDecoration(
                  color: Color(0x01000000),
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          )
        ],
      ),
      viewModelBuilder: () => DriverLayoutViewModel(),
    );
  }
}
