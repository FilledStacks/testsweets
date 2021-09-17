import 'package:testsweets/src/models/application_models.dart';

abstract class ValidateDescriptionService {
  bool isValid(WidgetDescription widgetDescription);
  WidgetDescription encodeValidation(WidgetDescription widgetDescription);
  WidgetDescription decodeValidation(WidgetDescription widgetDescription);
}

class ValidateDescriptionImplementation implements ValidateDescriptionService {
  @override
  WidgetDescription decodeValidation(WidgetDescription widgetDescription) {
    // TODO: implement decodeValidation
    throw UnimplementedError();
  }

  @override
  WidgetDescription encodeValidation(WidgetDescription widgetDescription) {
    // TODO: implement encodeValidation
    throw UnimplementedError();
  }

  @override
  bool isValid(WidgetDescription widgetDescription) {
    // TODO: implement validate
    throw UnimplementedError();
  }
}
