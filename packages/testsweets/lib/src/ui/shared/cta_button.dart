import 'package:flutter/material.dart';

import 'shared_styles.dart';

class CtaButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color fillColor;
  final String title;
  const CtaButton(
      {Key? key,
      required this.onTap,
      required this.fillColor,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(crButtonCornerRadius())),
      onPressed: onTap,
      color: fillColor,
      padding: buttonPadding,
      child: Text(title, style: tsNormal().copyWith(color: Colors.white)),
    );
  }
}
