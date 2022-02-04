import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/src/provider.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'package:testsweets/src/extensions/capture_widget_status_enum_extension.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';
import 'package:testsweets/src/ui/shared/cta_button.dart';
import 'package:testsweets/src/ui/shared/custom_solid_controller.dart';
import 'package:testsweets/src/ui/shared/icon_button.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';
import 'package:testsweets/src/ui/shared/widgets_visualizer.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_viewmodel.dart';
import 'package:testsweets/src/ui/shared/animation_rotation.dart' as ar;
import 'type_selector.dart';

class WidgetForm extends StatefulWidget {
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  const WidgetForm({
    Key? key,
    required this.textEditingController,
    required this.focusNode,
  }) : super(key: key);

  @override
  State<WidgetForm> createState() => _WidgetFormState();
}

class _WidgetFormState extends State<WidgetForm> {
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

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        if (model.captureWidgetStatusEnum.idleMode)
          WidgetsVisualizer(onEdit: () {
            /// Set the value of the edited widget to the form textfield
            /// and show the bottomsheet
            widget.textEditingController.text = model.widgetDescription!.name;
            solidController.show();
          }),
        CustomSolidBottomSheet(
          controller: solidController,
          // Close the keyboard when you hide the bottomsheet
          onHide: widget.focusNode.unfocus,
          onShow: model.showWidgetForm,
          headerBar: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SvgPicture.asset(
                'packages/testsweets/assets/svgs/eclipse.svg',
              ),
              StreamBuilder<bool>(
                  stream: solidController.isOpenStream,
                  builder: (context, snapshot) {
                    return ar.AnimatedRotation(
                      duration: const Duration(milliseconds: 350),
                      angle: snapshot.data ?? false ? 180 : 0,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SvgPicture.asset(
                          'packages/testsweets/assets/svgs/arrow_up.svg',
                        ),
                      ),
                    );
                  }),
            ],
          ),

          toggleVisibilityOnTap: true,
          autoSwiped: false,
          canUserSwipe: false,
          minHeight: 0,
          maxHeight: 300,
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
                                  child: TextFormField(
                                    focusNode: widget.focusNode,
                                    controller: widget.textEditingController,
                                    style: tsNormal()
                                        .copyWith(color: kcPrimaryWhite),
                                    decoration: InputDecoration(
                                        hintStyle: tsNormal().copyWith(
                                          color: kcSubtext,
                                        ),
                                        fillColor: kcTextField,
                                        filled: true,
                                        hintText: 'Widget Name',
                                        contentPadding: const EdgeInsets.only(
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
                                            color: kcCard,
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
                                    backgroundColor: kcCard,
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
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: CtaButton(
                                  isDisabled: widgetDescription.name.isEmpty ||
                                      widgetDescription.widgetType == null,
                                  onTap: () async {
                                    final result = await model.submitForm();

                                    /// When widget is saved successfully hide
                                    /// the bottom sheet and clear the text
                                    if (result == null) {
                                      await closeBottomSheet();
                                    }
                                  },
                                  fillColor: kcPrimaryPurple,
                                  title: widgetDescription.id != null
                                      ? 'Update'
                                      : 'Create'),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              flex: 2,
                              child: CtaButton(
                                  onTap: () async {
                                    await closeBottomSheet();
                                    model.clearWidgetDescriptionForm();
                                  },
                                  fillColor: kcError,
                                  title: 'Clear'),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ],
    );
  }

  Future<void> closeBottomSheet() async {
    widget.textEditingController.clear();
    widget.focusNode.unfocus();
    solidController.hide();
    await Future.delayed(const Duration(milliseconds: 350));
  }
}
