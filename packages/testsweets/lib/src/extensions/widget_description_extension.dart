import 'package:testsweets/src/constants/app_constants.dart';
import 'package:testsweets/testsweets.dart';

extension WidgetDescriptionUtils on WidgetDescription {
  double responsiveWidth(double currentScreenWidth) =>
      _calculateWidthRatio(currentScreenWidth) * this.position.x -
      (WIDGET_DESCRIPTION_VISUAL_SIZE / 2);
  double responsiveHeight(double currentScreenHeight) =>
      _calculateHeightRatio(currentScreenHeight) * this.position.y -
      (WIDGET_DESCRIPTION_VISUAL_SIZE / 2);

  double _calculateHeightRatio(double currentScreenHeight) {
    return currentScreenHeight / this.position.capturedDeviceHeight;
  }

  double _calculateWidthRatio(double currentScreenWidth) {
    return currentScreenWidth / this.position.capturedDeviceWidth;
  }
}
