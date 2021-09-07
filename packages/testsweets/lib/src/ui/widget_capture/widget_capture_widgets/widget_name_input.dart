import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_widgets/close_circular_button.dart';

class WidgetNameInput extends StatelessWidget {
  final FocusNode? focusNode;
  final TextEditingController? textEditingController;
  final VoidCallback switchPositionTap;
  const WidgetNameInput({
    Key? key,
    this.focusNode,
    this.textEditingController,
    required this.switchPositionTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      padding: const EdgeInsets.symmetric(horizontal: 24),
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
                  size: 20.w,
                  color: kcPrimaryWhite,
                ),
                label: AutoSizeText('Switch Position',
                    maxLines: 1,
                    style: tsNormal().copyWith(
                      color: Colors.white,
                    )),
              ),
              CloseCircularButton()
            ],
          ),
          // TextField(
          //   focusNode: focusNode,
          //   controller: textEditingController,
          //   style: tsNormal(),
          //   decoration: InputDecoration(
          //     hintStyle: tsNormal().copyWith(
          //       color: kcTextFieldHintTextColor,
          //     ),
          //     hintText: 'Widget Name',
          //     contentPadding: EdgeInsets.only(
          //         left: 16.w, top: 20.h, right: 16.w, bottom: 20.h),
          //     focusedBorder: OutlineInputBorder(
          //       borderSide: BorderSide(
          //         width: 1.w,
          //         color: Theme.of(context).accentColor,
          //       ),
          //       borderRadius: BorderRadius.all(
          //         crTextFieldCornerRadius(),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
