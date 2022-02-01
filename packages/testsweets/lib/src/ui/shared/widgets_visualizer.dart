import 'package:flutter/material.dart';
import 'package:testsweets/src/constants/app_constants.dart';

import 'package:testsweets/src/extensions/widget_description_extension.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';
import 'package:testsweets/src/extensions/widget_type_flutter_extension.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_widgets/widget_circle.dart';
import 'package:testsweets/testsweets.dart';

class WidgetsVisualizer extends StatelessWidget {
  final List<WidgetDescription> widgetDescriptions;
  final bool driveMode;
  final bool showWidgetName;
  const WidgetsVisualizer({
    Key? key,
    required this.widgetDescriptions,
    this.showWidgetName = false,
    this.driveMode = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      fit: StackFit.expand,
      children: [
        ...widgetDescriptions.map(
          (description) => Positioned(
            top: description.responsiveYPosition(size.height),
            left: description.responsiveXPosition(size.width),
            child: WidgetCircle(
              transparency: driveMode
                  ? 0
                  : description.visibility
                      ? 1
                      : 0.3,
              key: Key(description.automationKey),
              widgetType: description.widgetType,
            ),
          ),
        ),
        if (showWidgetName)
          ...widgetDescriptions.map(
            (description) => Positioned(
              top: description.responsiveYPosition(size.height),
              left: description.responsiveXPosition(size.width),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: WIDGET_DESCRIPTION_VISUAL_SIZE,
                ),
                child: SizedBox(
                    width: WIDGET_DESCRIPTION_VISUAL_SIZE,
                    child: Text(
                      description.name ?? '',
                      textAlign: TextAlign.center,
                      style: tsSmall().copyWith(
                          color: description.widgetType.getColorOfWidgetType),
                    )),
              ),
            ),
          )
      ],
    );
  }
}
