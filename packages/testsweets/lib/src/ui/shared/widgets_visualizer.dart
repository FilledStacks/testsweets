import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:testsweets/src/constants/app_constants.dart';
import 'package:testsweets/src/enums/popup_menu_action.dart';

import 'package:testsweets/src/extensions/widget_description_extension.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';
import 'package:testsweets/src/ui/shared/popup_menu.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';
import 'package:testsweets/src/extensions/widget_type_flutter_extension.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_viewmodel.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_widgets/widget_circle.dart';
import 'package:testsweets/testsweets.dart';

class WidgetsVisualizer extends StatelessWidget {
  final bool driveMode;
  final bool showWidgetName;
  final Function onEdit;
  const WidgetsVisualizer({
    Key? key,
    this.showWidgetName = false,
    this.driveMode = false,
    required this.onEdit,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = context.watch<WidgetCaptureViewModel>();

    final size = MediaQuery.of(context).size;
    return Stack(
      fit: StackFit.expand,
      children: [
        ...model.descriptionsForView.map(
          (description) => Positioned(
            top: description.responsiveYPosition(size.height) ?? 0,
            left: description.responsiveXPosition(size.width) ?? 0,
            child: CustomPopupMenu(
              barrierColor: kcBackground.withOpacity(0.3),
              showArrow: false,
              menuBuilder: () => PopupMenu(
                onMenuAction: (popupMenuAction) {
                  model.executeAction(
                      description: description,
                      popupMenuAction: popupMenuAction);

                  if (popupMenuAction == PopupMenuAction.edit) {
                    onEdit();
                  }
                },
              ),
              pressType: PressType.longPress,
              child: WidgetCircle(
                transparency: driveMode
                    ? 0
                    : description.visibility
                        ? 1
                        : 0.3,
                key: Key(description.automationKey),
                widgetType: description.widgetType!,
              ),
            ),
          ),
        ),
        if (showWidgetName)
          ...model.descriptionsForView.map(
            (description) => Positioned(
              top: description.responsiveYPosition(size.height),
              left: description.responsiveXPosition(size.width),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: WIDGET_DESCRIPTION_VISUAL_SIZE,
                ),
                child: SizedBox(
                    width: WIDGET_DESCRIPTION_VISUAL_SIZE,
                    child: Text(
                      description.name,
                      textAlign: TextAlign.center,
                      style: tsSmall().copyWith(
                          color: description.widgetType!.getColorOfWidgetType),
                    )),
              ),
            ),
          )
      ],
    );
  }
}
