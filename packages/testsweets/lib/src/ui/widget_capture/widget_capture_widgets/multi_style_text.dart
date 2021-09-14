import 'package:flutter/material.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';

class MultiStyleText extends StatelessWidget {
  final String title;
  final String body;
  const MultiStyleText({Key? key, required this.title, required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(children: [
        TextSpan(
            style: lightStyle.copyWith(color: kcPrimaryPurple), text: title),
        TextSpan(
            style: lightStyle.copyWith(
              color: body.isEmpty ? kcError : kcPrimaryWhite,
            ),
            text: body.isEmpty ? '(empty)' : body),
      ]),
    );
  }
}
