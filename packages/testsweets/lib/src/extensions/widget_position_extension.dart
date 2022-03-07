import 'package:flutter/material.dart';
import 'package:testsweets/testsweets.dart';

extension WidgetPositionExtension on WidgetPosition {
  Offset get toOffset => Offset(this.x, this.y);
}
