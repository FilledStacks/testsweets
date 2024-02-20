# TestSweets [![Pub Version](https://img.shields.io/pub/v/testsweets)](https://pub.dev/packages/testsweets)

This package is a utility and helper package to the TestSweets product. It is the package responsible for capturing your widget keys to the database which allows us to provide the auto complete functionality when you script your test cases.

## Installation

To start using the package you have to add this package to your `pubspec.yaml` file.

```yaml
dependencies:
  ...
  testsweets: [latest_version]
```


## Setup

After the packages have been added we have to setup the code. TestSweets makes use of Flutter Driver to drive the test cases that we write. This means we have to enable Flutter driver for the version of the app that we build that goes through automation. Flutter driver disables certain things like the on screen keyboard. To disable completely TestSweets is as easy as passing `enabled: false` to setupTestSweets function.




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

    return MaterialApp(
      // 2. Inside MaterialApp add TestSweetsOverlayView to the builder
      //    with the projectId you get when you created a new project in Testsweets app
      builder: (context, child) => TestSweetsOverlayView(
        projectId: '3OezzTovG9xxxxxxxxx',
        child: child!,
      ),
      // 3. Finally add TestSweetsNavigatorObserver() 
      // to determine what view you are on right now
      navigatorObservers: [
        TestSweetsNavigatorObserver.instance,
      ],
    );
```

## Capturing Interactions

To run the app in capture mode you just start the application and capture mode will be enabled. You can swap between capture mode and drive mode tapping on the screen with 3 fingers.

### How to add an Interaction

Note: The view you are on is automatically captured

1. Click the arrow to show the bottomsheet
2. Select one of the three interaction types (default to Touchable)
3. Drag the "T" icon onto the touchable widget e.g. a button
4. Enter a widget name
5. Tap the **Save Widget** button

*Note: you can tap the arrow again to close the bottomsheet and move the widget freely and it will preserve the information*


https://user-images.githubusercontent.com/89080323/161919116-9d27c9d1-bf6f-47c4-86a5-18cde8e9a514.mp4



### How to inspect a view

Inspecting view is the default state when you open the app.

However, if you’re Creating/Editing a widget and you want to go back to inspect mode you can tap the Clear button.



### How to edit an interaction

#### Normal Edit

1. To start editing first you have to be in inspecting mode
2. Long press on the widget you want to edit 
3. Choose Edit from the menu that appeared
4. That will pop up the bottom sheet with the old content of the interaction
5. Change name, type, and position 
6. Tap update when done
7. If you change your mind you can tap Clear to return to inspect mode without saving


https://user-images.githubusercontent.com/89080323/161919018-c0ca2a62-c45c-4def-87ee-3809bbb926d3.mp4


#### Quick position edit

If you want to adjust the position only, there is a shortcut 

1. Long press and hold on the interaction you want to change size
2. While holding drag to the preferred position
3. Lift your finger to save the current position



https://user-images.githubusercontent.com/89080323/161918909-1cd79398-f3ad-4fe2-bfe4-d0a1c713f8bd.mp4



### How to remove an interaction

1. To start editing first you have to be in inspecting mode
2. Long press on the widget you want to edit 
3. Choose Remove from the menu that appeared and that’s it!


https://user-images.githubusercontent.com/89080323/161917599-17be16bb-b2e7-4563-a528-c20845ba359a.mp4




## Putting the app in Drive Mode

To ensure the app is built for TestSweets to be able to drive it you you should pass `--dart-define=FORCE_CAPTURE_MODE=false` when building or running the app for TestSweets.



## Build the apk

```dart

flutter build apk --debug --dart-define=FORCE_CAPTURE_MODE=false

```
