import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:testsweets/src/constants/app_constants.dart';
import 'package:testsweets/src/enums/capture_widget_enum.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_viewmodel.dart';

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
                  child: Container(
                    alignment: Alignment.center,
                    key: Key(description.automationKey),
                    width: WIDGET_DESCRIPTION_VISUAL_SIZE,
                    height: WIDGET_DESCRIPTION_VISUAL_SIZE,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: description.widgetType == WidgetType.touchable
                          ? kcError
                          : description.widgetType == WidgetType.input
                              ? kcPrimaryPurple
                              : description.widgetType == WidgetType.scrollable
                                  ? kcSecondaryGreen
                                  : Colors.red,
                    ),
                    child: description.widgetType == WidgetType.input
                        ? Text('I',
                            textAlign: TextAlign.center,
                            style: positionWidgetStyle)
                        : description.widgetType == WidgetType.touchable
                            ? Text('T',
                                textAlign: TextAlign.center,
                                style: positionWidgetStyle)
                            : description.widgetType == WidgetType.scrollable
                                ? Text('S',
                                    textAlign: TextAlign.center,
                                    style: positionWidgetStyle)
                                : null,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
