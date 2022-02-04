import 'package:testsweets/src/constants/app_constants.dart';
import 'package:testsweets/testsweets.dart';

extension WidgetDescriptionUtils on WidgetDescription {
  double? responsiveXPosition(double currentScreenWidth) {
    if (this.position == null) return null;

    final result = _calculateWidthRatio(currentScreenWidth) * this.position!.x -
        (WIDGET_DESCRIPTION_VISUAL_SIZE / 2);
    return result;
  }

  double? responsiveYPosition(double currentScreenHeight) {
    if (this.position == null) return null;
    final result =
        _calculateHeightRatio(currentScreenHeight) * this.position!.y -
            (WIDGET_DESCRIPTION_VISUAL_SIZE / 2);
    return result;
  }

  double _calculateHeightRatio(double currentScreenHeight) {
    /// If the [capturedDeviceHeight] is null or 0 return 1
    /// which will leave the original hight unchanged
    if (this.position!.capturedDeviceHeight == null ||
        this.position!.capturedDeviceHeight == 0) {
      return 1;
    } else {
      return currentScreenHeight / this.position!.capturedDeviceHeight!;
    }
  }

  double _calculateWidthRatio(double currentScreenWidth) {
    /// If the [capturedDeviceHeight] is null or 0 return 1
    /// which will leave the original hight unchanged
    if (this.position!.capturedDeviceWidth == null ||
        this.position!.capturedDeviceWidth == 0) {
      return 1;
    } else {
      return currentScreenWidth / this.position!.capturedDeviceWidth!;
    }
  }
}
