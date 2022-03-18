import 'package:flutter/material.dart';
import 'package:testsweets/src/constants/app_constants.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/testsweets.dart';

extension WidgetDescriptionUtils on Interaction {
  Offset responsiveOffset(Size screenSize) {
    final responsiveWidth = responsiveXPosition(screenSize.width);
    final responsiveHeight = responsiveYPosition(screenSize.height);
    return Offset(responsiveWidth + WIDGET_DESCRIPTION_VISUAL_SIZE / 2,
        responsiveHeight + WIDGET_DESCRIPTION_VISUAL_SIZE / 2);
  }

  double responsiveXPosition(double currentScreenWidth) {
    final result = _calculateWidthRatio(currentScreenWidth) * this.position.x -
        (WIDGET_DESCRIPTION_VISUAL_SIZE / 2);
    return result;
  }

  double responsiveYPosition(double currentScreenHeight) {
    final result =
        _calculateHeightRatio(currentScreenHeight) * this.position.y -
            (WIDGET_DESCRIPTION_VISUAL_SIZE / 2);
    return result;
  }

  double _calculateHeightRatio(double currentScreenHeight) {
    /// If the [capturedDeviceHeight] is null or 0 return 1
    /// which will leave the original hight unchanged
    if (this.position.capturedDeviceHeight == null ||
        this.position.capturedDeviceHeight == 0) {
      return 1;
    } else {
      return currentScreenHeight / this.position.capturedDeviceHeight!;
    }
  }

  double _calculateWidthRatio(double currentScreenWidth) {
    /// If the [capturedDeviceHeight] is null or 0 return 1
    /// which will leave the original width unchanged
    if (this.position.capturedDeviceWidth == null ||
        this.position.capturedDeviceWidth == 0) {
      return 1;
    } else {
      return currentScreenWidth / this.position.capturedDeviceWidth!;
    }
  }

  bool get notView => this.widgetType != WidgetType.view;
}
