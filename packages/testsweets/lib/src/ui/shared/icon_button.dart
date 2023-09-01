import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'app_colors.dart';
import 'stadium_button.dart';

class SweetIconButton extends StatelessWidget {
  final String svgIcon;
  final GestureTapCallback? onTap;
  final double svgWidth;
  final bool isEnable;
  final Color? overlayColor;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? hoverColor;
  final EdgeInsets? padding;
  final String? tooltipMessage;

  const SweetIconButton(
      {required this.svgIcon,
      this.onTap,
      this.iconColor,
      this.backgroundColor,
      this.hoverColor,
      Key? key,
      required this.svgWidth,
      this.overlayColor,
      this.isEnable = true,
      this.padding,
      this.tooltipMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StadiumButton(
        tooltip: tooltipMessage,
        padding: padding ?? const EdgeInsets.all(8.0),
        hoverColor: hoverColor,
        visualDensity: VisualDensity.compact,
        iconSize: svgWidth,
        onPressed: isEnable ? onTap : null,
        backroundColor: kcTextField,
        icon: SvgPicture.asset(
          svgIcon,
          theme: SvgTheme(
              currentColor: !isEnable
                  ? kcSubtext
                  : iconColor ?? overlayColor ?? kcSubtext),
          width: svgWidth,
          fit: BoxFit.cover,
        ));
  }
}
