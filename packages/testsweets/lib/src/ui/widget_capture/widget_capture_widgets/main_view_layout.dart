import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';
import 'package:testsweets/src/ui/shared/cta_button.dart';

import '../widget_capture_viewmodel.dart';

class MainViewLayout extends ViewModelWidget<WidgetCaptureViewModel> {
  const MainViewLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetCaptureViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CtaButton(
          title: 'Inspect View',
          fillColor: kcPrimaryFuchsia,
          onTap: model.toggleCaptureView,
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
    );
  }
}
