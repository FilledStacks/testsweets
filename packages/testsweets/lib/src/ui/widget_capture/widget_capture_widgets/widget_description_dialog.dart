import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:testsweets/src/extensions/string_extension.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_viewmodel.dart';
import 'package:testsweets/testsweets.dart';

import 'multi_style_text.dart';

class WidgetDescriptionDialog extends StatelessWidget {
  final VoidCallback closeInfoDescription;
  final WidgetDescription? widgetDescription;
  const WidgetDescriptionDialog({
    Key? key,
    required this.closeInfoDescription,
    required this.widgetDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widgetDescription != null)
          ...[
            MultiStyleText(
              title: 'View Name: ',
              body: widgetDescription!.viewName,
            ),
            MultiStyleText(
              title: 'Name: ',
              body: widgetDescription!.name,
            ),
            MultiStyleText(
              title: 'Widget Type: ',
              body: widgetDescription!.widgetType
                  .toString()
                  .substring(11)
                  .capitalizeFirstOfEach,
            ),
            MultiStyleText(
              title: 'Position: ',
              body:
                  '( x: ${widgetDescription!.position.x.toStringAsFixed(1)}, y: ${widgetDescription!.position.y.toStringAsFixed(1)} )',
            ),
          ].expand((element) => [
                element,
                SizedBox(
                  height: 3,
                )
              ]),
      ],
    );
  }
}
