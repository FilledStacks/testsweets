import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

TextStyle tsSmall() => TextStyle(
      fontFamily: "Roboto",
      fontWeight: FontWeight.w400,
      fontSize: 12.sp,
    );
TextStyle tsNormalBold() => TextStyle(
      fontFamily: "Roboto",
      fontWeight: FontWeight.w600,
      fontSize: 14.sp,
    );
TextStyle tsNormal() => TextStyle(
      fontFamily: "Roboto",
      fontWeight: FontWeight.w400,
      fontSize: 16.sp,
    );
TextStyle tsMedium() => TextStyle(
      fontFamily: "Roboto",
      fontWeight: FontWeight.w500,
      fontSize: 16.sp,
    );
TextStyle tsLarge() => TextStyle(
      fontFamily: "Roboto",
      fontWeight: FontWeight.w600,
      fontSize: 18.sp,
    );

TextStyle tsExtraLarge() => TextStyle(
      fontFamily: "Roboto",
      fontWeight: FontWeight.w700,
      fontSize: 40.sp,
    );
TextStyle tsActiveRoute() => TextStyle(
      fontFamily: "Roboto",
      color: kcPrimaryWhite,
      fontWeight: FontWeight.w600,
      fontSize: 18.sp,
    );
TextStyle tsDisableRoute() => TextStyle(
      fontFamily: "Roboto",
      fontWeight: FontWeight.w600,
      color: kcSubtext,
      fontSize: 16.sp,
    );
const boldStyle =
    TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white);

const lightStyle = TextStyle(fontSize: 19, color: Colors.white);

const positionWidgetStyle = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    height: 1.2);

Radius crButtonCornerRadius() => Radius.circular(8);
Radius crTextFieldCornerRadius() => Radius.circular(8.w);

const EdgeInsets buttonPadding =
    const EdgeInsets.symmetric(horizontal: 20, vertical: 22);
final blackBoxDecoration = BoxDecoration(
  color: kcCard,
  boxShadow: [
    BoxShadow(
        blurRadius: 8,
        offset: Offset(3, 4),
        color: Colors.black.withOpacity(0.25))
  ],
  borderRadius: BorderRadius.all(crButtonCornerRadius()),
);
final redBoxDecoration = BoxDecoration(
  color: kcError,
  boxShadow: [
    BoxShadow(
        blurRadius: 8, offset: Offset(3, 4), color: kcError.withOpacity(0.25))
  ],
  borderRadius: BorderRadius.vertical(bottom: crButtonCornerRadius()),
);
final viewNameBoxDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [kcCard.withOpacity(0.7), kcCard],
  ),
  borderRadius: BorderRadius.vertical(top: crButtonCornerRadius()),
);
final backButtonBoxDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [kcCard.withOpacity(0.7), kcCard],
  ),
  borderRadius: BorderRadius.all(crButtonCornerRadius()),
);

class FadeInWidget extends StatelessWidget {
  final Widget child;
  final bool isVisible;
  const FadeInWidget({
    Key? key,
    required this.child,
    required this.isVisible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: isVisible ? child : const SizedBox(),
    );
  }
}
