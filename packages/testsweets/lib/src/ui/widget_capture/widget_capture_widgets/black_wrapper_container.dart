import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_widgets/close_circular_button.dart';

class BlackWrapperContainer extends StatelessWidget {
  final bool bottomCornersAreFlat;
  final VoidCallback switchPositionTap;
  final VoidCallback? closeWidget;
  final Widget child;
  final Widget? footerChild;
  const BlackWrapperContainer(
      {Key? key,
      this.bottomCornersAreFlat = false,
      required this.switchPositionTap,
      this.closeWidget,
      required this.child,
      this.footerChild})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
      ).copyWith(
          top: 32.h, bottom: MediaQuery.of(context).viewInsets.bottom + 24.h),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
                left: 16.w, right: 16.w, top: 12.h, bottom: 20.h),
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
                                borderRadius: BorderRadius.all(
                                    crTextFieldCornerRadius()))),
                        backgroundColor:
                            MaterialStateProperty.all(kcSweetsAppBarColor),
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
                    closeWidget != null
                        ? CloseCircularButton(onTap: closeWidget!)
                        : const SizedBox()
                  ],
                ),
                SizedBox(
                  height: 24.w,
                ),
                child,
              ],
            ),
          ),
          footerChild ?? const SizedBox()
        ],
      ),
    );
  }
}

class BlackContainerAlignAnimation extends StatelessWidget {
  final Widget child;
  final bool isDown;
  const BlackContainerAlignAnimation(
      {Key? key, required this.child, this.isDown = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
      alignment: isDown ? Alignment.bottomCenter : Alignment.topCenter,
      widthFactor: 1,
      child: child,
    );
  }
}
