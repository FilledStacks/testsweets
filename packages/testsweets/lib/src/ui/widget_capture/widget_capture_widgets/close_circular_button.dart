import 'package:flutter/material.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';

class CloseCircularButton extends StatelessWidget {
  final VoidCallback? onTap;
  const CloseCircularButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.cancel,
        color: kcSweetsAppBarColor,
        size: 32,
      ),
      onPressed: onTap,
    );
  }
}
