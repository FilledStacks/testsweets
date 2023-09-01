import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';

class CustomPopupMenuItem extends StatelessWidget {
  final VoidCallback onTap;
  final String svgPath;
  final String title;
  const CustomPopupMenuItem({
    Key? key,
    required this.onTap,
    required this.svgPath,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            svgPath,
            fit: BoxFit.fill,
            width: 20,
          ),
          const SizedBox(
            height: 4,
          ),
          SizedBox(
            width: 50,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: tsSmall(),
            ),
          )
        ],
      ),
    );
  }
}
