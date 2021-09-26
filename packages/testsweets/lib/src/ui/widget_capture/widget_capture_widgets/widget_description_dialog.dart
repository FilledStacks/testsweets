import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:testsweets/src/extensions/string_extension.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';
import 'package:testsweets/src/ui/shared/cta_button.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_viewmodel.dart';

import 'black_wrapper_container.dart';
import 'multi_style_text.dart';

class WidgetDescriptionDialog extends ViewModelWidget<WidgetCaptureViewModel> {
  const WidgetDescriptionDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetCaptureViewModel model) {
    final description = model.activeWidgetDescription;

    return BlackWrapperContainer(
      closeWidget: model.closeWidgetDescription,
      spaceBetweenTopControllersAndChild: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Widget Description', style: boldStyle),
          SizedBox(
            height: 8.h,
          ),
          if (description != null)
            ...[
              MultiStyleText(
                title: 'View Name: ',
                body: description.viewName,
              ),
              MultiStyleText(
                title: 'Name: ',
                body: description.name,
              ),
              MultiStyleText(
                title: 'Widget Type: ',
                body: description.widgetType
                    .toString()
                    .substring(11)
                    .capitalizeFirstOfEach,
              ),
              MultiStyleText(
                title: 'Position: ',
                body:
                    '( x: ${description.position.x.toStringAsFixed(1)}, y: ${description.position.y.toStringAsFixed(1)} )',
              ),
            ].expand((element) => [
                  element,
                  SizedBox(
                    height: 3.h,
                  )
                ]),
          SizedBox(
            height: 5.h,
          ),
          CtaButton(
            onTap: model.editWidgetDescription,
            fillColor: kcSecondaryWhite,
            title: 'Edit',
            isSmallSize: true,
          )
        ],
      ),
    );
  }
}
