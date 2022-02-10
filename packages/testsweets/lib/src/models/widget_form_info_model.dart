import 'package:freezed_annotation/freezed_annotation.dart';
part 'widget_form_info_model.freezed.dart';
part 'widget_form_info_model.g.dart';

@freezed
class WidgetFormInfoModel with _$WidgetFormInfoModel {
  factory WidgetFormInfoModel({
    required String name,
    @Default(true) bool visibilty,
  }) = _WidgetFormInfoModel;

  factory WidgetFormInfoModel.fromJson(Map<String, dynamic> json) =>
      _$WidgetFormInfoModelFromJson(json);
}
