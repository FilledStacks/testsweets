import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:testsweets/src/enums/capture_widget_enum.dart';
import 'package:testsweets/src/extensions/widget_description_extension.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_widgets/widget_circle.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_widgets/widget_name_input.dart';

import '../widget_capture_viewmodel.dart';

class CaptureLayout extends ViewModelWidget<WidgetCaptureViewModel> {
  const CaptureLayout({
    Key? key,
    required this.widgetNameController,
    required this.widgetNameFocusNode,
  }) : super(key: key);

  final TextEditingController widgetNameController;
  final FocusNode widgetNameFocusNode;

  @override
  Widget build(BuildContext context, WidgetCaptureViewModel model) {
    final size = MediaQuery.of(context).size;
    return Stack(
      fit: StackFit.expand,
      children: [
        if (model.captureWidgetStatusEnum ==
            CaptureWidgetStatusEnum.captureModeWidgetNameInputShow)
          Positioned(
              top: model.widgetDescription!.responsiveYPosition(size.height),
              left: model.widgetDescription!.responsiveXPosition(size.width),
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
        FadeInWidget(
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutCubic,
              alignment: model.widgetNameInputPositionIsDown
                  ? Alignment.bottomCenter
                  : Alignment.topCenter,
              widthFactor: 1,
              child: WidgetNameInput(
                initialValue: null,
                isEditMode: false,
                errorMessage: model.nameInputErrorMessage,
                closeWidget: () {
                  widgetNameController.clear();
                  model.closeWidgetNameInput();
                },
                deleteWidget: model.deleteWidgetDescription,
                saveWidget: model.saveWidgetDescription,
                switchPositionTap: model.switchWidgetNameInputPosition,
                focusNode: widgetNameFocusNode,
                textEditingController: widgetNameController,
              ),
            ),
            isVisible: !model.isBusy &&
                model.captureWidgetStatusEnum ==
                    CaptureWidgetStatusEnum.captureModeWidgetNameInputShow),
      ],
    );
  }
}
