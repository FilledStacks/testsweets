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
  final VoidCallback? changeAppTheme;
  final Widget child;
  final Widget? footerChild;
  final String? title;
  final bool bottomCornerRaduisIsZero;
  final bool hideViewBar;
  final bool disableToggleViews;
  const BlackWrapperContainer(
      {Key? key,
      this.changeAppTheme,
      this.switchPositionTap,
      this.closeWidgetOnTap,
      this.bottomCornerRaduisIsZero = false,
      this.disableToggleViews = false,
      this.hideViewBar = false,
      required this.child,
      this.footerChild,
      this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetCaptureViewModel model) {
    bool isDarkMode = model.isDarkMode;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w).copyWith(
          top: 32.h, bottom: MediaQuery.of(context).viewInsets.bottom + 24.h),
      width: MediaQuery.of(context).size.shortestSide,
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
                    decoration:
                        isDarkMode ? blackBoxDecoration : whiteBoxDecoration,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.close,
                      color: isDarkMode ? kcPrimaryWhite : kcCard,
                      size: 24,
                    ),
                  ),
                )
              : const SizedBox(),
          changeAppTheme != null
              ? IconButton(
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  icon: Container(
                    decoration: isDarkMode
                        ? buttonDarkBoxDecoration
                        : buttonLightBoxDecoration,
                    alignment: Alignment.center,
                    child: Icon(
                      model.isDarkMode
                          ? Icons.dark_mode_outlined
                          : Icons.light_mode,
                      color: model.isDarkMode ? kcPrimaryWhite : kcCard,
                      size: 34,
                    ),
                  ),
                  onPressed: changeAppTheme,
                )
              : const SizedBox(),
          const SizedBox(
            height: 2,
          ),
          AspectRatio(
            aspectRatio: title != null ? 1.4 : 2.8,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (switchPositionTap != null)
                  RotatedBox(
                    quarterTurns: 1,
                    child: Material(
                      type: MaterialType.card,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(crButtonCornerRadius())),
                      color: (isDarkMode ? kcHighlightGrey : kcPrimaryWhite)
                          .withOpacity(0.7),
                      child: InkWell(
                        onTap: switchPositionTap,
                        customBorder: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(crButtonCornerRadius())),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              RotatedBox(
                                quarterTurns: 1,
                                child: Icon(
                                  Icons.swap_vert,
                                  size: 16,
                                  color: isDarkMode
                                      ? kcPrimaryWhite
                                      : kcAutocompleteBackground,
                                ),
                              ),
                              Expanded(
                                child: AutoSizeText('Switch Position',
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: tsNormal().copyWith(
                                        color: isDarkMode
                                            ? kcPrimaryWhite
                                            : kcAutocompleteBackground,
                                        fontSize: 10.h)),
                              )
                            ],
                          ),
                        ),
                      ),
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
                      if (!hideViewBar)
                        AspectRatio(
                          aspectRatio: 10,
                          child: MaterialButton(
                            padding: EdgeInsets.zero,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onPressed: model.isNestedView && !disableToggleViews
                                ? model.toggleBetweenParentRouteAndChildRoute
                                : null,
                            child: Container(
                              alignment: Alignment.center,
                              decoration: isDarkMode
                                  ? viewNameBlackBoxDecoration
                                  : viewNameWhiteBoxDecoration,
                              child: AutoSizeText.rich(
                                TextSpan(children: [
                                  TextSpan(
                                      text: model.leftViewName,
                                      style: model.isChildRouteActivated
                                          ? tsDisableRoute()
                                          : tsActiveRoute(isDarkMode)),
                                  if (model.isNestedView)
                                    TextSpan(
                                        text: ' / ',
                                        style: tsLarge()
                                            .copyWith(color: kcPrimaryFuchsia)),
                                  TextSpan(
                                      text: model.rightViewName,
                                      style: model.isChildRouteActivated
                                          ? tsActiveRoute(isDarkMode)
                                          : tsDisableRoute()),
                                ]),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 1),
                          padding: EdgeInsets.only(
                            left: 16.w,
                            right: 16.w,
                          ),
                          decoration: (isDarkMode
                                  ? blackBoxDecoration
                                  : whiteBoxDecoration)
                              .copyWith(
                                  borderRadius:
                                      bottomCornerRaduisIsZero || hideViewBar
                                          ? BorderRadius.vertical(
                                              top: crButtonCornerRadius())
                                          : BorderRadius.vertical(
                                              bottom: crButtonCornerRadius())),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              title != null
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                        top: 12.h,
                                      ),
                                      child: Text(title!,
                                          style: boldStyle.copyWith(
                                              color: isDarkMode
                                                  ? kcPrimaryWhite
                                                  : kcPrimaryPurple)),
                                    )
                                  : const SizedBox(),
                              const SizedBox(),
                              child,
                            ],
                          ),
                        ),
                      ),
                      footerChild ?? const SizedBox()
                    ],
                  ),
                ),
              ],
            ),
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
