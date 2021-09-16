import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:testsweets/src/constants/app_constants.dart';
import 'package:testsweets/src/enums/capture_widget_enum.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_viewmodel.dart';

import 'widget_circle.dart';

class InspectControllers extends ViewModelWidget<WidgetCaptureViewModel> {
  const InspectControllers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetCaptureViewModel model) {
    return Stack(
      children: [
        ...model.descriptionsForView.map(
          (description) => Positioned(
            top: description.position.y - (WIDGET_DESCRIPTION_VISUAL_SIZE / 2),
            left: description.position.x - (WIDGET_DESCRIPTION_VISUAL_SIZE / 2),
            child: IgnorePointer(
              ignoring: model.captureWidgetStatusEnum ==
                  CaptureWidgetStatusEnum.inspectModeDialogShow,
              child: GestureDetector(
                onTap: () => model.showWidgetDescription(description),
                child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: model.activeWidgetId != description.id &&
                            model.captureWidgetStatusEnum ==
                                CaptureWidgetStatusEnum.inspectModeDialogShow
                        ? 0.25
                        : 1,
                    child: WidgetCircle(
                      key: Key(description.automationKey),
                      widgetType: description.widgetType,
                    )),
              ),
            ),
          ),
        )
      ],
    );
  }
}
