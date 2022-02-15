import 'package:flutter/material.dart';

import 'package:testsweets/src/enums/popup_menu_action.dart';

import '../shared_styles.dart';
import 'custom_popup_menu_item.dart';

class PopupMenuContent extends StatelessWidget {
  final bool showAttachOption;
  final bool showUnattachOption;
  final void Function(PopupMenuAction) onMenuAction;
  const PopupMenuContent({
    Key? key,
    required this.showAttachOption,
    required this.showUnattachOption,
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
          if (showAttachOption) ...[
            const SizedBox(
              width: 8,
            ),
            CustomPopupMenuItem(
              onTap: () => onMenuAction(PopupMenuAction.attachToKey),
              title: 'Attach',
              svgPath: 'packages/testsweets/assets/svgs/attach.svg',
            ),
          ],
          if (showUnattachOption) ...[
            const SizedBox(
              width: 8,
            ),
            CustomPopupMenuItem(
              onTap: () => onMenuAction(PopupMenuAction.deattachFromKey),
              title: 'Deattach',
              svgPath: 'packages/testsweets/assets/svgs/deattach.svg',
            ),
          ],
        ],
      ),
    );
  }
}
