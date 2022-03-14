import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:testsweets/src/constants/app_constants.dart';
import 'package:testsweets/src/enums/popup_menu_action.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/extensions/capture_widget_status_enum_extension.dart';

import 'package:testsweets/src/extensions/widget_description_extension.dart';
import 'package:testsweets/src/extensions/widget_position_extension.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';
import 'package:testsweets/src/ui/shared/popup_menu/popup_menu_content.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_viewmodel.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_widgets/connection_painter.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_widgets/widget_circle.dart';

import '../../shared/popup_menu/custom_popup_menu.dart';
import 'draggable_widget.dart';

class WidgetsVisualizer extends StatelessWidget {
  final Function editActionSelected;
  const WidgetsVisualizer({
    Key? key,
    required this.editActionSelected,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = context.watch<WidgetCaptureViewModel>();
    print('WidgetsVisualize');
    return Stack(
      fit: StackFit.expand,
      children: [
        if (model.captureWidgetStatusEnum.showWidgets)
          ValueListenableBuilder(
              valueListenable: model.descriptionsForViewNotifier,
              builder: (context, descriptionsForView, _) {
                print('valueListenable: ' + descriptionsForView.toString());
                return Stack(
                  children: [
                    ...model.descriptionsForView
                        // Show all the widgetTypes except views
                        .where(
                            (element) => element.widgetType != WidgetType.view)
                        .where((element) {
                      final result = element.externalities
                              ?.reduce((value, element) => value
                                  .expandToInclude(element) as SerializableRect)
                              .contains(element.position.offsetAfterScroll +
                                  Offset(WIDGET_DESCRIPTION_VISUAL_SIZE / 2,
                                      WIDGET_DESCRIPTION_VISUAL_SIZE / 2)) ??
                          true;
                      return result;
                    }).map(
                      (description) => Positioned(
                        top: description.position.offsetAfterScroll.dy,
                        left: description.position.offsetAfterScroll.dx,
                        child: PopupMenu(
                            description: description,
                            editActionSelected: editActionSelected),
                      ),
                    ),
                  ],
                );
              }),
        if (model.captureWidgetStatusEnum.showDraggableWidget)
          DraggableWidget(),
      ],
    );
  }
}

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
