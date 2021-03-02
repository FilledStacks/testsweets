import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_models.freezed.dart';
part 'data_models.g.dart';

@freezed
abstract class AutomationKey implements _$AutomationKey {
  const AutomationKey._();
  factory AutomationKey({
    String name,
    WidgetType type,
    String view,
  }) = _AutomationKey;

  String toDartCode() {
    return "  {'name': '${this.name}', 'type': '${this.type}', 'view': '${this.view}'}";
  }

  factory AutomationKey.fromJson(Map<String, dynamic> json) =>
      _$AutomationKeyFromJson(json);
}

enum WidgetType {
  touchable,
  text,
  general,
  view,
  input,
  scrollable,
}
