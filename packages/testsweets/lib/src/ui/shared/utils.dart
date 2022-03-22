import 'package:flutter/material.dart';
import 'package:testsweets/src/constants/app_constants.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:flutter_test/flutter_test.dart';

class Utils {
  static double halfOfLengthMinusWidgetRadius(double length) {
    return length / 2 - WIDGET_DESCRIPTION_VISUAL_SIZE / 2;
  }
}
