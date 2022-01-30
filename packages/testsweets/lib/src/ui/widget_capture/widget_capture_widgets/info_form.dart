import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'package:testsweets/src/models/widget_form_info_model.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';
import 'package:testsweets/src/ui/shared/icon_button.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';
import 'package:testsweets/utils/error_messages.dart';

class InfoForm extends StatefulWidget {
  final Function(WidgetFormInfoModel) submitWidgetInfoForm;
  final VoidCallback closeWidgetInfoForm;
  final WidgetFormInfoModel? widgetFormInfoModel;

  const InfoForm({
    Key? key,
    required this.submitWidgetInfoForm,
    required this.closeWidgetInfoForm,
    this.widgetFormInfoModel,
  }) : super(key: key);

  @override
  State<InfoForm> createState() => _InfoFormState();
}

class _InfoFormState extends State<InfoForm> {
  late TextEditingController nameController;
  bool isWidgetVisible = true;
  bool showErrorMessage = false;
  @override
  void initState() {
    nameController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SolidBottomSheet(
      showOnAppear: true,
      headerBar: SvgPicture.asset(
        'packages/testsweets/assets/svgs/up_arrow_handle.svg',
      ),
      minHeight: 0,
      maxHeight: 150,
      toggleVisibilityOnTap: true,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: kdBlackRoundedEdgeDecoration,
        child: ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SweetIconButton(
                    onTap: () {
                      setState(() {
                        isWidgetVisible = !isWidgetVisible;
                      });
                    },
                    svgIcon: isWidgetVisible
                        ? 'packages/testsweets/assets/svgs/eye.svg'
                        : 'packages/testsweets/assets/svgs/eye_closed.svg',
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
                      } else {
                        widget.submitWidgetInfoForm(WidgetFormInfoModel(
                            name: nameController.text,
                            visibilty: isWidgetVisible));
                      }
                    },
                    svgIcon: 'packages/testsweets/assets/svgs/tick.svg',
                    svgWidth: 30)
              ],
            ),
            const SizedBox(
              width: 12,
            ),
          ],
        ),
      ),
    );
  }
}
