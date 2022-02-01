import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/src/provider.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';
import 'package:testsweets/src/ui/shared/cta_button.dart';
import 'package:testsweets/src/ui/shared/custom_solid_controller.dart';
import 'package:testsweets/src/ui/shared/icon_button.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_viewmodel.dart';
import 'package:testsweets/utils/error_messages.dart';

import 'type_selector.dart';

class InfoForm extends StatefulWidget {
  const InfoForm({
    Key? key,
  }) : super(key: key);

  @override
  State<InfoForm> createState() => _InfoFormState();
}

class _InfoFormState extends State<InfoForm> {
  late TextEditingController nameController;
  late FocusNode focusNode;
  bool isWidgetVisible = true;
  WidgetType? widgetType;
  bool showErrorMessage = false;
  late SolidController solidController;
  @override
  void initState() {
    nameController = TextEditingController();
    focusNode = FocusNode();
    solidController = SolidController();

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    focusNode.dispose();
    solidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WidgetCaptureViewModel>();

    return CustomSolidBottomSheet(
      controller: solidController,
      headerBar: SvgPicture.asset(
        'packages/testsweets/assets/svgs/up_arrow_handle.svg',
      ),
      toggleVisibilityOnTap: true,
      autoSwiped: false,
      minHeight: 0,
      maxHeight: 300,
      onHide: () {
        model.toggleInfoForm(false);
      },
      onShow: () {
        model.toggleInfoForm(true);
      },
      body: Container(
        decoration: kdBlackRoundedEdgeDecoration,
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('Select widget type:',
                  textAlign: TextAlign.left, style: tsMedium()),
            ),
            TypeSelector(
              onTap: model.onWidgetTypeSelected,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16)
                  .copyWith(bottom: 8),
              child: Text('Select widget name and visibilty:',
                  textAlign: TextAlign.left, style: tsMedium()),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      focusNode: focusNode,
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
                      backgroundColor: kcBackground,
                      onTap: () {
                        setState(() {
                          isWidgetVisible = !isWidgetVisible;
                        });
                      },
                      svgIcon: isWidgetVisible
                          ? 'packages/testsweets/assets/svgs/eye.svg'
                          : 'packages/testsweets/assets/svgs/eye_closed.svg',
                      svgWidth: 30),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CtaButton(
                  isDisabled: model.widgetDescription == null,
                  onTap: () async {
                    final trimmedText = nameController.text.trim();
                    if (trimmedText.isEmpty) {
                      setState(() {
                        showErrorMessage = true;
                      });
                    } else {
                      final result = await model.saveWidget(
                          name: trimmedText, visibilty: isWidgetVisible);

                      /// When widget is saved successfully hide
                      /// the bottom sheet and clear the text
                      if (result == null) {
                        nameController.clear();
                        focusNode.unfocus();
                        solidController.hide();
                      }
                    }
                  },
                  fillColor: kcPrimaryPurple,
                  title: 'Save'),
            )
          ],
        ),
      ),
    );
  }
}
