import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'package:testsweets/src/extensions/capture_widget_status_enum_extension.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/models/interaction.dart';
import 'package:testsweets/src/ui/shared/app_colors.dart';
import 'package:testsweets/src/ui/shared/cta_button.dart';
import 'package:testsweets/src/ui/shared/custom_solid_controller.dart';
import 'package:testsweets/src/ui/shared/icon_button.dart';
import 'package:testsweets/src/ui/shared/scrollable_finder.dart';
import 'package:testsweets/src/ui/shared/shared_styles.dart';
import 'package:testsweets/src/ui/widget_capture/widget_capture_viewmodel.dart';

import 'form_header.dart';
import 'interaction_capture_form.dart';
import 'interactions_visualizer_capture_mode.dart';
import 'type_selector.dart';

class InteractionFormAndVisualizer extends StatefulWidget {
  const InteractionFormAndVisualizer({
    Key? key,
  }) : super(key: key);

  @override
  State<InteractionFormAndVisualizer> createState() =>
      _InteractionFormAndVisualizerState();
}

class _InteractionFormAndVisualizerState
    extends State<InteractionFormAndVisualizer> with InteractionCaptureForm {
  late SolidController bottomSheetController;
  @override
  void initState() {
    bottomSheetController = SolidController();
    final model = context.read<WidgetCaptureViewModel>();
    listenToFormUpdated(model);
    super.initState();
  }

  @override
  void dispose() {
    bottomSheetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WidgetCaptureViewModel>();
    final interaction = model.inProgressInteraction;
    final size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        if (model.captureState.showWidgets && model.showInteractionPonts)
          InteractionsVisualizerCaptureMode(
            captureWidgetState: model.captureState,
            descriptionsForViewNotifier: model.interactionsForViewNotifier,
            editActionSelected: () {
              /// Set the value of the edited interaction to the
              /// form textfield and show the bottomsheet.
              widgetNameController.text = model.inProgressInteraction!.name;
              bottomSheetController.show();
            },
          ),
        if (model.captureState.showWidgetForm)
          SafeArea(
            child: Container(
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              width: size.width > 500 ? 500 : size.width,
              child: CustomSolidBottomSheet(
                controller: bottomSheetController,
                // Closes the keyboard when you hide the bottomsheet
                onHide: widgetNameFocusNode.unfocus,
                onShow: model.showWidgetForm,
                headerBar: FormHeader(
                  openBottomSheet: bottomSheetController.isOpenStream,
                ),
                minHeight: 0,
                maxHeight: 300,
                body: Container(
                  decoration: kdBlackRoundedEdgeDecoration,
                  child: _Content(
                    interaction: interaction,
                    bottomSheetController: bottomSheetController,
                    widgetNameController: widgetNameController,
                    widgetNameFocusNode: widgetNameFocusNode,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final Interaction? interaction;
  final FocusNode widgetNameFocusNode;
  final TextEditingController widgetNameController;
  final SolidController bottomSheetController;
  const _Content({
    Key? key,
    this.interaction,
    required this.widgetNameFocusNode,
    required this.widgetNameController,
    required this.bottomSheetController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WidgetCaptureViewModel>();

    return ListView(
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text('Select widget type:',
              textAlign: TextAlign.left, style: tsMedium()),
        ),
        TypeSelector(
          selectedWidgetType: model.inProgressInteraction?.widgetType,
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
                      focusNode: widgetNameFocusNode,
                      controller: widgetNameController,
                      style: tsNormal().copyWith(color: kcPrimaryWhite),
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      ],
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
                      model.setVisibilty = !model.showInteractionPonts;
                    },
                    svgIcon: model.showInteractionPonts
                        ? 'packages/testsweets/assets/svgs/eye.svg'
                        : 'packages/testsweets/assets/svgs/eye_closed.svg',
                    svgWidth: 30,
                  ),
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
                    isDisabled: interaction?.name.isEmpty ?? true,
                    onTap: () async {
                      await _closeBottomSheet();

                      /// Give a delay to prevent the [searchForScrollableElements]
                      /// form accedintally capturing any list in the bottomsheet
                      await Future.delayed(const Duration(milliseconds: 500));

                      final findScrollablesService =
                          locator<ScrollableFinder>();

                      final extractedScrollables = findScrollablesService
                          .getAllScrollableDescriprionsOnScreen();

                      print(
                          '🚗 - extractedScrollables: ${extractedScrollables.length}');

                      model.checkForExternalities(extractedScrollables);

                      await model.submitForm();
                      _clearAndUnfocusTextField();
                    },
                    fillColor: kcPrimaryPurple,
                    title: interaction == null
                        ? 'Select Type'
                        : interaction?.id != null
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
                      _clearAndUnfocusTextField();
                      model.clearWidgetDescriptionForm();
                    },
                    fillColor: kcError,
                    title: 'Clear'),
              ),
            ],
          ),
        )
      ],
    );
  }

  Future<void> _closeBottomSheet() async {
    bottomSheetController.hide();
  }

  void _clearAndUnfocusTextField() {
    widgetNameController.clear();
    widgetNameFocusNode.unfocus();
  }
}
