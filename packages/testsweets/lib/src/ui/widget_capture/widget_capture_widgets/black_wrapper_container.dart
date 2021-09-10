import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_widgets/close_circular_button.dart';

class BlackWrapperContainer extends StatelessWidget {
  final bool bottomCornersAreFlat;
  final VoidCallback switchPositionTap;
  final VoidCallback closeWidget;
  final Widget child;
  const BlackWrapperContainer(
      {Key? key,
      this.bottomCornersAreFlat = false,
      required this.switchPositionTap,
      required this.closeWidget,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(left: 16.w, right: 16.w, top: 12.h, bottom: 20.h),
      decoration: blackBoxDecoration.copyWith(
          borderRadius: bottomCornersAreFlat
              ? BorderRadius.vertical(top: crButtonCornerRadius())
              : null),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: switchPositionTap,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(crTextFieldCornerRadius()))),
                  backgroundColor: MaterialStateProperty.all(kcPrimaryFuchsia),
                ),
                icon: Icon(
                  Icons.swap_vert,
                  size: 16.w,
                  color: kcPrimaryWhite,
                ),
                label: AutoSizeText('Switch Position',
                    maxLines: 1,
                    style: tsNormal()
                        .copyWith(color: Colors.white, fontSize: 14.w)),
              ),
              GestureDetector(onTap: closeWidget, child: CloseCircularButton())
            ],
          ),
          SizedBox(
            height: 24.w,
          ),
          child
        ],
      ),
    );
  }
}
