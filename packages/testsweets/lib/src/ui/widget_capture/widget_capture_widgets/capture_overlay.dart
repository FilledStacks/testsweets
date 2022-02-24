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
import 'package:testsweets/src/ui/widget_capture/widget_capture_widgets/widgets_visualizer.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_viewmodel.dart';
import '../widget_capture_view.form.dart';
import 'draggable_widget.dart';
import 'form_header.dart';
import 'type_selector.dart';

class CaptureOverlay extends StatefulWidget {
  const CaptureOverlay({
    Key? key,
  }) : super(key: key);

  @override
  State<CaptureOverlay> createState() => _CaptureOverlayState();
}

class _CaptureOverlayState extends State<CaptureOverlay>
    with $WidgetCaptureView {
  late SolidController solidController;
  @override
  void initState() {
    solidController = SolidController();
    final model = context.read<WidgetCaptureViewModel>();
    listenToFormUpdated(model);
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
    final size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        WidgetsVisualizer(editActionSelected: () {
          /// Set the value of the edited widget to the form textfield
          /// and show the bottomsheet
          widgetNameController.text = model.widgetDescription!.name;
          solidController.show();
        }),
        if (model.captureWidgetStatusEnum.showWidgetForm)
          Container(
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            width: size.width > 500 ? 500 : size.width,
            child: CustomSolidBottomSheet(
              controller: solidController,
              // Close the keyboard when you hide the bottomsheet
              onHide: widgetNameFocusNode.unfocus,
              onShow: model.showWidgetForm,
              headerBar: FormHeader(
                openStream: solidController.isOpenStream,
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
                            onTap: (widgetType) =>
                                model.setWidgetType = widgetType,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Select widget name and visibilty:',
                                    textAlign: TextAlign.left,
                                    style: tsMedium()),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        focusNode: widgetNameFocusNode,
                                        controller: widgetNameController,
                                        style: tsNormal()
                                            .copyWith(color: kcPrimaryWhite),
                                        decoration: InputDecoration(
                                            hintStyle: tsNormal().copyWith(
                                              color: kcSubtext,
                                            ),
                                            fillColor: kcTextField,
                                            filled: true,
                                            hintText: 'Widget Name',
                                            contentPadding:
                                                const EdgeInsets.only(
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
                                      isDisabled: widgetDescription
                                              .name.isEmpty ||
                                          widgetDescription.widgetType == null,
                                      onTap: () async {
                                        final result = await model.submitForm();

                                        /// When widget is saved successfully hide
                                        /// the bottom sheet and clear the text
                                        if (result == null) {
                                          await _closeBottomSheet();
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
                                        await _closeBottomSheet();
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
          ),
      ],
    );
  }

  Future<void> _closeBottomSheet() async {
    widgetNameController.clear();
    widgetNameFocusNode.unfocus();
    solidController.hide();
    await Future.delayed(const Duration(milliseconds: 350));
  }
}
