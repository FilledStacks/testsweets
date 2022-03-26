import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:testsweets/src/enums/handler_message_response.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/services/sweetcore_command.dart';
import 'package:testsweets/src/services/widget_visibilty_changer_service.dart';
import 'package:testsweets/src/ui/driver_layout/driver_layout_viewmodel.dart';

import '../helpers/test_consts.dart';
import '../helpers/test_helpers.dart';

DriverLayoutViewModel _getModel() =>
    DriverLayoutViewModel(projectId: 'projectId');

void main() {
  group('DriverLayoutViewmodelTest -', () {
    setUp(registerServices);
    tearDown(unregisterServices);
  });
}
