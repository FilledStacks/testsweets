import 'package:testsweets/src/enums/capture_widget_enum.dart';

extension CaptureWidgetEnumUnion on CaptureWidgetStatusEnum {
  bool get infoFormMode => this == CaptureWidgetStatusEnum.widgetInfoForm;
  bool get idleMode => this == CaptureWidgetStatusEnum.idle;
}
