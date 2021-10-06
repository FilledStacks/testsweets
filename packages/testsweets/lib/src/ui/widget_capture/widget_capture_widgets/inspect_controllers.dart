import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:testsweets/src/constants/app_constants.dart';
import 'package:testsweets/src/enums/capture_widget_enum.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_viewmodel.dart';

import 'widget_circle.dart';
import 'widget_name_input.dart';

class InspectControllers extends ViewModelWidget<WidgetCaptureViewModel> {
  const InspectControllers({
    Key? key,
    required this.widgetNameController,
    required this.widgetNameFocusNode,
  }) : super(key: key);

  final TextEditingController widgetNameController;
  final FocusNode widgetNameFocusNode;
  @override
  Widget build(BuildContext context, WidgetCaptureViewModel model) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        ...model.descriptionsForView
            .where(
                (element) => element.position.x != 0 && element.position.y != 0)
            .map(
              (description) => Positioned(
                top: description.position.y -
                    (WIDGET_DESCRIPTION_VISUAL_SIZE / 2),
                left: description.position.x -
                    (WIDGET_DESCRIPTION_VISUAL_SIZE / 2),
                child: IgnorePointer(
                  ignoring: model.captureWidgetStatusEnum ==
                      CaptureWidgetStatusEnum.inspectModeDialogShow,
                  child: GestureDetector(
                    onTap: () => model.showWidgetDescription(description),
                    child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: model.activeWidgetId != description.id &&
                                model.captureWidgetStatusEnum ==
                                    CaptureWidgetStatusEnum
                                        .inspectModeDialogShow
                            ? 0.25
                            : 1,
                        child: WidgetCircle(
                          key: Key(description.automationKey),
                          widgetType: description.widgetType,
                        )),
                  ),
                ),
              ),
            ),
        FadeInWidget(
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutCubic,
              alignment: model.widgetNameInputPositionIsDown
                  ? Alignment.bottomCenter
                  : Alignment.topCenter,
              widthFactor: 1,
              child: WidgetNameInput(
                isEditMode: true,
                errorMessage: model.nameInputErrorMessage,
                closeWidget: () {
                  widgetNameController.clear();
                  model.closeWidgetNameInput();
                },
                deleteWidget: model.deleteWidgetDescription,
                saveWidget: model.updateWidgetDescription,
                switchPositionTap: model.switchWidgetNameInputPosition,
                focusNode: widgetNameFocusNode,
                textEditingController: widgetNameController,
              ),
            ),
            isVisible: !model.isBusy &&
                model.captureWidgetStatusEnum ==
                    CaptureWidgetStatusEnum.inspectModeUpdate),
      ],
    );
  }
}
