import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';
import 'package:testsweets/src/ui/shared/cta_button.dart';
import 'package:testsweets/src/ui/shared/icon_button.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';
import 'package:testsweets/utils/error_messages.dart';

class InfoForm extends StatefulWidget {
  final VoidCallback submitWidgetInfoForm;
  final VoidCallback closeWidgetInfoForm;
  final String? initialValue;

  const InfoForm({
    Key? key,
    required this.submitWidgetInfoForm,
    required this.closeWidgetInfoForm,
    this.initialValue,
  }) : super(key: key);

  @override
  State<InfoForm> createState() => _InfoFormState();
}

class _InfoFormState extends State<InfoForm> {
  late TextEditingController nameController;
  bool showErrorMessage = false;
  @override
  void initState() {
    nameController = TextEditingController(text: widget.initialValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: kdBlackRoundedEdgeDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SweetIconButton(
                  onTap: () {},
                  svgIcon: 'packages/testsweets/assets/svgs/eye.svg',
                  svgWidth: 24),
              SweetIconButton(
                  onTap: widget.closeWidgetInfoForm,
                  overlayColor: kcFailTestRedColor,
                  svgIcon: 'packages/testsweets/assets/svgs/close.svg',
                  svgWidth: 16)
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
                  controller: nameController,
                  initialValue: widget.initialValue,
                  style: tsNormal().copyWith(color: kcPrimaryWhite),
                  decoration: InputDecoration(
                      errorStyle:
                          tsSmall().copyWith(color: kcError, height: 0.9),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: kcError,
                        ),
                        borderRadius: BorderRadius.all(
                          crTextFieldCornerRadius(),
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: kcError,
                        ),
                        borderRadius: BorderRadius.all(
                          crTextFieldCornerRadius(),
                        ),
                      ),
                      errorText: showErrorMessage
                          ? ErrorMessages.widgetInputNameIsEmpty
                          : null,
                      hintStyle: tsNormal().copyWith(
                        color: kcTextFieldHintTextColor,
                      ),
                      fillColor: kcTestItemCardColor,
                      filled: true,
                      hintText: 'Widget Name',
                      contentPadding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: kcSecondaryGreen,
                        ),
                        borderRadius: BorderRadius.all(
                          crTextFieldCornerRadius(),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: kcBackground,
                        ),
                        borderRadius: BorderRadius.all(
                          crTextFieldCornerRadius(),
                        ),
                      )),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              SweetIconButton(
                  backgroundColor: kcSecondaryGreen,
                  onTap: () {
                    if (nameController.text.trim().isEmpty) {
                      setState(() {
                        showErrorMessage = true;
                      });
                    }
                  },
                  svgIcon: 'packages/testsweets/assets/svgs/tick.svg',
                  svgWidth: 32)
            ],
          ),
          const SizedBox(
            width: 12,
          ),
        ],
      ),
    );
  }
}
