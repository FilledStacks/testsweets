import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:testsweets/src/services/cloud_functions_service.dart';
import 'package:testsweets/src/services/notification_extractor.dart';
import 'package:testsweets/src/services/reactive_scrollable.dart';
import 'package:testsweets/src/services/scroll_appliance.dart';
import 'package:testsweets/src/services/snackbar_service.dart';
import 'package:testsweets/src/services/test_integrity.dart';
import 'package:testsweets/src/services/testsweets_route_tracker.dart';
import 'package:testsweets/src/services/widget_capture_service.dart';
import 'package:testsweets/src/ui/shared/find_scrollables.dart';

import 'test_consts.dart';
import 'test_helpers.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<SnackbarService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<WidgetCaptureService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<TestSweetsRouteTracker>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<CloudFunctionsService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<TestIntegrity>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<ReactiveScrollable>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<FindScrollables>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<ScrollAppliance>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<NotificationExtractor>(onMissingStub: OnMissingStub.returnDefault),
])
MockWidgetCaptureService getAndRegisterWidgetCaptureService(
    {List<Interaction> viewInteractions = const [],
    Interaction? description,
    String? projectId,
    bool currentViewIsAlreadyCaptured = false}) {
  _removeRegistrationIfExists<WidgetCaptureService>();
  final service = MockWidgetCaptureService();
  when(service.saveInteractionInDatabase(any))
      .thenAnswer((_) => Future.value(kGeneralInteraction));

  when(service.getDescriptionsForView(currentRoute: anyNamed('currentRoute')))
      .thenReturn(viewInteractions);
  when(service.updateInteractionInDatabase(
          updatedInteraction: anyNamed('updatedInteraction'),
          oldInteraction: anyNamed('oldInteraction')))
      .thenAnswer((_) => Future.value());
  when(service.removeInteractionFromDatabase(any))
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

MockTestSweetsRouteTracker getAndRegisterTestSweetsRouteTracker({
  String currentRoute = 'current route',
  String formattedCurrentRoute = 'currentRoute',
}) {
  _removeRegistrationIfExists<TestSweetsRouteTracker>();
  final service = MockTestSweetsRouteTracker();
  when(service.currentRoute).thenReturn(currentRoute);
  when(service.formatedCurrentRoute).thenReturn(formattedCurrentRoute);
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
  when(service.filterAffectedInteractionsByScrollable(any)).thenReturn([]);
  when(service.moveInteractionsWithScrollable(any)).thenReturn([]);
  locator.registerSingleton<ReactiveScrollable>(service);
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

NotificationExtractor getAndRegisterNotificationExtractor(
    {Interaction? interactionAfterSyncInteractionWithScrollable}) {
  _removeRegistrationIfExists<NotificationExtractor>();
  final service = MockNotificationExtractor();

  when(service.syncInteractionWithScrollable(any)).thenAnswer(
      (realInvocation) =>
          interactionAfterSyncInteractionWithScrollable ??
          realInvocation.positionalArguments[0]);
  locator.registerSingleton<NotificationExtractor>(service);
  return service;
}

TestIntegrity getAndRegisterTestIntegrity() {
  _removeRegistrationIfExists<TestIntegrity>();
  final service = MockTestIntegrity();
  locator.registerSingleton<TestIntegrity>(service);
  return service;
}

void registerServices() {
  getAndRegisterTestSweetsRouteTracker();
  getAndRegisterWidgetCaptureService();
  getAndRegisterCloudFunctionsService();
  getAndRegisterSnackbarService();
  getAndRegisterReactiveScrollable();
  getAndRegisterFindScrollables();
  getAndRegisterScrollAppliance();
  getAndRegisterNotificationExtractor();
  getAndRegisterTestIntegrity();
}

void unregisterServices() {
  _removeRegistrationIfExists<TestSweetsRouteTracker>();
  _removeRegistrationIfExists<WidgetCaptureService>();
  _removeRegistrationIfExists<CloudFunctionsService>();
  _removeRegistrationIfExists<SnackbarService>();
  _removeRegistrationIfExists<ReactiveScrollable>();
  _removeRegistrationIfExists<FindScrollables>();
  _removeRegistrationIfExists<ScrollAppliance>();
  _removeRegistrationIfExists<NotificationExtractor>();
  _removeRegistrationIfExists<TestIntegrity>();
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
