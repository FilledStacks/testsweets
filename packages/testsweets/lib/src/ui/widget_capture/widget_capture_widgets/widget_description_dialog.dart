import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_viewmodel.dart';

class WidgetDescriptionDialog extends ViewModelWidget<WidgetCaptureViewModel> {
  const WidgetDescriptionDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetCaptureViewModel model) {
    final description = model.activeWidgetDescription;

    return Container(
      height: 250,
      width: 390,
      margin: EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Widget Description', style: boldStyle),
              IconButton(
                icon: Icon(
                  Icons.cancel,
                  color: Colors.grey,
                  size: 32,
                ),
                onPressed: model.closeWidgetDescription,
              ),
            ],
          ),
          if (description != null) ...[
            Text('View Name: ${description.viewName}', style: lightStyle),
            Text('Name: ${description.name}', style: lightStyle),
            Text(
                'Widget Type: ${description.widgetType.toString().substring(11).capitalizeFirstofEach}',
                style: lightStyle),
            Text(
                'Position: (x:${description.position.x.toStringAsFixed(1)}, y:${description.position.y.toStringAsFixed(1)})',
                style: lightStyle),
          ]
        ],
      ),
      decoration: BoxDecoration(
        color: Color(0xFF181920),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
