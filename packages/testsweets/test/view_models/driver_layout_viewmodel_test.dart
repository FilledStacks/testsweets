import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
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
        final model = _getModel();
        model.onClientAppEvent(scrollEndNotificationTest);
        expect(service.completer.future, completion(equals('NoTargets')));
      });
      test(
          'When we recive new notification other than ScrollEndNotification, Do nothing ',
          () {
        final service = getAndRegisterWidgetVisibiltyChangerService();
        final model = _getModel();

        model.onClientAppEvent(TestNotification());
        verifyNever(service.toggleVisibilty([kTestWidgetDescription]));
      });
      test(
          'When you don\'t find the widgetName in list of widgetDescriptions, Do nothing',
          () {
        getAndRegisterWidgetCaptureService();
        final service = getAndRegisterWidgetVisibiltyChangerService(
            latestSweetcoreCommand:
                ScrollableCommand(widgetName: 'widgetName'));
        final model = _getModel();
        model.onClientAppEvent(scrollEndNotificationTest);

        verifyNever(service.toggleVisibilty([kTestWidgetDescription]));
      });
      test('''When we recive new notification of type ScrollEndNotification 
        and latestSweetcoreCommand isn\'t null, 
        Should call toggleVisibilty on the WidgetVisibiltyChangerService''',
          () {
        getAndRegisterWidgetCaptureService(listOfWidgetDescription: [
          kWidgetDescription,
          kTestWidgetDescription.copyWith(targetIds: [kWidgetDescription.id!])
        ]);
        final service = getAndRegisterWidgetVisibiltyChangerService(
            widgetDescriptions: [kTestWidgetDescription],
            latestSweetcoreCommand:
                ScrollableCommand(widgetName: 'viewName_general_widgetName'));
        final model = _getModel();

        model.onClientAppEvent(scrollEndNotificationTest);
        verify(service.toggleVisibilty([kWidgetDescription]));
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
      test(
          'When the triggerWidget has no targetIds, Should call completeCompleter',
          () {
        getAndRegisterWidgetCaptureService(listOfWidgetDescription: [
          kWidgetDescription,
          kTestWidgetDescription
        ]);
        final service = getAndRegisterWidgetVisibiltyChangerService(
            widgetDescriptions: [kWidgetDescription],
            latestSweetcoreCommand:
                ScrollableCommand(widgetName: 'viewName_general_widgetName'));
        final model = _getModel();

        model.onClientAppEvent(scrollEndNotificationTest);
        verify(service.completeCompleter('NoTargets'));
      });
    });
    group('updateViewWidgetsList -', () {
      test('''When changing any proberty of some widget, Should be abe to
       replace it in descriptionsForView list''', () {
        getAndRegisterWidgetCaptureService(listOfWidgetDescription: [
          kTestWidgetDescription,
          kWidgetDescription.copyWith(visibility: false)
        ]);
        final model = _getModel();
        model.updateViewWidgetsList(
            [kWidgetDescription.copyWith(visibility: true)]);
        expect(model.descriptionsForView[1],
            kWidgetDescription.copyWith(visibility: true));
      });
    });

    group('filterTargetedWidgets -', () {
      test('When call, Should extract the targeted widgets by id', () {
        getAndRegisterWidgetCaptureService(listOfWidgetDescription: [
          kTestWidgetDescription.copyWith(targetIds: [kWidgetDescription.id!]),
          kWidgetDescription
        ]);
        final model = _getModel();
        final targetedWidgets = model.filterTargetedWidgets(
            kTestWidgetDescription
                .copyWith(targetIds: [kWidgetDescription.id!]));
        expect(targetedWidgets.first, kWidgetDescription);
      });
      test('When targetIds is empty, Should extract the targeted widgets by id',
          () {
        getAndRegisterWidgetCaptureService(listOfWidgetDescription: [
          kTestWidgetDescription,
          kWidgetDescription
        ]);
        final model = _getModel();
        final targetedWidgets =
            model.filterTargetedWidgets(kTestWidgetDescription);
        expect(targetedWidgets, isEmpty);
      });
    });
  });
}
