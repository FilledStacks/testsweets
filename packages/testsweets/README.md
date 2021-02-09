# Testsweets [![Pub Version](https://img.shields.io/pub/v/testsweets)](https://pub.dev/packages/testsweets)

This package is a utility and helper package to the TestSweets product. It is the package responsible for syncing your widget keys to the database which allows us to provide the auto complete functionality when you script your test cases. It also has some UI helpers like the TestSweets builder widget that will overlay on the screen any of the widgets matching our naming syntax. This package also serves as the only way of uploading builds to Test Sweets.

## Installation

To start using the package you have to add this package as well as the generator which will generate the `AutomationKey` code for us to upload to our application. To do that we add the following into the `pubspec.yaml` file.

```yaml
dependencies:
  ...
  # Flutter driver is required as well
  flutter_driver:
    sdk: flutter
  testsweets: [latest_version]

dev_dependencies:
  testsweets_generator: [latest_version]
  build_runner: [latest_version]
```

## Setup

After the packages have been added we have to setup the code. TestSweets makes use of Flutter Driver to drive the test cases that we write. This means we have to enable flutter driver for the version of the app that we build that goes through automation. Flutter driver disables certain things like the on screen keyboard so to keep it all separate we'll create a new main file titled main_profile.dart. In this file we will setup test sweets and enable Flutter driver. Once you've created the file main_profile.dart in the same location as you original main.dart file you can add the following code.

```dart
...
// 1. Import flutter driver extension to enable flutter driver
import 'package:flutter_driver/driver_extension.dart';
// 2. Import test sweets using the testSweets alias
import 'package:testsweets/testsweets.dart' as testSweets;
// 3. Import the automation keys (this won't exist until we run the build_runner)
import 'app_automation_keys.dart' as appKeys;

void main() {
  // 4. Sync the generated automation keys to your project
  testSweets.syncAutomationKeys(
      automationKeys: appKeys.APP_AUTOMATION_KEYS,
      projectId: '<project-id>',
      apiKey: '<api-key>',
    );

  // 5. Enables flutter driver
  enableFlutterDriverExtension();

  ...
  runApp(MyApp());
}
```

We start off by importing the required files, testsweets.dart for the functionality and app_automation_keys.dart for the generated keys to send up to our app. In the main function we start by calling `syncAutomationKeys` and we pass it the `APP_AUTOMATION_KEYS`. This code still has to be generated so don't be concerned if you see it complaining and not compiling. The `projectId` and `apiKey` values can be found in your project settings in the TestSweets application. If you haven't generated an API key yet, click on the "Generate API Key" button and it will be generated for you.

This version of your APK will not go public so we don't need to add any extra security measures around protecting those keys. If you do want to add extra security you can add it as an environment variable and read it from there. This call to `syncAutomationKeys` is treated as a fire and forget function because it'll sync in the background and print out a log message when your sync is complete. The last thing we do is call `enableFlutterDriverExtension` which is available in the `flutter_driver` package. That's all the setup required.

## Creating your Keys to Sync

Next up we'll add the automation keys that will be used during the scripting. These are normal Flutter `Key` objects where the `String` value is formatted in a certain way. Go to your first view that will be shown in the app and we'll add a few keys to walk you through the process. Before we add the keys I want to share with you the format that we use to identify keys in your code base. There are 5 different widget types at this point.

- **touchable**: This is any widget that the user can tap to interact with the application
- **scrollable**: This is any widget that the user can scroll in the application
- **text**: This is a plain text widget that the TestSweets application can read. Used to confirm certain text on screen
- **general**: This is any widget that will have to be checked for visibility or anything like that
- **view**: This should ONLY be used for widgets that take up an entire navigation entry
- **input**: This is an input field that takes user input from the keyboard

We have a specific format for each widget key that is as follows, [viewName]\_[widgetType]\_[widgetName]. For view keys the [viewName]\_[view] shortened form can be used. Lets go over those parts 1 by 1:

- **viewName**: Is the name of the view without the word view in it. So if you're on the `LoginView` you'll write this as `login`.
- **widgetType**: This is one of the 6 types of widgets as defined above.
- **widgetName**: The name as you would identify it in a readable and understandable manner.

An example of this would be for an input field on the login view. The email field Key would be `login_input_email` and the password field would be `login_input_password`. The login button will have the key `login_touchable_login`. If any of the parts of the key has multiple words we'll use camel casing for the naming, something like `specialBoarding_touchable_forgotPassword`. With that said lets assume your first view that'll be shown is the `LoginView`. We can create some keys on the view and generate the automation keys. Open up your login view file and add a key to your scaffold.

```dart
Scaffold(
  key: Key('login_view'),
  ...
);
```

Then you can go ahead and add the keys to your `TextFields`.

```dart
 InputField(
  inputFieldKey: Key('login_input_email'),
  controller: email,
  placeholder: 'Enter your Email',
),
verticalSpaceSmall,
InputField(
  inputFieldKey: Key('login_input_password'),
  controller: password,
  placeholder: 'Enter your Password',
),
```

And you can also add a key to the button the user would tap to login.

```dart
 AppButton(
  buttonKey: Key('login_touchable_login'),
  title: 'Login',
  busy: model.isBusy,
  onPressed: () => model.login(
    userName: email.text,
    password: password.text,
  ),
),
```

Now that that's in the code we can generate the automation keys. Run the following flutter command.

```
flutter pub run build_runner build
```

This will generate a new file in the root of your project called `app_automation_keys.dart`. If you open that file you'll see the following

```dart
// DO NOT EDIT, CODE GENERATED WITH TEST SWEETS GENERATOR on 2020-11-08 15:12:46.403706.

const List<Map<String, String>> APP_AUTOMATION_KEYS = [
  {'name': 'login', 'type': 'WidgetType.view', 'view': 'login'},
  {'name': 'email', 'type': 'WidgetType.input', 'view': 'login'},
  {'name': 'password', 'type': 'WidgetType.input', 'view': 'login'},
  {'name': 'login', 'type': 'WidgetType.touchable', 'view': 'login'},
];
```

Once that is in your code base you should be able to run the application. You can run the main_profile.dart file by using the following command.

```
flutter run -t lib/main_profile.dart
```

If you want to add the profile to your run profiles you can add the following configuration into your VSCode configurations

```json
   {
      "name": "profile",
      "request": "launch",
      "type": "dart",
      "program": "lib/main_profile.dart",
    },
```

Run the application and you should see the following logs printed if everything has been setup correctly.

```text
TestSweets: POSTING automation keys to https://us-central1-testsweets-38348.cloudfunctions.net/saveAutomationKeys. Keys: [{name: skip, type: WidgetType.touchable, view: welcome}, {name: login, type: WidgetType.touchable, view: welcome}, {name: signUp, type: WidgetType.touchable, view: welcome}]

TestSweets: Successfully uploaded automation keys.
```

Now you can open up the TestSweets Desktop application and start your scripting.

## Uploading builds to the Test Sweets application

Once you have written your scripts you will need to upload a build to test with them. This is done by building your application in debug or profile mode and uploading it to the Test Sweets storage backend. To build and upload your application navigate to the folder containing your `pubspec.yaml` file and run the `testsweets` package as follows:

```bat
flutter pub run testsweets upload apk profile {projectId} {apiKey} -t lib/main_profile.dart
```

This will print an output similar to the following:

```text
Running Gradle task 'assembleProfile'...                          180,4s
√ Built build\app\outputs\flutter-apk\app-profile.apk (28.1MB).
Uploading build ...
Done!
```

You can also specify ipa for an ios build instead of apk. For a debug build specify `debug` instead of `profile`. Replace {projectId} and {apiKey} with the project id and api key for your project. These can be found in the settings for your Test Sweets project.

## Downloading your builds from Test Sweets

Once your build has finished uploading you can open your project in Test Sweets. Click the `Select APK To Test` button and your newly uploaded build will appear in the list. Selecting it will download the build. The build is only downloaded once, next time you select it the downloaded build will be used. Once the build has been downloaded you can then run your test cases.

## Using TestSweets builder

1. Use `TestSweets.builder()` function at the root level of your app to inspect all the support widgets.
2. You can also use the `enabled` property to disable/enable the inspector.
