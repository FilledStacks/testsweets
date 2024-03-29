import 'package:flutter/material.dart';
import 'package:testsweets/src/constants/app_constants.dart';
import 'package:testsweets/testsweets.dart';

extension WidgetPositionExtension on WidgetPosition {
  Offset get toOffset => Offset(x, y);

  WidgetPosition withScrollable(ScrollableDescription scrollable) {
    final scrollingPixels = scrollable.scrollExtentByPixels;

    if (scrollable.axis == Axis.vertical) {
      return this.copyWith(x: x, y: y + scrollingPixels);
    } else {
      return this.copyWith(x: x + scrollingPixels, y: y);
    }
  }

  Offset responsiveOffset(Size screenSize) {
    final responsiveWidth = responsiveXPosition(screenSize.width);
    final responsiveHeight = responsiveYPosition(screenSize.height);
    return Offset(responsiveWidth, responsiveHeight);
  }

  double responsiveXPosition(double currentScreenWidth) {
    final result = _calculateWidthRatio(currentScreenWidth) * this.x +

        /// The yDeviation is set during the [applyScroll] call
        (this.xDeviation ?? 0) -
        (WIDGET_DESCRIPTION_VISUAL_SIZE / 2);
    return result;
  }

  double responsiveYPosition(double currentScreenHeight) {
    final result = _calculateHeightRatio(currentScreenHeight) * this.y +

        /// The yDeviation is set during the [applyScroll] call
        (this.yDeviation ?? 0) -
        (WIDGET_DESCRIPTION_VISUAL_SIZE / 2);
    return result;
  }

  double _calculateHeightRatio(double currentScreenHeight) {
    /// If the [capturedDeviceHeight] is null or 0 return 1
    /// which will leave the original hight unchanged
    if (this.capturedDeviceHeight == 0) {
      return 1;
    } else {
      return currentScreenHeight / this.capturedDeviceHeight;
    }
  }

  double _calculateWidthRatio(double currentScreenWidth) {
    /// If the [capturedDeviceHeight] is null or 0 return 1
    /// which will leave the original width unchanged
    if (this.capturedDeviceWidth == 0) {
      return 1;
    } else {
      return currentScreenWidth / this.capturedDeviceWidth;
    }
  }
}
