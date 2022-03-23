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
      test('''When the sweetcoreCommand is null, Should return without calling
          WidgetVisibiltyChangerService''', () {
        final service = getAndRegisterWidgetVisibiltyChangerService();
        final model = _getModel();
        model.onClientAppEvent(kScrollEndNotification);
        verifyNever(service.toggleVisibilty([], []));
        verifyNever(service.completeCompleter(
            HandlerMessageResponse.couldnotFindAutomationKey));
      });
      test('''
      When we get a ScrollableCommand message
      from the flutter driver `handler` 
      and an `ScrollEndNotification` is triggered
      and the trigger widget has no targets, 
      Should complete the completer with foundAutomationKeyWithNoTargets
      ''', () async {
        getAndRegisterWidgetCaptureService(viewInteractions: [
          kGeneralInteractionWithZeroOffset,
          kGeneralInteraction
        ]);

        /// Unregister the mocked service and register our instance
        locator.unregister<WidgetVisibiltyChangerService>();
        final service = WidgetVisibiltyChangerService();
        locator.registerSingleton<WidgetVisibiltyChangerService>(service);

        service.sweetcoreCommand =
            ScrollableCommand(widgetName: kGeneralInteraction.automationKey);
        service.completer = Completer();
        expect(
            service.completer!.future,
            completion(equals(
                HandlerMessageResponse.foundAutomationKeyWithNoTargets.name)));
        final model = _getModel();
        await model.initialise();
        model.onClientAppEvent(kScrollEndNotification);
      });
      test(
          'When we recive new notification other than ScrollEndNotification, Do nothing ',
          () {
        final service = getAndRegisterWidgetVisibiltyChangerService();
        final model = _getModel();

        model.onClientAppEvent(TestNotification());
        verifyNever(service.runToggleVisibiltyChecker(
            TestNotification(), '', [kGeneralInteractionWithZeroOffset]));
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
        model.onClientAppEvent(kScrollEndNotification);
        verify(service.completeCompleter(
            HandlerMessageResponse.couldnotFindAutomationKey));
        verifyNever(service.runToggleVisibiltyChecker(
            TestNotification(), '', [kGeneralInteractionWithZeroOffset]));
      });
      test('''When we recive new notification of type ScrollEndNotification
        and latestSweetcoreCommand isn\'t null and automationKey is exist,
        Should call runToggleVisibiltyChecker on the WidgetVisibiltyChangerService''',
          () async {
        getAndRegisterWidgetCaptureService(viewInteractions: [
          kGeneralInteraction,
        ]);
        final service = getAndRegisterWidgetVisibiltyChangerService(
            widgetDescriptions: [kGeneralInteraction],
            latestSweetcoreCommand: ScrollableCommand(
                widgetName: kGeneralInteraction.automationKey));
        service.completer = Completer();

        final model = _getModel();
        await model.initialise();
        model.onClientAppEvent(kScrollEndNotification);
        verify(service.runToggleVisibiltyChecker(
            kScrollEndNotification, kGeneralInteraction.automationKey, [
          kGeneralInteraction,
        ]));
      });
      test('''When we call toggleVisibilty on the WidgetVisibiltyChangerService,
        Should toggle the visibilty of the triggered widgets''', () async {
        /// [testWidgetDescription] visiblilty is true by default
        getAndRegisterWidgetCaptureService(
            viewInteractions: [kGeneralInteractionWithZeroOffset]);
        getAndRegisterWidgetVisibiltyChangerService(widgetDescriptions: [
          kGeneralInteractionWithZeroOffset.copyWith(visibility: false)
        ], latestSweetcoreCommand: ScrollableCommand(widgetName: 'widgetName'));
        final model = _getModel();
        await model.initialise();
        model.onClientAppEvent(kScrollEndNotification);
        await model.initialise();

        /// sence we have just one widget we can do this shortcut
        expect(model.descriptionsForView.first.visibility, true);
      });
      test('''When the triggerWidget has no targetIds, Should do nothing''',
          () {
        getAndRegisterWidgetCaptureService(viewInteractions: [
          kGeneralInteraction,
          kGeneralInteractionWithZeroOffset
        ]);
        getAndRegisterWidgetVisibiltyChangerService(
            latestSweetcoreCommand:
                ScrollableCommand(widgetName: 'viewName_general_widgetName'));
        final model = _getModel();
        final before = model.descriptionsForView;
        model.onClientAppEvent(kScrollEndNotification);
        final after = model.descriptionsForView;

        expect(before, after);
      });
    });
  });
}
