import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class WidgetInspectorView extends StatefulWidget {
  final Widget child;

  const WidgetInspectorView({Key? key, required this.child}) : super(key: key);
  @override
  _WidgetInspectorViewState createState() => _WidgetInspectorViewState();
}

class _WidgetInspectorViewState extends State<WidgetInspectorView> {
  String _selectedKey = '';

  bool _showOverlay = false;

  void showKey(WidgetInfo widget) {
    String key = widget.key.toString();
    setState(() {
      _selectedKey = key.substring(3, key.length - 3);
    });
  }

  void toggleOverlay() {
    _showOverlay = !_showOverlay;
    if (!_showOverlay) {
      _selectedKey = '';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Overlay(
          child: widget.child,
          onTap: (widget) => showKey(widget),
          showOverlay: _showOverlay,
        ),
        Material(
          child: Container(
            padding: EdgeInsets.only(left: 12),
            color: _showOverlay ? Colors.green[300] : Colors.red[200],
            height: 40,
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: AutoSizeText(
                    _selectedKey,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                FlatButton(
                  child: Text(_showOverlay ? 'Turn OFF' : 'Turn ON'),
                  onPressed: toggleOverlay,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class Overlay extends StatefulWidget {
  final Widget child;
  final Function(WidgetInfo) onTap;
  final bool showOverlay;

  const Overlay(
      {Key? key,
      required this.child,
      required this.onTap,
      this.showOverlay = false})
      : super(key: key);
  @override
  _OverlayState createState() => _OverlayState();
}

class _OverlayState extends State<Overlay> {
  List<WidgetInfo> elements = [];

  // TODO: Optimise for widget rebuilds
  void getElements(BuildContext context) {
    elements.clear();
    void visitor(Element element) {
      Key? key = element.widget.key;
      if (key.toString().contains(RegExp(r'.*_.*_.*'))) {
        while (element.findRenderObject() is! RenderBox) {}
        RenderBox box = element.findRenderObject() as RenderBox;

        elements.add(WidgetInfo(
          size: box.size,
          offset: box.localToGlobal(Offset.zero),
          key: key,
        ));
      }
      element.visitChildren(visitor);
    }

    // TODO: Prevent infinite loop if setState is used
    // setState(() {  });

    context.visitChildElements(visitor);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) => getElements(context));
    return Expanded(
      child: Stack(
        children: [
          Positioned.fill(child: widget.child),
          if (widget.showOverlay)
            for (var element in elements)
              Positioned.fromRect(
                child: SizedBox(
                  width: element.size.width,
                  height: element.size.height,
                  child: GestureDetector(
                    onTap: () => widget.onTap(element),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.03),
                          border: Border.all(width: 1, color: Colors.red)),
                    ),
                  ),
                ),
                rect: Rect.fromLTWH(
                  element.offset.dx,
                  element.offset.dy,
                  element.size.width,
                  element.size.height,
                ),
              ),
        ],
      ),
    );
  }
}

class WidgetInfo {
  final Size size;
  final Offset offset;
  final Key? key;

  const WidgetInfo({required this.size, required this.offset, this.key});

  @override
  String toString() {
    return key.toString() + ' - ' + size.toString() + ' - ' + offset.toString();
  }
}
