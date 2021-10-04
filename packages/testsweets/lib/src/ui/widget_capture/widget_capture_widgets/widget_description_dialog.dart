import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:testsweets/src/extensions/string_extension.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';
import 'package:testsweets/src/ui/shared/cta_button.dart';
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
      spaceBetweenTopControllersAndChild: 4.h,
      closeWidgetOnTap: model.closeWidgetDescription,
      title: 'Widget Description',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            height: 12.h,
          ),
          Row(
            children: [
              Expanded(
                child: CtaButton(
                  onTap: model.editWidgetDescription,
                  fillColor: kcPrimaryPurple,
                  title: 'Edit',
                  isSmallSize: true,
                ),
              ),
              Spacer(),
              Expanded(
                child: CtaButton(
                  onTap: model.deleteWidgetDescription,
                  fillColor: kcError,
                  title: 'Delete',
                  isSmallSize: true,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
