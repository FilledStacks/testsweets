import 'package:testsweets/src/enums/capture_widget_enum.dart';

extension CaptureWidgetEnumUnion on CaptureWidgetStatusEnum {
  bool get widgetTypeSelector =>
      this == CaptureWidgetStatusEnum.widgetTypeSelector;
  bool get infoFormMode => this == CaptureWidgetStatusEnum.widgetInfoForm;
}
