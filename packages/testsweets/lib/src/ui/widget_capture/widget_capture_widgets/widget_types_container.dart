import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/extensions/widget_type_extension.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_viewmodel.dart';

class WidgetsTypesContainer extends ViewModelWidget<WidgetCaptureViewModel> {
  const WidgetsTypesContainer({Key? key}) : super(key: key);

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
            color: WidgetType.touchable.getColorOfWidgetType,
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
            color: WidgetType.input.getColorOfWidgetType,
          ),
          SizedBox(
            height: 16.w,
          ),
          _WidgetTypeButton(
            onTap: () => model.addNewWidget(WidgetType.scrollable,
                widgetPosition: WidgetPosition(
                    x: ScreenUtil().screenWidth / 2,
                    y: ScreenUtil().screenHeight / 2)),
            title: 'Scrollable',
            color: WidgetType.scrollable.getColorOfWidgetType,
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
            child: SizedBox(
              height: 100.w,
              child: Icon(
                Icons.cancel,
                color: kcSweetsAppBarColor,
                size: 34,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _WidgetTypeButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final Color color;
  const _WidgetTypeButton({
    Key? key,
    required this.onTap,
    required this.title,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      minWidth: 97.w,
      height: 97.w,
      color: color,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(crButtonCornerRadius())),
      child: AutoSizeText(title,
          maxLines: 1,
          style: tsNormal().copyWith(color: Colors.white, fontSize: 12.w)),
    );
  }
}
