import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';

class CloseCircularButton extends StatelessWidget {
  const CloseCircularButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          Icons.circle,
          color: kcSecondaryWhite,
          size: 28.w,
        ),
        Icon(
          Icons.close,
          color: kcCard,
          size: 14.w,
        ),
      ],
    );
  }
}
