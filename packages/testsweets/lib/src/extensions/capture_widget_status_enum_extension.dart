import 'package:testsweets/src/enums/capture_widget_enum.dart';

extension CaptureWidgetEnumUnion on CaptureWidgetState {
  bool get createWidgetMode => this == CaptureWidgetState.createWidget;

  bool get showWidgetForm =>
      this == CaptureWidgetState.idle ||
      this == CaptureWidgetState.editWidget ||
      this == CaptureWidgetState.createWidget;

  bool get showConnections => this == CaptureWidgetState.idle;

  bool get showWidgets =>
      this == CaptureWidgetState.idle ||
      this == CaptureWidgetState.quickPositionEdit ||
      this == CaptureWidgetState.createWidget;

  bool get showDraggableWidget =>
      this == CaptureWidgetState.idle ||
      this == CaptureWidgetState.createWidget ||
      this == CaptureWidgetState.editWidget ||
      this == CaptureWidgetState.quickPositionEdit;
}
