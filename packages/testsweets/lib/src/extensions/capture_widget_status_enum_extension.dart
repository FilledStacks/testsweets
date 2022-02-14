import 'package:testsweets/src/enums/capture_widget_enum.dart';

extension CaptureWidgetEnumUnion on CaptureWidgetStatusEnum {
  bool get createWidgetMode => this == CaptureWidgetStatusEnum.createWidget;
  bool get attachMode => this == CaptureWidgetStatusEnum.attachWidget;
  bool get deattachMode => this == CaptureWidgetStatusEnum.deattachWidget;
  bool get showWidgetForm =>
      this == CaptureWidgetStatusEnum.idle ||
      this == CaptureWidgetStatusEnum.editWidget ||
      this == CaptureWidgetStatusEnum.createWidget;
  bool get showConnections => this == CaptureWidgetStatusEnum.idle;
  bool get showWidgets =>
      this == CaptureWidgetStatusEnum.idle ||
      this == CaptureWidgetStatusEnum.attachWidget ||
      this == CaptureWidgetStatusEnum.quickPositionEdit;
  bool get showDraggableWidget => !attachMode;
}
