import 'package:testsweets/src/enums/capture_widget_enum.dart';

extension CaptureWidgetEnumUnion on CaptureWidgetStatusEnum {
  bool get isAtCaptureMode =>
      this == CaptureWidgetStatusEnum.captureMode ||
      this == CaptureWidgetStatusEnum.captureModeWidgetNameInputShow ||
      this == CaptureWidgetStatusEnum.captureModeWidgetsContainerShow ||
      this == CaptureWidgetStatusEnum.captureModeAddWidget;
  bool get isAtInspectModeMode =>
      this == CaptureWidgetStatusEnum.inspectMode ||
      this == CaptureWidgetStatusEnum.inspectModeDialogShow ||
      this == CaptureWidgetStatusEnum.inspectModeUpdate;
  bool get isSelectWidgetMode =>
      this == CaptureWidgetStatusEnum.inspectModeUpdate ||
      this == CaptureWidgetStatusEnum.inspectModeDialogShow;
}
