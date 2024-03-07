import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/models/interaction.dart';
import 'package:testsweets/src/models/scrollable_description.dart';
import 'package:testsweets/src/services/cloud_functions_service.dart';
import 'package:testsweets/src/services/http_service.dart';
import 'package:testsweets/src/services/notification_extractor.dart';
import 'package:testsweets/src/services/old_http_service.dart';
import 'package:testsweets/src/services/reactive_scrollable.dart';
import 'package:testsweets/src/services/run_configuration_service.dart';
import 'package:testsweets/src/services/scroll_appliance.dart';
import 'package:testsweets/src/services/snackbar_service.dart';
import 'package:testsweets/src/services/test_integrity.dart';
import 'package:testsweets/src/services/testsweets_route_tracker.dart';
import 'package:testsweets/src/services/widget_capture_service.dart';
import 'package:testsweets/src/ui/shared/scrollable_finder.dart';

import 'test_consts.dart';
import 'test_helpers.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<SnackbarService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<WidgetCaptureService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<TestSweetsRouteTracker>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<CloudFunctionsService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<TestIntegrity>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<ReactiveScrollable>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<ScrollableFinder>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<ScrollAppliance>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<NotificationExtractor>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<OldHttpService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<HttpService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<RunConfigurationService>(onMissingStub: OnMissingStub.returnDefault),
])
MockRunConfigurationService getAndRegisterRunConfigurationService({
  bool driveModeActive = false,
}) {
  _removeRegistrationIfExists<RunConfigurationService>();
  final service = MockRunConfigurationService();

  when(service.driveModeActive).thenReturn(driveModeActive);

  locator.registerSingleton<RunConfigurationService>(service);
  return service;
}

MockHttpService getAndRegisterHttpService() {
  _removeRegistrationIfExists<HttpService>();
  final service = MockHttpService();
  locator.registerSingleton<HttpService>(service);
  return service;
}

MockOldHttpService getAndRegisterOldHttpService() {
  _removeRegistrationIfExists<OldHttpService>();
  final service = MockOldHttpService();
  locator.registerSingleton<OldHttpService>(service);
  return service;
}

MockWidgetCaptureService getAndRegisterWidgetCaptureService({
  List<Interaction> viewInteractions = const [],
  Interaction? description,
  String? projectId,
  bool currentViewIsAlreadyCaptured = false,
}) {
  _removeRegistrationIfExists<WidgetCaptureService>();
  final service = MockWidgetCaptureService();

  when(service.saveInteractionInDatabase(any))
      .thenAnswer((_) => Future.value(kGeneralInteraction));

  when(service.getDescriptionsForView(currentRoute: anyNamed('currentRoute')))
      .thenReturn(viewInteractions);

  when(service.updateInteractionInDatabase(
    updatedInteraction: anyNamed('updatedInteraction'),
  )).thenAnswer((_) => Future.value());

  when(service.removeInteractionFromDatabase(any))
      .thenAnswer((_) => Future.value());

  when(service.checkCurrentViewIfAlreadyCaptured(any))
      .thenReturn(currentViewIsAlreadyCaptured);

  when(service.projectId).thenReturn(projectId ?? 'testId');

  locator.registerSingleton<WidgetCaptureService>(service);
  return service;
}

ScrollableFinder getAndRegisterFindScrollables({
  Iterable<ScrollableDescription>? sds,
}) {
  _removeRegistrationIfExists<ScrollableFinder>();
  final service = MockScrollableFinder();
  when(service.getAllScrollableDescriprionsOnScreen()).thenReturn(sds ?? []);
  locator.registerSingleton<ScrollableFinder>(service);
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

  when(service.updateInteraction(
    interaction: anyNamed('interaction'),
    projectId: anyNamed('projectId'),
  )).thenAnswer((realInvocation) => Future.value(updateWidgetDescription));

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
  getAndRegisterOldHttpService();
  getAndRegisterHttpService();
  getAndRegisterRunConfigurationService();
}

void unregisterServices() {
  _removeRegistrationIfExists<TestSweetsRouteTracker>();
  _removeRegistrationIfExists<WidgetCaptureService>();
  _removeRegistrationIfExists<CloudFunctionsService>();
  _removeRegistrationIfExists<SnackbarService>();
  _removeRegistrationIfExists<ReactiveScrollable>();
  _removeRegistrationIfExists<ScrollableFinder>();
  _removeRegistrationIfExists<ScrollAppliance>();
  _removeRegistrationIfExists<NotificationExtractor>();
  _removeRegistrationIfExists<TestIntegrity>();
  _removeRegistrationIfExists<OldHttpService>();
  _removeRegistrationIfExists<HttpService>();
  _removeRegistrationIfExists<RunConfigurationService>();
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
