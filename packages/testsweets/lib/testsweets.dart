library testsweets;

export 'src/models/application_models.dart';
export 'src/setup_code.dart';
export 'src/ui/testsweets_navigator_observer.dart';
export 'src/ui/testsweets_overlay/testsweets_overlay_view.dart';
export 'src/ui/widget_capture/widget_capture_view.dart';

// class TestSweets {
//   /// Creates an tranparent overlay which can be turned on
//   /// to inspect widgets and their key names
//   static Widget builder(BuildContext context, Widget child,
//       {bool enabled = true}) {
//     return enabled && kDebugMode ? WidgetInspectorView(child: child) : child;
//   }
// }
