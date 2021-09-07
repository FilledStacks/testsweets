import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

TextStyle tsNormal() => TextStyle(
      fontFamily: "Roboto",
      fontWeight: FontWeight.w500,
      fontSize: 16.sp,
    );

Radius crButtonCornerRadius() => Radius.circular(8);
Radius crTextFieldCornerRadius() => Radius.circular(8.w);

const EdgeInsets buttonPadding =
    const EdgeInsets.symmetric(horizontal: 20, vertical: 12);
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
