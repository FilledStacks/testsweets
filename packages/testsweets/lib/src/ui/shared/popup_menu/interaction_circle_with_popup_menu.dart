import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testsweets/src/ui/shared/popup_menu/popup_menu_content.dart';
import 'package:testsweets/testsweets.dart';

import '../../../enums/popup_menu_action.dart';
import '../../widget_capture/widget_capture_viewmodel.dart';
import '../interaction_circle.dart';
import 'custom_popup_menu.dart';

class InteractionCircleWithPopupMenu extends StatelessWidget {
  final Function editActionSelected;
  final Interaction description;
  final bool editMode;

  const InteractionCircleWithPopupMenu({
    Key? key,
    required this.editActionSelected,
    required this.description,
    required this.editMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('PopupMenu: ' + description.toString());

    final model = context.watch<WidgetCaptureViewModel>();
    final size = MediaQuery.of(context).size;
    return CustomPopupMenu(
      onMoveStart: () => model.startQuickPositionEdit(description),
      onTap: () => model.interactionOnTap(description),
      onLongPressUp: model.onLongPressUp,
      onLongPressMoveUpdate: (position) {
        final x = position.globalPosition.dx;
        final y = position.globalPosition.dy;
        model.updateDescriptionPosition(x, y, size.width, size.height);
      },
      menuBuilder: () => PopupMenuContent(
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
      child: description.id == model.inProgressInteraction?.id
          ? const SizedBox.shrink()
          : InteractionCircle(
              transparency: description.visibility ? 1 : 0.5,
              widgetType: description.widgetType,
            ),
    );
  }
}
