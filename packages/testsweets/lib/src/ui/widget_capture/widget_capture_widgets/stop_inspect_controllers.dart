import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';
import 'package:testsweets/src/ui/shared/cta_button.dart';

import '../widget_capture_viewmodel.dart';
import 'black_wrapper_container.dart';

class StopInspectControllers extends ViewModelWidget<WidgetCaptureViewModel> {
  const StopInspectControllers({Key? key}) : super(key: key);

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
        switchPositionTap: model.switchWidgetNameInputPosition,
        child: CtaButton(
          maxWidth: ScreenUtil().screenWidth,
          title: 'Stop inspection',
          fillColor: kcPrimaryFuchsia,
          onTap: model.toggleInspectLayout,
        ),
      ),
    );
    ;
  }
}
