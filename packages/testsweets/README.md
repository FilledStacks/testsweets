# Testsweets [![Pub Version](https://img.shields.io/pub/v/testsweets)](https://pub.dev/packages/testsweets)

This package is a utility and helper package to the TestSweets product. It is the package responsible for capturing your widget keys to the database which allows us to provide the auto complete functionality when you script your test cases.

## Installation

To start using the package you have to add this package to your `pubspec.yaml` file.

```yaml
dependencies:
  ...
  testsweets: [latest_version]
```


### Optionally
If you want to add general keys to check for when a certain widget is visible like a dialog or a button
you have to add the testsweets_generator package too

```
dev_dependencies:
  testsweets_generator: [latest_version]
  build_runner: [latest_version]
```

## Setup

After the packages have been added we have to setup the code. TestSweets makes use of Flutter Driver to drive the test cases that we write. This means we have to enable flutter driver for the version of the app that we build that goes through automation. Flutter driver disables certain things like the on screen keyboard

```dart
...

void main() {
  // 1. Setup the TestSweets internal dependencies
  await setupTestSweets();
  ...
  runApp(MyApp());
}
```

in your MaterialApp

```dart
...
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     // 2. Wrap the MaterialApp with TestSweetsOverlayView 
     //    and add the projectId you get when you created a new project in Testsweets app  
    return TestSweetsOverlayView(
      projectId: 'fGuFgPNXDnu56FEoe8Rn',
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: Routes.signUpView,
        navigatorKey: StackedService.navigatorKey,
        onGenerateRoute: StackedRouter().onGenerateRoute, 
        // 3. Finally add TestSweetsNavigatorObserver() 
        // to determine what view you are on right now
        navigatorObservers: [
          TestSweetsNavigatorObserver.instance,
        ],
      ),
    );

```

### Using the capture functionality

To run the app in capture mode you just start the application and capture mode will be enabled. This can be turned on or off if you pass `captureMode` false to the `TestSweetsOverlayView`.

<table>
  <tr align="center">
    <td>Intro screen</td>
     <td>Entered capture mode</td>
     <td>Types of widgets you can capture</td>
  </tr>
  <tr>
    <td> <img src="https://user-images.githubusercontent.com/89080323/133254053-bbcffc0b-b274-494e-a2a7-9271e05870ea.png"/></td>
    <td><img src="https://user-images.githubusercontent.com/89080323/133254068-01564574-3676-4834-915d-aba58c4d5f74.png" /></td>
    <td><img src="https://user-images.githubusercontent.com/89080323/133254040-8efcbc86-2050-438d-851b-c49a3b85f002.png"/></td>
  </tr> 
    <tr>
    <td>Choose a name for the widget</td>
     <td>Exit capture mode and go to inspect mode to see your keys</td>
  </tr>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/89080323/133254072-9a3e5567-3151-4411-b578-ac6744af7ec5.png" /></td>
    <td><img src="https://user-images.githubusercontent.com/89080323/133254062-9cde8983-4a92-41d3-ab9c-a656753beef7.png"/></td>
  </tr>
 </table>

### Putting the app in Drive Mode

To ensure the app is built for TestSweets to be able to drive it you you should pass `--dart-define=DRIVE_MODE=true` when building or running the app for TestSweets.

### Build the apk

```dart

flutter build apk --debug --dart-define=DRIVE_MODE=true

```
