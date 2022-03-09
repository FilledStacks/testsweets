import 'dart:ui';

import 'package:testsweets/src/extensions/string_extension.dart';

extension SetExtension on Set<String> {
  Rect get toUnionRect {
    final listOfRects = this.map((e) => e.extractRectFromString);
    return listOfRects
        .reduce((value, element) => value.expandToInclude(element));
  }
}
