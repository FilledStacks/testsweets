import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/services/widget_capture_service.dart';

class _AutoCaptureCode extends StatefulWidget {
  _AutoCaptureCode({Key? key}) : super(key: key);

  @override
  State<_AutoCaptureCode> createState() => __AutoCaptureCodeState();
}

class __AutoCaptureCodeState extends State<_AutoCaptureCode>
    with SingleTickerProviderStateMixin {
  /// A set of element IDs that have already been scanned.
  final Set<int> _scannedElementIds = {};
  final _widgetCaptureService = locator<WidgetCaptureService>();

  /// A ticker that scans the widget tree at every frame.
  late final Ticker _ticker;
  late Orientation _orientation;
  late Size _screenSize;

  @override
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void initState() {
    super.initState();

    _setupPeriodicScanner();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _orientation = MediaQuery.of(context).orientation;
      _screenSize = MediaQuery.of(context).size;
    });
  }

  void _scanWidgetTree() {
    // Re-scan the widget tree when the dependencies change.
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.visitChildElements(_recursiveVisitor),
    );
  }

  void _setupPeriodicScanner() {
    _ticker = this.createTicker((_) {
      _scanWidgetTree();
    });

    _ticker.start();
  }

  void _recursiveVisitor(Element element) {
    // Get the element's identity hash code. This is used to determine if the
    // element has already been scanned. The identityHashCode of an object is
    // guaranteed to be unique for each instance of an object for the duration
    // of a Dart program’s execution. Unlike the key, the identity hash code
    // exists always, so it is stable across widget rebuilds.
    final elementId = identityHashCode(element);

    // Only scan unique elements.
    if (!_scannedElementIds.contains(elementId)) {
      _scannedElementIds.add(elementId);

      final renderObject = element.findRenderObject();

      // Check whether it is renderbox and is visible on UI for interaction
      if (renderObject case RenderBox(hasSize: true)
          when !renderObject.paintBounds.isEmpty) {
        final Offset position = renderObject.localToGlobal(Offset.zero);
        final Size size = renderObject.size;

        // Check the widget type
        WidgetType? type;
        if (element.widget is GestureDetector) {
          type = WidgetType.touchable;
        } else if (element.widget is ListView ||
            element.widget is SingleChildScrollView ||
            element.widget is GridView ||
            element.widget is CustomScrollView) {
          type = WidgetType.scrollable;
        } else if (element.widget is TextField ||
            element.widget is CupertinoTextField) {
          type = WidgetType.input;
        }

        if (type != null) {
          _widgetCaptureService.autoCaptureInteraction(
            orientation: _orientation,
            size: _screenSize,
            position: position,
            type: type,
          );
        }
      }
    }

    // Recurse to children
    element.visitChildren(_recursiveVisitor);
  }
}
