import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';
import 'package:testsweets/src/constants/app_constants.dart';
import 'package:testsweets/src/extensions/widget_description_extension.dart';
import 'package:testsweets/src/ui/driver_layout/hittable_stack.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';
import 'package:testsweets/src/ui/shared/busy_indecator.dart';

import 'driver_layout_viewmodel.dart';

class DriverLayoutView extends StatefulWidget {
  final Widget child;
  final String projectId;

  const DriverLayoutView({
    Key? key,
    required this.child,
    required this.projectId,
  }) : super(key: key);

  @override
  State<DriverLayoutView> createState() => _DriverLayoutViewState();
}

class _DriverLayoutViewState extends State<DriverLayoutView> {
  bool _showDebugInformation = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ViewModelBuilder<DriverLayoutViewModel>.reactive(
      onModelReady: (model) =>
          SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
        model.initialise();
      }),
      builder: (context, model, _) => HittableStack(
        children: [
          widget.child,
          Positioned(
              right: 15,
              top: 15,
              child: IconButton(
                icon: Icon(
                  Icons.remove_red_eye,
                  color: _showDebugInformation ? kcGreen : kcError,
                ),
                onPressed: () {
                  setState(() {
                    _showDebugInformation = !_showDebugInformation;
                  });
                },
              )),
          BusyIndicator(
            enable: model.isBusy,
          ),
          ...model.descriptionsForView.map(
            (description) => Positioned(
              top: description.responsiveYPosition(size.height),
              left: description.responsiveXPosition(size.width),
              child: Container(
                key: Key(description.automationKey),
                width: WIDGET_DESCRIPTION_VISUAL_SIZE,
                height: WIDGET_DESCRIPTION_VISUAL_SIZE,
                decoration: BoxDecoration(
                  color: Color(0x01000000),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: _showDebugInformation
                          ? Colors.red
                          : Colors.transparent,
                      width: 1),
                ),
              ),
            ),
          ),
          if (_showDebugInformation)
            ...model.descriptionsForView.map(
              (description) => Positioned(
                top: description.position!.y -
                    (WIDGET_DESCRIPTION_VISUAL_SIZE / 3),
                left: description.position!.x -
                    (WIDGET_DESCRIPTION_VISUAL_SIZE / 2),
                child: Container(
                  color: kcError,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  child: Text(
                    description.automationKey,
                  ),
                ),
              ),
            )
        ],
      ),
      viewModelBuilder: () =>
          DriverLayoutViewModel(projectId: widget.projectId),
    );
  }
}
