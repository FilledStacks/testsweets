import 'package:flutter/material.dart';
import 'package:testsweets/src/constants/app_constants.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/testsweets.dart';

extension InteractionExtension on Interaction {
  bool get isScrollable => this.widgetType == WidgetType.scrollable;
}
