import 'package:auto_size_text/auto_size_text.dart';
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
      child: AutoSizeText(title,
          maxLines: 1, style: tsNormal().copyWith(color: Colors.white)),
    );
  }
}
