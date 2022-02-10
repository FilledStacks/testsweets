import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';

import 'cta_button.dart';
import 'icon_button.dart';
import 'shared_styles.dart';

class ConfirmationDialogFrame extends StatelessWidget {
  final String submitActionTitle;
  final String title;
  final String? description;
  final String? cancelActionTitle;
  final void Function(DialogResponse) onSubmit;
  final bool canSubmit;
  final Widget? child;
  final Color? submitButtonColor;
  const ConfirmationDialogFrame(
      {Key? key,
      this.submitActionTitle = 'Submit',
      this.cancelActionTitle,
      required this.onSubmit,
      required this.title,
      this.description,
      this.canSubmit = true,
      this.child,
      this.submitButtonColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 16, top: 8),
      width: 400,
      decoration: BoxDecoration(
        color: kcBackground.withOpacity(0.98),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16, right: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AutoSizeText(
                    title,
                    maxLines: 1,
                    style: tsLarge().copyWith(height: 1.7),
                  ),
                ),
                SweetIconButton(
                  onTap: () => onSubmit(DialogResponse(confirmed: false)),
                  svgIcon: 'packages/testsweets/assets/svgs/close.svg',
                  svgWidth: 20,
                ),
              ],
            ),
          ),
          if (description != null)
            Padding(
              padding: const EdgeInsets.only(
                  top: 4, left: 16, right: 16, bottom: 16),
              child: Text(description!,
                  textAlign: TextAlign.center,
                  style: tsNormal().copyWith(color: kcSubtext)),
            ),
          Divider(
            color: kcPrimaryWhite,
            height: 1,
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 5,
                  child: CtaButton(
                    title: submitActionTitle,
                    fillColor: kcError,
                    onTap: () => onSubmit(DialogResponse(confirmed: true)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
