import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:testsweets/src/enums/capture_widget_enum.dart';
import 'package:testsweets/src/extensions/capture_widget_status_enum_extension.dart';
import 'package:testsweets/src/extensions/widget_description_extension.dart';
import 'package:testsweets/src/models/application_models.dart';
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
    final size = MediaQuery.of(context).size;
    bool widgetIsInTopLeftCornerMeaningItsAView(WidgetDescription element) =>
        element.position.x != 0 && element.position.y != 0;

    bool eitherItsInUpdateModeOrItIsTheActiveWidget(
            WidgetDescription element) =>
        (model.captureWidgetStatusEnum !=
                CaptureWidgetStatusEnum.inspectModeUpdate ||
            element.id != model.widgetDescription!.id);

    bool filterUnWantedWidgets(WidgetDescription element) =>
        widgetIsInTopLeftCornerMeaningItsAView(element) &&
        eitherItsInUpdateModeOrItIsTheActiveWidget(element);

    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        if (model.captureWidgetStatusEnum ==
            CaptureWidgetStatusEnum.inspectModeUpdate)
          Positioned(
              top: model.widgetDescription!.responsiveHeight(size.height),
              left: model.widgetDescription!.responsiveWidth(size.width),
              child: GestureDetector(
                onPanUpdate: (panEvent) {
                  final x = panEvent.delta.dx;
                  final y = panEvent.delta.dy;
                  model.updateDescriptionPosition(
                      x, y, size.width, size.height);
                },
                child: WidgetCircle(
                    widgetType: model.widgetDescription!.widgetType),
              )),
        ...model.descriptionsForView.where(filterUnWantedWidgets).map(
              (description) => Positioned(
                top: description.responsiveHeight(size.height),
                left: description.responsiveWidth(size.width),
                child: IgnorePointer(
                  ignoring: model.captureWidgetStatusEnum.isSelectWidgetMode,
                  child: GestureDetector(
                    onTap: () => model.showWidgetDescription(description),
                    onPanUpdate: (panEvent) {
                      final x = panEvent.delta.dx;
                      final y = panEvent.delta.dy;
                      model.updateDescriptionPosition(
                          x, y, size.width, size.height);
                    },
                    child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: model.widgetDescription?.id !=
                                    description.id &&
                                model.captureWidgetStatusEnum.isSelectWidgetMode
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
                saveWidget: () =>
                    model.updateWidgetDescription(model.widgetDescription!),
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
