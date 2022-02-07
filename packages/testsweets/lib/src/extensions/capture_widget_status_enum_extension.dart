import 'package:testsweets/src/enums/capture_widget_enum.dart';

extension CaptureWidgetEnumUnion on CaptureWidgetStatusEnum {
  bool get createWidgetMode => this == CaptureWidgetStatusEnum.createWidget;
  bool get showDraggableWidget =>
      this == CaptureWidgetStatusEnum.createWidget ||
      this == CaptureWidgetStatusEnum.popupMenuShown;
  bool get idleMode => this == CaptureWidgetStatusEnum.idle;
  bool get showWidgetVisulizer =>
      this == CaptureWidgetStatusEnum.idle ||
      this == CaptureWidgetStatusEnum.popupMenuShown;
}
