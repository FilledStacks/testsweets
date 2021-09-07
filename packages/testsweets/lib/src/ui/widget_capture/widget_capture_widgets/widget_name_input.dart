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
  const WidgetNameInput({
    Key? key,
    this.focusNode,
    this.textEditingController,
    required this.switchPositionTap,
    required this.saveWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 12.w,
      ).copyWith(
          top: 32.h, bottom: MediaQuery.of(context).viewInsets.bottom + 24.h),
      padding:
          EdgeInsets.only(left: 16.w, right: 16.w, top: 12.h, bottom: 20.h),
      decoration: blackBoxDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: switchPositionTap,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kcBackground),
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
              CloseCircularButton()
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
                    hintText: 'Widget Name',
                    contentPadding: EdgeInsets.only(
                      left: 16.w,
                      right: 16.w,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1.w,
                        color: Theme.of(context).accentColor,
                      ),
                      borderRadius: BorderRadius.all(
                        crTextFieldCornerRadius(),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 12.w,
              ),
              CtaButton(
                title: 'Save Widget',
                fillColor: kcSecondaryGreen,
                onTap: saveWidget,
                maxWidth: 100.w,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
