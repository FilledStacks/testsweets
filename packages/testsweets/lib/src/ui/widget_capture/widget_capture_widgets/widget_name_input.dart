import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';
import 'package:testsweets/src/ui/shared/cta_button.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';

import 'black_wrapper_container.dart';

class WidgetNameInput extends StatelessWidget {
  final FocusNode? focusNode;
  final TextEditingController? textEditingController;
  final VoidCallback switchPositionTap;
  final VoidCallback deleteWidget;
  final VoidCallback saveWidget;
  final VoidCallback closeWidget;
  final String errorMessage;
  final bool isEditMode;
  final String? initialValue;
  final ValueChanged<String>? onChanged;

  const WidgetNameInput({
    Key? key,
    this.focusNode,
    this.textEditingController,
    required this.switchPositionTap,
    required this.saveWidget,
    required this.closeWidget,
    required this.errorMessage,
    required this.deleteWidget,
    this.isEditMode = false,
    this.initialValue,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BlackWrapperContainer(
          bottomCornerRaduisIsZero: errorMessage.isNotEmpty,
          switchPositionTap: switchPositionTap,
          closeWidgetOnTap: closeWidget,
          footerChild: FadeInWidget(
              child: Container(
                width: ScreenUtil().screenWidth,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16.w),
                decoration: redBoxDecoration,
                child: AutoSizeText(errorMessage,
                    style: tsSmall().copyWith(color: kcPrimaryWhite)),
              ),
              isVisible: errorMessage.isNotEmpty),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  focusNode: focusNode,
                  controller: textEditingController,
                  initialValue: initialValue,
                  style: tsNormal().copyWith(color: kcPrimaryWhite),
                  onChanged: onChanged,
                  decoration: InputDecoration(
                      hintStyle: tsNormal().copyWith(
                        color: kcSecondaryWhite,
                      ),
                      fillColor: kcSweetsAppBarColor,
                      filled: true,
                      hintText: 'Widget Name',
                      contentPadding: EdgeInsets.only(
                        left: 16.w,
                        right: 16.w,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1.w,
                          color: kcSecondaryGreen,
                        ),
                        borderRadius: BorderRadius.all(
                          crTextFieldCornerRadius(),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1.w,
                          color: kcBackground,
                        ),
                        borderRadius: BorderRadius.all(
                          crTextFieldCornerRadius(),
                        ),
                      )),
                ),
              ),
              SizedBox(
                width: 12.w,
              ),
              Column(
                children: [
                  CtaButton(
                    title: isEditMode ? 'Update Widget' : 'Save Widget',
                    fillColor: isEditMode ? kcPrimaryPurple : kcSecondaryGreen,
                    onTap: () {
                      saveWidget();
                      focusNode?.unfocus();
                      textEditingController?.clear();
                    },
                    maxWidth: 100.w,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
