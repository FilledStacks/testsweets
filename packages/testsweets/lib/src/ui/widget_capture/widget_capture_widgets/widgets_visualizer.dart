import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:testsweets/src/constants/app_constants.dart';
import 'package:testsweets/src/enums/popup_menu_action.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/extensions/capture_widget_status_enum_extension.dart';

import 'package:testsweets/src/extensions/widget_description_extension.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';
import 'package:testsweets/src/ui/shared/popup_menu/popup_menu_content.dart';
import 'package:testsweets/src/ui/shared/route_banner.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';
import 'package:testsweets/src/extensions/widget_type_flutter_extension.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_viewmodel.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_widgets/draggable_widget.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_widgets/widget_circle.dart';
import 'package:testsweets/testsweets.dart';

import '../../shared/popup_menu/custom_popup_menu.dart';

class WidgetsVisualizer extends StatelessWidget {
  final bool showWidgetName;
  final Function editActionSelected;
  const WidgetsVisualizer({
    Key? key,
    this.showWidgetName = false,
    required this.editActionSelected,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = context.watch<WidgetCaptureViewModel>();

    final size = MediaQuery.of(context).size;
    return Stack(
      fit: StackFit.expand,
      children: [
        ...model.descriptionsForView
            // Show all the widgetTypes except views
            .where((element) => element.widgetType != WidgetType.view)
            .map(
              (description) => Positioned(
                top: description.responsiveYPosition(size.height),
                left: description.responsiveXPosition(size.width),
                child: CustomPopupMenu(
                  onLongPressDown: () => model.popupMenuShown(description),
                  onLongPressUpWhilePopupHidden:
                      model.finishAdjustingWidgetPosition,
                  onLongPressMoveUpdate: (position) {
                    final x = position.globalPosition.dx;
                    final y = position.globalPosition.dy;
                    model.updateDescriptionPosition(
                        x, y, size.width, size.height);
                  },
                  barrierColor: kcBackground.withOpacity(0.3),
                  showArrow: false,
                  menuBuilder: () => PopupMenuContent(
                    onMenuAction: (popupMenuAction) async {
                      if (popupMenuAction == PopupMenuAction.edit) {
                        /// This will show the widgetform when fired
                        editActionSelected();
                      }
                      await model.popupMenuActionSelected(popupMenuAction);
                    },
                  ),
                  pressType: PressType.longPress,

                  /// When you long press and drag replace this widget with sizedbox cause
                  /// it is displayed with DraggableWidget while you move it
                  child: description.id == model.widgetDescription?.id
                      ? const SizedBox.shrink()
                      : WidgetCircle(
                          transparency: description.visibility ? 1 : 0.3,
                          key: Key(description.automationKey),
                          widgetType: description.widgetType,
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
                          color: description.widgetType.getColorOfWidgetType),
                    )),
              ),
            ),
          )
      ],
    );
  }
}
