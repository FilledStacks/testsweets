import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';

import 'shared_styles.dart';

class CtaButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color fillColor;
  final String title;
  final double? maxWidth;
  final bool isDisabled;
  const CtaButton({
    Key? key,
    required this.onTap,
    required this.fillColor,
    required this.title,
    this.maxWidth,
    this.isDisabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: maxWidth,
      child: MaterialButton(
        visualDensity: VisualDensity.compact,
        disabledColor: kcTextField,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(crButtonCornerRadius())),
        onPressed: isDisabled ? null : onTap,
        color: fillColor,
        padding: buttonPadding,
        child: AutoSizeText(title,
            maxLines: 1,
            style: tsMedium().copyWith(
                color: kcPrimaryWhite.withOpacity(isDisabled ? 0.5 : 1))),
      ),
    );
  }
}
