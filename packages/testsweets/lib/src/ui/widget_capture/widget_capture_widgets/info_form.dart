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
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  const InfoForm({
    Key? key,
    required this.textEditingController,
    required this.focusNode,
  }) : super(key: key);

  @override
  State<InfoForm> createState() => _InfoFormState();
}

class _InfoFormState extends State<InfoForm> {
  late SolidController solidController;
  @override
  void initState() {
    solidController = SolidController();
    super.initState();
  }

  @override
  void dispose() {
    solidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WidgetCaptureViewModel>();
    final widgetDescription = model.widgetDescription;

    return CustomSolidBottomSheet(
      controller: solidController,
      headerBar: SvgPicture.asset(
        'packages/testsweets/assets/svgs/up_arrow_handle.svg',
      ),
      toggleVisibilityOnTap: true,
      autoSwiped: false,
      canUserSwipe: false,
      minHeight: 0,
      maxHeight: 300,
      onHide: () {
        model.toggleInfoForm(false);
      },
      onShow: () {
        model.toggleInfoForm(true);
      },
      body: widgetDescription == null
          ? const SizedBox.shrink()
          : Container(
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
                    selectedWidgetType: widgetDescription.widgetType,
                    onTap: (widgetType) => model.setWidgetType = widgetType,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Select widget name and visibilty:',
                            textAlign: TextAlign.left, style: tsMedium()),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: TextField(
                                focusNode: widget.focusNode,
                                controller: widget.textEditingController,
                                style:
                                    tsNormal().copyWith(color: kcPrimaryWhite),
                                decoration: InputDecoration(
                                    errorStyle: tsSmall()
                                        .copyWith(color: kcError, height: 0.9),
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
                                        color: kcPrimaryPurple,
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
                                  model.setVisibilty =
                                      !widgetDescription.visibility;
                                },
                                svgIcon: widgetDescription.visibility
                                    ? 'packages/testsweets/assets/svgs/eye.svg'
                                    : 'packages/testsweets/assets/svgs/eye_closed.svg',
                                svgWidth: 30),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CtaButton(
                        isDisabled: widgetDescription.name.isEmpty ||
                            widgetDescription.widgetType == null,
                        onTap: () async {
                          final result = await model.saveWidget();

                          /// When widget is saved successfully hide
                          /// the bottom sheet and clear the text
                          if (result == null) {
                            widget.textEditingController.clear();
                            widget.focusNode.unfocus();
                            solidController.hide();
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
