import 'package:testsweets/src/enums/widget_type.dart';
import 'package:testsweets/src/models/application_models.dart';
import 'package:flutter/material.dart';
import 'package:testsweets/src/models/build_info.dart';
import 'package:testsweets/testsweets.dart';

import 'test_helpers.dart';

const String ksPubspecFileWithNoVersion = """
name: myApp

environment:
  sdk: ">=2.7.0 <3.0.0"
""";

const String ksPubspecFileWithVersion = """
name: myApp

version: 0.1.1

environment:
  sdk: ">=2.7.0 <3.0.0"
""";

const String appAutomationKeysFile = """
[
  "home_general_guestDialog",
  "home_touchable_email",
  "home_touchable_google"
]
""";
const String emptyAppAutomationKeysFile = """
[

]
""";

const String testDirectoryPath = 'myApp';

const testsweetFileContentRaw = """
  projectId=3OezzTovG9xFTE5Xw2w1
  apiKey=e3747a0e-8449-42ec-b50f-748d80c3f52e
  flutterBuildCommand=--debug -t lib/main_profile.dart""";
const testsweetFileContent = [
  "projectId=3OezzTovG9xFTE5Xw2w1",
  "apiKey=e3747a0e-8449-42ec-b50f-748d80c3f52e",
  "flutterBuildCommand=--debug -t lib/main_profile.dart",
];
const testsweetFileContentListOfMapEntries = [
  MapEntry("projectId", "3OezzTovG9xFTE5Xw2w1"),
  MapEntry("apiKey", "e3747a0e-8449-42ec-b50f-748d80c3f52e"),
  MapEntry("flutterBuildCommand", "--debug -t lib/main_profile.dart")
];
const String testPathToBuild = 'abc';
final BuildInfo testBuildInfo = BuildInfo(
  pathToBuild: 'abc.apk',
  buildMode: 'profile',
  appType: testAppType,
  version: '0.1.1',
);
const String testAppType = 'apk';
const List<String> testExtraArgs = ['--profile'];
const List<String> testExtraFlutterProcessArgsWithDebug = [
  '--debug -t lib/main_profile.dart'
];
const List<String> testAutomationKeys = [
  "home_general_guestDialog",
  "home_touchable_email",
  "home_touchable_google"
];
const List<String> testDynamicAutomationKeys = ['orders_touchable_ready'];
const int testContentLength = 2;
final testDataStream = Stream.value([1, 2, 3]);
final testDateTime = DateTime.utc(1993, 12, 12, 12);

final kGeneralInteractionWithZeroOffset = Interaction(
    id: 'testWidgetDescriptionId',
    viewName: 'viewName',
    originalViewName: 'originalViewName',
    name: 'widgetName',
    widgetType: WidgetType.general,
    position: WidgetPosition.empty());
final kGeneralInteraction = Interaction(
  originalViewName: '/',
  viewName: 'login',
  id: 'id',
  name: 'email',
  position: WidgetPosition(
      x: 100, y: 199, capturedDeviceWidth: 0, capturedDeviceHeight: 0),
  widgetType: WidgetType.general,
);
final kScrollableInteraction = Interaction(
  originalViewName: '/',
  viewName: 'initial',
  id: 'kWidgetDescriptionTypeScrollId1',
  name: 'ScrollId1',
  position: WidgetPosition(
      x: 20, y: 20, capturedDeviceWidth: 0, capturedDeviceHeight: 0),
  widgetType: WidgetType.scrollable,
);
final kScrollableInteraction2 = Interaction(
  originalViewName: '/',
  viewName: 'initial',
  id: 'kWidgetDescriptionTypeScroll2',
  name: 'ScrollId2',
  position: WidgetPosition(
      x: 25, y: 25, capturedDeviceWidth: 0, capturedDeviceHeight: 0),
  widgetType: WidgetType.scrollable,
);
final kViewInteraction = Interaction(
  originalViewName: '/',
  viewName: 'login',
  id: 'viewId',
  name: '',
  position: WidgetPosition.empty(),
  widgetType: WidgetType.view,
);

final kScrollEndNotification = ScrollEndNotification(
    metrics: FixedScrollMetrics(
        minScrollExtent: 50,
        maxScrollExtent: 100,
        pixels: 50,
        viewportDimension: 33,
        axisDirection: AxisDirection.right),
    context: MockBuildContext());

final kTopLeftVerticalScrollableDescription = ScrollableDescription(
    localOffset: Offset.zero,
    axis: Axis.vertical,
    maxScrollExtent: 0,
    scrollExtentByPixels: 100,
    scrollableWidgetRect:
        SerializableRect.fromPoints(Offset(0, 0), Offset(22, 22)));
final kTopLeftHorizontalScrollableDescription = ScrollableDescription(
    localOffset: Offset.zero,
    axis: Axis.horizontal,
    maxScrollExtent: 0,
    scrollExtentByPixels: 50,
    scrollableWidgetRect:
        SerializableRect.fromPoints(Offset(0, 20), Offset(40, 40)));
