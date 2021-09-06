import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';
import 'package:testsweets/src/ui/shared/cta_button.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_widgets/widgets_container.dart';

import '../widget_capture_viewmodel.dart';

class CaptureViewLayout extends ViewModelWidget<WidgetCaptureViewModel> {
  const CaptureViewLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetCaptureViewModel model) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AnimatedSwitcher(
            transitionBuilder: (child, animation) => SizeTransition(
              sizeFactor: animation,
              axis: Axis.vertical,
              axisAlignment: -1.0,
              child: child,
            ),
            duration: const Duration(milliseconds: 350),
            child: model.widgetTypeContainerSelectorEnable
                ? WidgetsContainer()
                : CtaButton(
                    title: 'Add Widget',
                    fillColor: kcPassedTestGreenColor,
                    onTap: model.openWidgetsContainer,
                  ),
          ),
          CtaButton(
            title: 'Exit Capture',
            fillColor: kcPrimaryPurple,
            onTap: model.toggleCaptureView,
          ),
        ],
      ),
    );
  }
}
