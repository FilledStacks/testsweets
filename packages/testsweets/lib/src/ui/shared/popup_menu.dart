import 'package:flutter/material.dart';

import 'package:testsweets/src/enums/popup_menu_action.dart';

import 'custom_popup_menu_item.dart';
import 'shared_styles.dart';

class PopupMenu extends StatelessWidget {
  final void Function(PopupMenuAction) onMenuAction;
  const PopupMenu({
    Key? key,
    required this.onMenuAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: kdPopupDecoration,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomPopupMenuItem(
            onTap: () => onMenuAction(PopupMenuAction.edit),
            title: 'Edit',
            svgPath: 'packages/testsweets/assets/svgs/edit.svg',
          ),
          const SizedBox(
            width: 8,
          ),
          CustomPopupMenuItem(
            onTap: () => onMenuAction(PopupMenuAction.remove),
            title: 'Remove',
            svgPath: 'packages/testsweets/assets/svgs/bin.svg',
          ),
          // const SizedBox(
          //   width: 8,
          // ),
          // CustomPopupMenuItem(
          //   onTap: () => onMenuAction(PopupMenuAction.attachToKey),
          //   title: 'Attach',
          //   svgPath: 'packages/testsweets/assets/svgs/attach.svg',
          // ),
        ],
      ),
    );
  }
}
