import 'package:testsweets/src/enums/capture_widget_enum.dart';

extension CaptureWidgetEnumUnion on CaptureWidgetStatusEnum {
  bool get createWidgetMode => this == CaptureWidgetStatusEnum.createWidget;

  bool get idleMode => this == CaptureWidgetStatusEnum.idle;
  bool get attachMode => this == CaptureWidgetStatusEnum.attachWidget;
  bool get showWidgetVisulizer =>
      this == CaptureWidgetStatusEnum.idle ||
      this == CaptureWidgetStatusEnum.attachWidget ||
      this == CaptureWidgetStatusEnum.popupMenuShown;
}
