import 'package:flutter/material.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';

class CloseCircularButton extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isWidgetNameInput;
  const CloseCircularButton(
      {Key? key, this.onTap, this.isWidgetNameInput = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isWidgetNameInput
        ? Icon(
            Icons.arrow_back,
            color: kcPrimaryWhite,
            size: 28,
          )
        : IconButton(
            icon: Icon(
              Icons.cancel,
              color: kcSweetsAppBarColor,
              size: 34,
            ),
            onPressed: onTap,
          );
  }
}
