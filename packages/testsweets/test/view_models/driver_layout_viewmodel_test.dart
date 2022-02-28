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

    group('onClientAppEvent -', () {
      test('When the latestSweetcoreCommand is null, Should return null', () {
        final service = getAndRegisterWidgetVisibiltyChangerService();
        final model = _getModel();
        service.sweetcoreCommand = null;
        expect(model.onClientAppEvent(TestNotification()), false);
      });
      test('''
      When we get a ScrollableCommand message
      from the flutter driver `handler` 
      and an `ScrollEndNotification` is triggered
      and the trigger widget has no targets, 
      Should complete the completer with NoTargets
      ''', () async {
        getAndRegisterWidgetCaptureService(listOfWidgetDescription: [
          kTestWidgetDescription,
          kWidgetDescription
        ]);

        /// Unregister the mocked service and register our instance
        locator.unregister<WidgetVisibiltyChangerService>();
        final service = WidgetVisibiltyChangerService();
        locator.registerSingleton<WidgetVisibiltyChangerService>(service);

        service.sweetcoreCommand =
            ScrollableCommand(widgetName: kWidgetDescription.automationKey);
        service.completer = Completer();
        expect(
            service.completer!.future,
            completion(equals(
                HandlerMessageResponse.foundAutomationKeyWithNoTargets.name)));
        final model = _getModel();
        model.onClientAppEvent(scrollEndNotificationTest);
      });
      test(
          'When we recive new notification other than ScrollEndNotification, Do nothing ',
          () {
        final service = getAndRegisterWidgetVisibiltyChangerService();
        final model = _getModel();

        model.onClientAppEvent(TestNotification());
        verifyNever(service.runToggleVisibiltyChecker(
            TestNotification(), '', [kTestWidgetDescription]));
      });
      test(
          'When you don\'t find the widgetName in list of widgetDescriptions, Do nothing',
          () {
        getAndRegisterWidgetCaptureService();
        final service = getAndRegisterWidgetVisibiltyChangerService(
            latestSweetcoreCommand:
                ScrollableCommand(widgetName: 'widgetName'));
        service.completer = Completer();

        final model = _getModel();
        model.onClientAppEvent(scrollEndNotificationTest);
        verify(service.completeCompleter(
            HandlerMessageResponse.couldnotFindAutomationKey));
        verifyNever(service.runToggleVisibiltyChecker(
            TestNotification(), '', [kTestWidgetDescription]));
      });
      test('''When we recive new notification of type ScrollEndNotification 
        and latestSweetcoreCommand isn\'t null and automationKey is exist, 
        Should call runToggleVisibiltyChecker on the WidgetVisibiltyChangerService''',
          () {
        getAndRegisterWidgetCaptureService(listOfWidgetDescription: [
          kWidgetDescription,
        ]);
        final service = getAndRegisterWidgetVisibiltyChangerService(
            widgetDescriptions: [kWidgetDescription],
            latestSweetcoreCommand: ScrollableCommand(
                widgetName: kWidgetDescription.automationKey));
        service.completer = Completer();

        final model = _getModel();

        model.onClientAppEvent(scrollEndNotificationTest);
        verify(service.runToggleVisibiltyChecker(
            scrollEndNotificationTest, kWidgetDescription.automationKey, [
          kWidgetDescription,
        ]));
      });
      test(
          '''When we call toggleVisibilty on the WidgetVisibiltyChangerService, 
        Should toggle the visibilty of the triggered widgets''', () {
        /// [testWidgetDescription] visiblilty is true by default
        getAndRegisterWidgetCaptureService(
            listOfWidgetDescription: [kTestWidgetDescription]);
        getAndRegisterWidgetVisibiltyChangerService(widgetDescriptions: [
          kTestWidgetDescription.copyWith(visibility: false)
        ], latestSweetcoreCommand: ScrollableCommand(widgetName: 'widgetName'));
        final model = _getModel();

        model.onClientAppEvent(scrollEndNotificationTest);

        /// sence we have just one widget we can do this shortcut
        expect(model.descriptionsForView.first.visibility, true);
      });
      test('''When the triggerWidget has no targetIds, Should do nothing''',
          () {
        getAndRegisterWidgetCaptureService(listOfWidgetDescription: [
          kWidgetDescription,
          kTestWidgetDescription
        ]);
        getAndRegisterWidgetVisibiltyChangerService(
            latestSweetcoreCommand:
                ScrollableCommand(widgetName: 'viewName_general_widgetName'));
        final model = _getModel();
        final before = model.descriptionsForView;
        model.onClientAppEvent(scrollEndNotificationTest);
        final after = model.descriptionsForView;

        expect(before, after);
      });
    });
  });
}
