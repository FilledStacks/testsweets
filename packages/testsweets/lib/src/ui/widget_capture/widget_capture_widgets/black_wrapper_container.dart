import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_widgets/close_circular_button.dart';

class BlackWrapperContainer extends StatelessWidget {
  final VoidCallback? switchPositionTap;
  final VoidCallback? closeWidgetOnTap;
  final Widget child;
  final Widget? footerChild;
  final double? spaceBetweenTopControllersAndChild;
  final Widget viewName;
  final String? title;
  final bool bottomCornerRaduisIsZero;

  const BlackWrapperContainer(
      {Key? key,
      this.switchPositionTap,
      this.closeWidgetOnTap,
      this.bottomCornerRaduisIsZero = false,
      required this.child,
      this.footerChild,
      this.spaceBetweenTopControllersAndChild,
      this.viewName = const SizedBox.shrink(),
      this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenUtil().screenWidth,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
        ).copyWith(
            top: 32.h, bottom: MediaQuery.of(context).viewInsets.bottom + 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: 16.w, right: 16.w, top: 12.h, bottom: 20.h),
              decoration: blackBoxDecoration.copyWith(
                  borderRadius: bottomCornerRaduisIsZero
                      ? BorderRadius.vertical(top: crButtonCornerRadius())
                      : BorderRadius.all(crButtonCornerRadius())),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      switchPositionTap != null
                          ? Row(
                              children: [
                                TextButton.icon(
                                  onPressed: switchPositionTap,
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            OutlinedBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                crTextFieldCornerRadius()))),
                                    backgroundColor: MaterialStateProperty.all(
                                        kcSweetsAppBarColor),
                                  ),
                                  icon: Icon(
                                    Icons.swap_vert,
                                    size: 16.w,
                                    color: kcPrimaryWhite,
                                  ),
                                  label: AutoSizeText('Switch Position',
                                      maxLines: 1,
                                      style: tsNormal().copyWith(
                                          color: Colors.white, fontSize: 14.w)),
                                ),
                                SizedBox(width: 12.w),
                                viewName
                              ],
                            )
                          : title != null
                              ? Expanded(child: Text(title!, style: boldStyle))
                              : const SizedBox(),
                      closeWidgetOnTap != null
                          ? CloseCircularButton(onTap: closeWidgetOnTap!)
                          : const SizedBox()
                    ],
                  ),
                  SizedBox(
                    height: spaceBetweenTopControllersAndChild ?? 24.w,
                  ),
                  child,
                ],
              ),
            ),
            footerChild ?? const SizedBox()
          ],
        ),
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
