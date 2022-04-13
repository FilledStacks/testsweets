import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:testsweets/src/services/cloud_functions_service.dart';
import 'package:testsweets/src/services/notification_extractor.dart';
import 'package:testsweets/src/services/reactive_scrollable.dart';
import 'package:testsweets/src/services/scroll_appliance.dart';
import 'package:testsweets/src/services/sweetcore_command.dart';
import 'package:testsweets/src/services/testsweets_route_tracker.dart';
import 'package:testsweets/src/services/widget_capture_service.dart';
import 'package:testsweets/src/services/widget_visibilty_changer_service.dart';
import 'package:testsweets/src/ui/shared/find_scrollables.dart';

import 'test_consts.dart';
import 'test_helpers.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<SnackbarService>(returnNullOnMissingStub: true),
  MockSpec<WidgetCaptureService>(returnNullOnMissingStub: true),
  MockSpec<TestSweetsRouteTracker>(returnNullOnMissingStub: true),
  MockSpec<CloudFunctionsService>(returnNullOnMissingStub: true),
  MockSpec<WidgetVisibiltyChangerService>(returnNullOnMissingStub: true),
  MockSpec<ReactiveScrollable>(returnNullOnMissingStub: true),
  MockSpec<FindScrollables>(returnNullOnMissingStub: true),
  MockSpec<ScrollAppliance>(returnNullOnMissingStub: true),
  MockSpec<NotificationExtractor>(returnNullOnMissingStub: true),
])
MockWidgetCaptureService getAndRegisterWidgetCaptureService(
    {List<Interaction> viewInteractions = const [],
    Interaction? description,
    String? projectId,
    bool currentViewIsAlreadyCaptured = false}) {
  _removeRegistrationIfExists<WidgetCaptureService>();
  final service = MockWidgetCaptureService();
  when(service.saveInteractionInDatabase(any))
      .thenAnswer((_) => Future.value());

  when(service.getDescriptionsForView(currentRoute: anyNamed('currentRoute')))
      .thenReturn(viewInteractions);
  when(service.updateInteractionInDatabase(any))
      .thenAnswer((_) => Future.value());
  when(service.removeInteractionFromDatabase(anyNamed('description')))
      .thenAnswer((_) => Future.value());

  when(service.checkCurrentViewIfAlreadyCaptured(any))
      .thenReturn(currentViewIsAlreadyCaptured);

  locator.registerSingleton<WidgetCaptureService>(service);
  return service;
}

FindScrollables getAndRegisterFindScrollables(
    {Iterable<ScrollableDescription>? sds}) {
  _removeRegistrationIfExists<FindScrollables>();
  final service = MockFindScrollables();
  when(service.convertElementsToScrollDescriptions()).thenReturn(sds ?? []);
  when(service.searchForScrollableElements()).thenReturn(null);
  locator.registerSingleton<FindScrollables>(service);
  return service;
}

MockTestSweetsRouteTracker getAndRegisterTestSweetsRouteTracker(
    {String currentRoute = 'current route',
    bool isChildRouteActivated = true,
    bool isNestedView = true,
    String parentRoute = 'parentRoute'}) {
  _removeRegistrationIfExists<TestSweetsRouteTracker>();
  final service = MockTestSweetsRouteTracker();
  when(service.currentRoute).thenReturn(currentRoute);
  when(service.parentRoute).thenReturn(parentRoute);
  when(service.isChildRouteActivated).thenReturn(isChildRouteActivated);
  when(service.isNestedView).thenReturn(isNestedView);
  locator.registerSingleton<TestSweetsRouteTracker>(service);
  return service;
}

MockCloudFunctionsService getAndRegisterCloudFunctionsService({
  String getV4BuildUploadSignedUrlResult = '',
  bool doesBuildExistInProjectResult = true,
  String addWidgetDescriptionToProjectResult = 'default_id',
  String updateWidgetDescription = 'default_id',
  String deleteWidgetDescription = 'default_id',
  List<Interaction> getWidgetDescriptionForProjectResult = const [],
}) {
  _removeRegistrationIfExists<CloudFunctionsService>();
  final service = MockCloudFunctionsService();

  when(service.getV4BuildUploadSignedUrl(
    any,
    any,
    any,
  )).thenAnswer((_) async => getV4BuildUploadSignedUrlResult);

  when(service.doesBuildExistInProject(any,
          withVersion: anyNamed('withVersion')))
      .thenAnswer((invocation) async => doesBuildExistInProjectResult);

  when(service.uploadWidgetDescriptionToProject(
          projectId: anyNamed('projectId'),
          description: anyNamed('description')))
      .thenAnswer((realInvocation) =>
          Future.value(addWidgetDescriptionToProjectResult));

  when(service.getWidgetDescriptionForProject(projectId: anyNamed('projectId')))
      .thenAnswer((realInvocation) =>
          Future.value(getWidgetDescriptionForProjectResult));

  when(service.deleteWidgetDescription(
          projectId: anyNamed('projectId'),
          description: anyNamed('description')))
      .thenAnswer((realInvocation) => Future.value(deleteWidgetDescription));

  when(service.updateWidgetDescription(
          oldwidgetDescription: anyNamed('oldwidgetDescription'),
          projectId: anyNamed('projectId'),
          newwidgetDescription: anyNamed('newwidgetDescription')))
      .thenAnswer((realInvocation) => Future.value(updateWidgetDescription));

  locator.registerSingleton<CloudFunctionsService>(service);
  return service;
}

SnackbarService getAndRegisterSnackbarService() {
  _removeRegistrationIfExists<SnackbarService>();
  final service = MockSnackbarService();
  when(service.showCustomSnackBar(
          message: anyNamed('message'), variant: anyNamed('variant')))
      .thenAnswer((_) => Future.value());
  locator.registerSingleton<SnackbarService>(service);
  return service;
}

ReactiveScrollable getAndRegisterReactiveScrollable() {
  _removeRegistrationIfExists<ReactiveScrollable>();
  final service = MockReactiveScrollable();

  locator.registerSingleton<ReactiveScrollable>(service);
  return service;
}

WidgetVisibiltyChangerService getAndRegisterWidgetVisibiltyChangerService(
    {List<Interaction>? widgetDescriptions,
    SweetcoreCommand? latestSweetcoreCommand}) {
  _removeRegistrationIfExists<WidgetVisibiltyChangerService>();
  final service = MockWidgetVisibiltyChangerService();
  when(service.runToggleVisibiltyChecker(any, any, any))
      .thenReturn(widgetDescriptions);
  when(service.toggleVisibilty(any, any)).thenReturn(widgetDescriptions ?? []);
  when(service.completeCompleter(any)).thenReturn(true);
  when(service.sweetcoreCommand).thenReturn(latestSweetcoreCommand);
  locator.registerSingleton<WidgetVisibiltyChangerService>(service);
  return service;
}

ScrollAppliance getAndRegisterScrollAppliance() {
  _removeRegistrationIfExists<ScrollAppliance>();
  final service = MockScrollAppliance();

  when(service.applyScrollableOnInteraction(any, any)).thenAnswer(
    (invocation) =>
        invocation.positionalArguments[1], // return the same interaction
  );
  locator.registerSingleton<ScrollAppliance>(service);
  return service;
}

NotificationExtractor getAndRegisterNotificationExtractor() {
  _removeRegistrationIfExists<NotificationExtractor>();
  final service = MockNotificationExtractor();

  locator.registerSingleton<NotificationExtractor>(service);
  return service;
}

void registerServices() {
  getAndRegisterTestSweetsRouteTracker();
  getAndRegisterWidgetCaptureService();
  getAndRegisterCloudFunctionsService();
  getAndRegisterSnackbarService();
  getAndRegisterWidgetVisibiltyChangerService();
  getAndRegisterReactiveScrollable();
  getAndRegisterFindScrollables();
  getAndRegisterScrollAppliance();
  getAndRegisterNotificationExtractor();
}

void unregisterServices() {
  _removeRegistrationIfExists<TestSweetsRouteTracker>();
  _removeRegistrationIfExists<WidgetCaptureService>();
  _removeRegistrationIfExists<CloudFunctionsService>();
  _removeRegistrationIfExists<SnackbarService>();
  _removeRegistrationIfExists<WidgetVisibiltyChangerService>();
  _removeRegistrationIfExists<ReactiveScrollable>();
  _removeRegistrationIfExists<FindScrollables>();
  _removeRegistrationIfExists<ScrollAppliance>();
  _removeRegistrationIfExists<NotificationExtractor>();
}

T registerServiceInsteadOfMockedOne<T extends Object>(T instance) {
  _removeRegistrationIfExists<T>();
  locator.registerSingleton<T>(instance);
  return instance;
}

// Call this before any service registration helper. This is to ensure that if there
// is a service registered we remove it first. We register all services to remove boiler plate from tests
void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}

class TestNotification extends Notification {}

class MockBuildContext extends Mock implements BuildContext {}
