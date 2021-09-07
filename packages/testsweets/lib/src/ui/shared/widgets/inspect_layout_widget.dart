import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:testsweets/src/constants/app_constants.dart';
import 'package:testsweets/src/models/enums/widget_type.dart';
import 'package:testsweets/src/ui/shared/shared_colors.dart';
import 'package:testsweets/src/ui/shared/shared_text_style.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_viewmodel.dart';

class InspectLayoutView extends ViewModelWidget<WidgetCaptureViewModel> {
  const InspectLayoutView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetCaptureViewModel model) {
    return Expanded(
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  border: Border.all(
                color: kcLightPink,
                width: 5,
              )),
            ),
          ),
          ...model.descriptionsForView.map(
            (description) => Positioned(
              top: description.position.y - (WidgetDescriptionVisualSize / 2),
              left: description.position.x - (WidgetDescriptionVisualSize / 2),
              child: IgnorePointer(
                ignoring: model.ignorePointer,
                child: GestureDetector(
                  onTap: () {
                    model.showWidgetDescription(description);
                  },
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: model.activeWidgetId != description.id &&
                            model.showDescription
                        ? 0.25
                        : 1,
                    child: Container(
                      key: Key(description.automationKey),
                      width: WidgetDescriptionVisualSize,
                      height: WidgetDescriptionVisualSize,
                      decoration: BoxDecoration(
                        color: description.widgetType == WidgetType.touchable
                            ? kcLightPink
                            : description.widgetType == WidgetType.input
                                ? kcMainButton
                                : Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: description.widgetType == WidgetType.input
                          ? Text('I')
                          : description.widgetType == WidgetType.touchable
                              ? Text('T',
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
      ),
    );
  }
}
