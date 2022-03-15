import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testsweets/src/extensions/capture_widget_status_enum_extension.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:testsweets/src/ui/shared/popup_menu/popup_menu_content.dart';

import '../../../enums/popup_menu_action.dart';
import '../../widget_capture/widget_capture_viewmodel.dart';
import '../../widget_capture/widget_capture_widgets/widget_circle.dart';
import '../app_colors.dart';
import 'custom_popup_menu.dart';

class PopupMenu extends StatelessWidget {
  const PopupMenu(
      {Key? key, required this.editActionSelected, required this.description})
      : super(key: key);

  final Function editActionSelected;
  final Interaction description;
  @override
  Widget build(BuildContext context) {
    print('PopupMenu: ' + description.toString());

    final model = context.watch<WidgetCaptureViewModel>();
    final size = MediaQuery.of(context).size;
    return CustomPopupMenu(
      disable: model.captureWidgetStatusEnum.attachMode,
      onMoveStart: () => model.startQuickPositionEdit(description),
      onTap: () => model.onTapWidget(description),
      onLongPressUp: model.onLongPressUp,
      onLongPressMoveUpdate: (position) {
        final x = position.globalPosition.dx;
        final y = position.globalPosition.dy;
        model.updateDescriptionPosition(x, y, size.width, size.height);
      },
      barrierColor: kcBackground.withOpacity(0.3),
      showArrow: false,
      menuBuilder: () => PopupMenuContent(
        showUnattachOption: description.targetIds.isNotEmpty,
        showAttachOption: (description.targetIds.length +
                2) < // 2 is for one widget and its view
            model.descriptionsForView.length,
        onMenuAction: (popupMenuAction) async {
          await model.popupMenuActionSelected(description, popupMenuAction);
          if (popupMenuAction == PopupMenuAction.edit) {
            /// When called will show the widgetform
            editActionSelected();
          }
        },
      ),
      pressType: PressType.longPress,

      /// When you long press and drag replace this widget with sizedbox
      /// to avoid dublicates, cause it's using DraggableWidget while you move it
      child: description.id == model.widgetDescription?.id
          ? const SizedBox.shrink()
          : WidgetCircle(
              transparency: description.visibility ? 1 : 0.5,
              key: Key(description.automationKey),
              widgetType: description.widgetType,
            ),
    );
  }
}
