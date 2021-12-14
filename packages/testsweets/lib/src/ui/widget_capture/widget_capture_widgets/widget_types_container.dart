import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/extensions/widget_type_flutter_extension.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_viewmodel.dart';

class WidgetsTypesContainer extends ViewModelWidget<WidgetCaptureViewModel> {
  const WidgetsTypesContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetCaptureViewModel model) {
    final orientation = MediaQuery.of(context).orientation;
    return orientation == Orientation.portrait
        ? _PortraitWidgetTypeContainer(
            model: model,
          )
        : _LandscapeWidgetTypeContainer(
            model: model,
          );
  }
}

class _PortraitWidgetTypeContainer extends StatelessWidget {
  final WidgetCaptureViewModel model;
  const _PortraitWidgetTypeContainer({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: model.isDarkMode ? blackBoxDecoration : whiteBoxDecoration,
      width: 136.w,
      child: Column(
        children: [
          SizedBox(
            height: 24.w,
          ),
          _WidgetTypeButton(
            onTap: () => model.addNewWidget(
                WidgetType.touchable,
                WidgetPosition(
                    capturedDeviceHeight: size.height,
                    capturedDeviceWidth: size.width,
                    x: size.width / 2,
                    y: size.height / 2)),
            title: 'Touchable',
            color: WidgetType.touchable.getColorOfWidgetType,
          ),
          SizedBox(
            height: 16.w,
          ),
          _WidgetTypeButton(
            onTap: () => model.addNewWidget(
                WidgetType.input,
                WidgetPosition(
                    capturedDeviceHeight: size.height,
                    capturedDeviceWidth: size.width,
                    x: size.width / 2,
                    y: size.height / 2)),
            title: 'Input',
            color: WidgetType.input.getColorOfWidgetType,
          ),
          SizedBox(
            height: 16.w,
          ),
          _WidgetTypeButton(
            onTap: () => model.addNewWidget(
                WidgetType.scrollable,
                WidgetPosition(
                    capturedDeviceHeight: size.height,
                    capturedDeviceWidth: size.width,
                    x: size.width / 2,
                    y: size.height / 2)),
            title: 'Scrollable',
            color: WidgetType.scrollable.getColorOfWidgetType,
          ),
          SizedBox(
            height: 24.w,
          ),
          Divider(
            color: model.isDarkMode ? kcSweetsAppBarColor : kcSubtext,
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
                color: model.isDarkMode ? kcSweetsAppBarColor : kcSubtext,
                size: 34,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _LandscapeWidgetTypeContainer extends StatelessWidget {
  final WidgetCaptureViewModel model;
  const _LandscapeWidgetTypeContainer({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: model.isDarkMode ? blackBoxDecoration : whiteBoxDecoration,
      width: 42.w,
      child: Column(
        children: [
          SizedBox(
            height: 24.h,
          ),
          _WidgetTypeButton(
            landscape: true,
            onTap: () => model.addNewWidget(
                WidgetType.touchable,
                WidgetPosition(
                    capturedDeviceHeight: size.height,
                    capturedDeviceWidth: size.width,
                    x: size.width / 2,
                    y: size.height / 2)),
            title: 'Touchable',
            color: WidgetType.touchable.getColorOfWidgetType,
          ),
          SizedBox(
            height: 16.h,
          ),
          _WidgetTypeButton(
            landscape: true,
            onTap: () => model.addNewWidget(
                WidgetType.input,
                WidgetPosition(
                    capturedDeviceHeight: size.height,
                    capturedDeviceWidth: size.width,
                    x: size.width / 2,
                    y: size.height / 2)),
            title: 'Input',
            color: WidgetType.input.getColorOfWidgetType,
          ),
          SizedBox(
            height: 16.h,
          ),
          _WidgetTypeButton(
            landscape: true,
            onTap: () => model.addNewWidget(
                WidgetType.scrollable,
                WidgetPosition(
                    capturedDeviceHeight: size.height,
                    capturedDeviceWidth: size.width,
                    x: size.width / 2,
                    y: size.height / 2)),
            title: 'Scrollable',
            color: WidgetType.scrollable.getColorOfWidgetType,
          ),
          SizedBox(
            height: 24.h,
          ),
          Divider(
            color: model.isDarkMode ? kcSweetsAppBarColor : kcSubtext,
            thickness: 5.h,
            height: 0,
          ),
          MaterialButton(
            minWidth: 45.w,
            onPressed: model.toggleWidgetsContainer,
            child: SizedBox(
              height: 45.h,
              child: Icon(
                Icons.cancel,
                color: model.isDarkMode ? kcSweetsAppBarColor : kcSubtext,
                size: 24,
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
  final bool landscape;
  const _WidgetTypeButton({
    Key? key,
    required this.onTap,
    required this.title,
    required this.color,
    this.landscape = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: landscape ? 16.h : 16.w),
      child: AspectRatio(
        aspectRatio: 1,
        child: MaterialButton(
          onPressed: onTap,
          color: color,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(crButtonCornerRadius())),
          child: AutoSizeText(title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: tsNormal().copyWith(color: Colors.white, fontSize: 12.h)),
        ),
      ),
    );
  }
}
