import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';
import 'package:testsweets/src/ui/shared/cta_button.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_widgets/close_circular_button.dart';

class WidgetNameInput extends StatelessWidget {
  final FocusNode? focusNode;
  final TextEditingController? textEditingController;
  final VoidCallback switchPositionTap;
  final VoidCallback saveWidget;
  final VoidCallback closeWidget;
  final String errorMessage;
  const WidgetNameInput({
    Key? key,
    this.focusNode,
    this.textEditingController,
    required this.switchPositionTap,
    required this.saveWidget,
    required this.closeWidget,
    required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
      ).copyWith(
          top: 32.h, bottom: MediaQuery.of(context).viewInsets.bottom + 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
                left: 16.w, right: 16.w, top: 12.h, bottom: 20.h),
            decoration: blackBoxDecoration.copyWith(
                borderRadius: errorMessage.isNotEmpty
                    ? BorderRadius.vertical(top: crButtonCornerRadius())
                    : null),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: switchPositionTap,
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    crTextFieldCornerRadius()))),
                        backgroundColor:
                            MaterialStateProperty.all(kcPrimaryFuchsia),
                      ),
                      icon: Icon(
                        Icons.swap_vert,
                        size: 16.w,
                        color: kcPrimaryWhite,
                      ),
                      label: AutoSizeText('Switch Position',
                          maxLines: 1,
                          style: tsNormal()
                              .copyWith(color: Colors.white, fontSize: 14.w)),
                    ),
                    GestureDetector(
                        onTap: closeWidget, child: CloseCircularButton())
                  ],
                ),
                SizedBox(
                  height: 24.w,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        focusNode: focusNode,
                        controller: textEditingController,
                        style: tsNormal().copyWith(color: kcPrimaryWhite),
                        decoration: InputDecoration(
                            hintStyle: tsNormal().copyWith(
                              color: kcPrimaryWhite,
                            ),
                            fillColor: kcBackground,
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
                    CtaButton(
                      title: 'Save Widget',
                      fillColor: kcSecondaryGreen,
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
          FadeInWidget(
              child: Container(
                width: ScreenUtil().screenWidth,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                decoration: redBoxDecoration,
                child: AutoSizeText(errorMessage,
                    style: tsSmall().copyWith(color: kcPrimaryWhite)),
              ),
              isVisible: errorMessage.isNotEmpty)
        ],
      ),
    );
  }
}
