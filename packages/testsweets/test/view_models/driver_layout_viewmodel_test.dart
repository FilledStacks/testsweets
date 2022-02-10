import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:testsweets/src/services/sweetcore_command.dart';
import 'package:testsweets/src/ui/driver_layout/driver_layout_viewmodel.dart';

import '../helpers/test_consts.dart';
import '../helpers/test_helpers.dart';

void main() {
  group('DriverLayoutViewmodelTest -', () {
    setUp(registerServices);
    tearDown(unregisterServices);

    test(
        'When we recive new notification other than ScrollEndNotification, Should do nothing ',
        () {
      final service = getAndRegisterWidgetVisibiltyChangerService();
      final _model = DriverLayoutViewModel(projectId: 'projectId');

      _model.onClientAppEvent(TestNotification());
      verifyNever(service.execute(testWidgetDescription));
    });
    test(
        'When you don\'t find the widgetName in list of widgetDescriptions, Should do nothing',
        () {
      getAndRegisterWidgetCaptureService();
      final service = getAndRegisterWidgetVisibiltyChangerService(
          latestSweetcoreCommand: ScrollableCommand(widgetName: 'widgetName'));

      verifyNever(service.execute(testWidgetDescription));
    });
    test('''When we recive new notification of type ScrollEndNotification 
        and latestSweetcoreCommand isn\'t null, 
        Should call execute on the WidgetVisibiltyChangerService''', () {
      getAndRegisterWidgetCaptureService(
          listOfWidgetDescription: [testWidgetDescription]);
      final service = getAndRegisterWidgetVisibiltyChangerService(
          latestSweetcoreCommand: ScrollableCommand(widgetName: 'widgetName'));
      final _model = DriverLayoutViewModel(projectId: 'projectId');

      _model.onClientAppEvent(scrollEndNotificationTest);
      verify(service.execute(testWidgetDescription));
    });
    test('''When we call execute on the WidgetVisibiltyChangerService, 
        Should toggle the visibilty of the triggered widget''', () {
      /// [testWidgetDescription] visiblilty is true by default
      getAndRegisterWidgetCaptureService(
          listOfWidgetDescription: [testWidgetDescription]);
      getAndRegisterWidgetVisibiltyChangerService(
          widgetDescription: testWidgetDescription.copyWith(visibility: false),
          latestSweetcoreCommand: ScrollableCommand(widgetName: 'widgetName'));
      final _model = DriverLayoutViewModel(projectId: 'projectId');

      _model.onClientAppEvent(scrollEndNotificationTest);

      /// sence we have just one widget we can do this shortcut
      expect(_model.descriptionsForView.first.visibility, false);
    });
  });
}
