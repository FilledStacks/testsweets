import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'shared_styles.dart';

class CtaButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color fillColor;
  final String title;
  final double? maxWidth;
  const CtaButton(
      {Key? key,
      required this.onTap,
      required this.fillColor,
      required this.title,
      this.maxWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: maxWidth,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(crButtonCornerRadius())),
        onPressed: onTap,
        color: fillColor,
        padding: buttonPadding,
        child: AutoSizeText(title,
            maxLines: 1,
            style: tsMedium().copyWith(
              color: Colors.white,
            )),
      ),
    );
  }
}
