enum CaptureWidgetStatusEnum {
  idle,
  inspectMode,
  inspectModeDialogShow,
  captureMode,
  captureModeAddWidget,
  captureModeWidgetsContainerShow,
  captureModeWidgetNameInputShow,
}

extension CaptureWidgetEnumUnion on CaptureWidgetStatusEnum {
  bool isAtCaptureMode() =>
      this == CaptureWidgetStatusEnum.captureMode ||
      this == CaptureWidgetStatusEnum.captureModeWidgetNameInputShow ||
      this == CaptureWidgetStatusEnum.captureModeWidgetsContainerShow ||
      this == CaptureWidgetStatusEnum.captureModeAddWidget;
  bool isAtInspectModeMode() =>
      this == CaptureWidgetStatusEnum.inspectMode ||
      this == CaptureWidgetStatusEnum.inspectModeDialogShow;
}
