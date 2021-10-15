import 'package:flutter/material.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';

class DarkLightModeButton extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onTap;

  const DarkLightModeButton(
      {Key? key, required this.onTap, this.isDarkMode = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isDarkMode ? Icons.dark_mode : Icons.light_mode,
        color: kcSweetsAppBarColor,
        size: 34,
      ),
      onPressed: onTap,
    );
  }
}
