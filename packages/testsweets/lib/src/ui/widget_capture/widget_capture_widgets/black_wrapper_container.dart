import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';

import '../widget_capture_viewmodel.dart';

class BlackWrapperContainer extends ViewModelWidget<WidgetCaptureViewModel> {
  final VoidCallback? switchPositionTap;
  final VoidCallback? closeWidgetOnTap;
  final Widget child;
  final Widget? footerChild;
  final double? spaceBetweenTopControllersAndChild;
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
      this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetCaptureViewModel model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w).copyWith(
          top: 32.h, bottom: MediaQuery.of(context).viewInsets.bottom + 24.h),
      width: ScreenUtil().screenWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          closeWidgetOnTap != null
              ? IconButton(
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  onPressed: closeWidgetOnTap,
                  icon: Container(
                    decoration: backButtonBoxDecoration,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.close,
                      color: kcPrimaryWhite,
                      size: 24,
                    ),
                  ),
                )
              : const SizedBox(),
          const SizedBox(
            height: 2,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (switchPositionTap != null)
                RotatedBox(
                  quarterTurns: 1,
                  child: TextButton.icon(
                    onPressed: switchPositionTap,
                    style: ButtonStyle(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      fixedSize: MaterialStateProperty.all(Size(140.h, 22)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(crTextFieldCornerRadius()))),
                      backgroundColor: MaterialStateProperty.all(
                          kcHighlightGrey.withOpacity(0.7)),
                    ),
                    icon: RotatedBox(
                      quarterTurns: 1,
                      child: Icon(
                        Icons.swap_vert,
                        size: 16.w,
                        color: kcPrimaryWhite,
                      ),
                    ),
                    label: AutoSizeText('Switch Position',
                        maxLines: 1,
                        style: tsNormal()
                            .copyWith(color: Colors.white, fontSize: 14.w)),
                  ),
                ),
              const SizedBox(
                width: 2,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MaterialButton(
                      padding: EdgeInsets.zero,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: model.isNestedView
                          ? model.toggleBetweenParentRouteAndChildRoute
                          : null,
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            vertical: 8.h, horizontal: 16.w),
                        decoration: viewNameBoxDecoration,
                        child: AutoSizeText.rich(
                          TextSpan(children: [
                            TextSpan(
                                text: model.leftViewName,
                                style: model.isChildRouteActivated
                                    ? tsDisableRoute()
                                    : tsActiveRoute()),
                            if (model.isNestedView)
                              TextSpan(
                                  text: ' / ',
                                  style: tsLarge()
                                      .copyWith(color: kcPrimaryFuchsia)),
                            TextSpan(
                                text: model.rightViewName,
                                style: model.isChildRouteActivated
                                    ? tsActiveRoute()
                                    : tsDisableRoute()),
                          ]),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 1),
                      padding: EdgeInsets.only(
                          left: 16.w, right: 16.w, top: 4.h, bottom: 20.h),
                      decoration: blackBoxDecoration.copyWith(
                          borderRadius: bottomCornerRaduisIsZero
                              ? BorderRadius.vertical(
                                  top: crButtonCornerRadius())
                              : BorderRadius.vertical(
                                  bottom: crButtonCornerRadius())),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          title != null
                              ? Expanded(child: Text(title!, style: boldStyle))
                              : const SizedBox(),
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
            ],
          ),
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
