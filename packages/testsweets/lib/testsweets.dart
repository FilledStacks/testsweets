library testsweets;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:testsweets/widget_inspector.dart';

class TestSweets {
  /// Creates an tranparent overlay which can be turned on
  /// to inspect widgets and their key names
  static Widget builder(BuildContext context, Widget child,
      {bool enabled = true}) {
    return enabled && kDebugMode ? WidgetInspectorView(child: child) : child;
  }
}
