import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';
import 'package:testsweets/src/ui/shared/cta_button.dart';

import '../widget_capture_viewmodel.dart';
import 'black_wrapper_container.dart';

class IntroControllers extends ViewModelWidget<WidgetCaptureViewModel> {
  const IntroControllers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetCaptureViewModel model) {
    return AnimatedAlign(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
      alignment: model.widgetNameInputPositionIsDown
          ? Alignment.bottomCenter
          : Alignment.topCenter,
      widthFactor: 1,
      child: BlackWrapperContainer(
        changeAppTheme: model.toggleTheme,
        switchPositionTap: model.switchWidgetNameInputPosition,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CtaButton(
              title: 'Inspect View',
              fillColor: kcPrimaryFuchsia,
              onTap: model.toggleInspectLayout,
            ),
            const SizedBox(
              height: 16,
            ),
            CtaButton(
              title: 'Start Capture',
              fillColor: kcPrimaryPurple,
              onTap: model.toggleCaptureView,
            ),
          ],
        ),
      ),
    );
  }
}
