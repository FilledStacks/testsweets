import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';

class ViewName extends StatelessWidget {
  final String viewName;

  const ViewName({Key? key, required this.viewName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(crTextFieldCornerRadius()))),
        backgroundColor: MaterialStateProperty.all(Color(0xFFF0276F)),
      ),
      child: AutoSizeText(
        viewName,
        maxLines: 1,
        style: tsNormal().copyWith(color: Colors.white, fontSize: 14.w),
      ),
    );
  }
}
