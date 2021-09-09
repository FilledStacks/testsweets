import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:testsweets/src/models/enums/widget_type.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';
import 'package:testsweets/src/ui/shared/cta_button.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_viewmodel.dart';

import 'close_circular_button.dart';

class WidgetsContainer extends ViewModelWidget<WidgetCaptureViewModel> {
  const WidgetsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetCaptureViewModel model) {
    return Container(
      decoration: blackBoxDecoration,
      width: 136.w,
      child: Column(
        children: [
          SizedBox(
            height: 24.w,
          ),
          _WidgetTypeButton(
            onTap: () => model.addNewWidget(WidgetType.touchable,
                widgetPosition: WidgetPosition(
                    x: ScreenUtil().screenWidth / 2,
                    y: ScreenUtil().screenHeight / 2)),
            title: 'Touchable',
          ),
          SizedBox(
            height: 16.w,
          ),
          _WidgetTypeButton(
            onTap: () => model.addNewWidget(WidgetType.input,
                widgetPosition: WidgetPosition(
                    x: ScreenUtil().screenWidth / 2,
                    y: ScreenUtil().screenHeight / 2)),
            title: 'Input',
          ),
          SizedBox(
            height: 24.w,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: CtaButton(
              isDisabled: model.viewAlreadyCaptured,
              title: 'Capture View',
              fillColor: kcSecondaryGreen,
              onTap: () => model.addNewWidget(WidgetType.view),
            ),
          ),
          SizedBox(
            height: 24.w,
          ),
          Divider(
            color: kcBackground,
            thickness: 5.w,
            height: 0,
          ),
          MaterialButton(
            minWidth: 136.w,
            onPressed: model.toggleWidgetsContainer,
            child: SizedBox(height: 100.w, child: CloseCircularButton()),
          )
        ],
      ),
    );
  }
}

class _WidgetTypeButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  const _WidgetTypeButton({
    Key? key,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      minWidth: 97.w,
      height: 97.w,
      color: kcPrimaryPurple,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(crButtonCornerRadius())),
      child: AutoSizeText(title,
          maxLines: 1,
          style: tsNormal().copyWith(color: Colors.white, fontSize: 12.w)),
    );
  }
}
