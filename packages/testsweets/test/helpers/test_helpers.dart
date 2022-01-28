import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:testsweets/src/locator.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:testsweets/src/services/cloud_functions_service.dart';
import 'package:testsweets/src/services/sweetcore_command.dart';
import 'package:testsweets/src/services/testsweets_route_tracker.dart';
import 'package:testsweets/src/services/widget_capture_service.dart';
import 'package:testsweets/src/services/widget_visibilty_changer_service.dart';

import 'test_helpers.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<WidgetCaptureService>(returnNullOnMissingStub: true),
  MockSpec<TestSweetsRouteTracker>(returnNullOnMissingStub: true),
  MockSpec<CloudFunctionsService>(returnNullOnMissingStub: true),
  MockSpec<WidgetVisibiltyChangerService>(returnNullOnMissingStub: true),
])
MockWidgetCaptureService getAndRegisterWidgetCaptureService(
    {List<WidgetDescription> listOfWidgetDescription = const [],
    WidgetDescription? description,
    String? projectId,
    bool currentViewIsAlreadyCaptured = false}) {
  _removeRegistrationIfExists<WidgetCaptureService>();
  final service = MockWidgetCaptureService();

  when(service.captureWidgetDescription(
          description: anyNamed('description'),
          projectId: anyNamed('projectId')))
      .thenAnswer((realInvocation) => Future.value());

  when(service.getDescriptionsForView(currentRoute: anyNamed('currentRoute')))
      .thenReturn(listOfWidgetDescription);
  when(service.updateWidgetDescription(
          projectId: anyNamed('projectId'),
          description: anyNamed('description')))
      .thenAnswer((_) => Future.value());

  when(service.checkCurrentViewIfAlreadyCaptured(any))
      .thenReturn(currentViewIsAlreadyCaptured);

  locator.registerSingleton<WidgetCaptureService>(service);
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
  List<WidgetDescription> getWidgetDescriptionForProjectResult = const [],
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

WidgetVisibiltyChangerService getAndRegisterWidgetVisibiltyChangerService(
    {WidgetDescription? widgetDescription,
    SweetcoreCommand? latestSweetcoreCommand}) {
  _removeRegistrationIfExists<WidgetVisibiltyChangerService>();
  final service = MockWidgetVisibiltyChangerService();
  when(service.execute(any)).thenReturn(widgetDescription);
  when(service.latestSweetcoreCommand).thenReturn(latestSweetcoreCommand);
  locator.registerSingleton<WidgetVisibiltyChangerService>(service);
  return service;
}

void registerServices() {
  getAndRegisterTestSweetsRouteTracker();
  getAndRegisterWidgetCaptureService();
  getAndRegisterCloudFunctionsService();
  getAndRegisterWidgetVisibiltyChangerService();
}

void unregisterServices() {
  _removeRegistrationIfExists<TestSweetsRouteTracker>();
  _removeRegistrationIfExists<WidgetCaptureService>();
  _removeRegistrationIfExists<CloudFunctionsService>();
  _removeRegistrationIfExists<WidgetVisibiltyChangerService>();
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
