// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String WidgetNameValueKey = 'widgetName';

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
  }
}

extension ValueProperties on FormViewModel {
  String? get widgetNameValue => this.formValueMap[WidgetNameValueKey];

  bool get hasWidgetName => this.formValueMap.containsKey(WidgetNameValueKey);
}

extension Methods on FormViewModel {}
