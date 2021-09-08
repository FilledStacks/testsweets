import 'package:flutter/material.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';
import 'package:testsweets/src/ui/shared/shared_text_style.dart';

class WidgetDescriptionDialog extends StatelessWidget {
  final WidgetDescription description;
  final VoidCallback onPressed;

  const WidgetDescriptionDialog(
      {Key? key, required this.description, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var positionX = description.position.x.toStringAsFixed(1);
    var positionY = description.position.y.toStringAsFixed(1);
    var widgetType = description.widgetType.toString().substring(11);

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
                onPressed: onPressed,
              ),
            ],
          ),
          Text('View Name: ${description.viewName}', style: lightStyle),
          Text('Name: ${description.name}', style: lightStyle),
          Text('Widget Type: ${widgetType.capitalizeFirstofEach}',
              style: lightStyle),
          Text('Position: (x:$positionX, y:$positionY)', style: lightStyle),
        ],
      ),
      decoration: BoxDecoration(
        color: Color(0xFF181920),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
