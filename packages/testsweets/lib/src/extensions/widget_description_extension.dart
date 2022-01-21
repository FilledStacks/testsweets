import 'package:testsweets/src/constants/app_constants.dart';
import 'package:testsweets/testsweets.dart';

extension WidgetDescriptionUtils on WidgetDescription {
  double responsiveXPosition(double currentScreenWidth) =>
      _calculateWidthRatio(currentScreenWidth) * this.position.x -
      (WIDGET_DESCRIPTION_VISUAL_SIZE / 2);
  double responsiveYPosition(double currentScreenHeight) =>
      _calculateHeightRatio(currentScreenHeight) * this.position.y -
      (WIDGET_DESCRIPTION_VISUAL_SIZE / 2);

  double _calculateHeightRatio(double currentScreenHeight) {
    /// If the [capturedDeviceHeight] is null or 0 return 1
    /// which will leave the original hight unchanged
    if (this.position.capturedDeviceHeight == 0 ||
        this.position.capturedDeviceHeight == null) {
      return 1;
    } else {
      return currentScreenHeight / this.position.capturedDeviceHeight!;
    }
  }

  double _calculateWidthRatio(double currentScreenWidth) {
    /// If the [capturedDeviceHeight] is null or 0 return 1
    /// which will leave the original hight unchanged
    if (this.position.capturedDeviceWidth == 0 ||
        this.position.capturedDeviceWidth == null) {
      return 1;
    } else {
      return currentScreenWidth / this.position.capturedDeviceWidth!;
    }
  }
}
