// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String WidgetNameValueKey = 'widgetName';
const String VisibleValueKey = 'visible';

mixin $WidgetCaptureView on StatelessWidget {
  final TextEditingController widgetNameController = TextEditingController();
  final FocusNode widgetNameFocusNode = FocusNode();

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    widgetNameController.addListener(() => _updateFormData(model));
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model) => model.setData(
        model.formValueMap
          ..addAll({
            WidgetNameValueKey: widgetNameController.text,
          }),
      );

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    widgetNameController.dispose();
    widgetNameFocusNode.dispose();
  }
}

extension ValueProperties on FormViewModel {
  String? get widgetNameValue => this.formValueMap[WidgetNameValueKey];
  DateTime? get visibleValue => this.formValueMap[VisibleValueKey];

  bool get hasWidgetName => this.formValueMap.containsKey(WidgetNameValueKey);
  bool get hasVisible => this.formValueMap.containsKey(VisibleValueKey);
}

extension Methods on FormViewModel {
  Future<void> selectVisible(
      {required BuildContext context,
      required DateTime initialDate,
      required DateTime firstDate,
      required DateTime lastDate}) async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate);
    if (selectedDate != null) {
      this.setData(this.formValueMap..addAll({VisibleValueKey: selectedDate}));
    }
  }
}
