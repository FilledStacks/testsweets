import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';

import '../widget_capture_viewmodel.dart';

class MultiStyleText extends ViewModelWidget<WidgetCaptureViewModel> {
  final String title;
  final String body;
  const MultiStyleText({Key? key, required this.title, required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetCaptureViewModel model) {
    return Text.rich(
      TextSpan(children: [
        TextSpan(style: lightStyle.copyWith(color: kcCard), text: title),
        TextSpan(
            style: lightStyle.copyWith(
              color: body.isEmpty ? kcError : kcSubtext,
            ),
            text: body.isEmpty ? '(empty)' : body),
      ]),
    );
  }
}
