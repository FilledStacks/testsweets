# TestSweets Sync

TS Sync will allow for easier synchronisation between a code base and your TestSweets projects. Currently the way the tester will create tests is by getting all of the keys from the developer per view and then create tests using those keys. What TS Sync will do is cut out the process of keeping track of all the keys on views and which ones can be used. It will look at all the keys in the project, find what view it's associated with, generate a key index and then push that to the TestSweets backend where it'll be associated with the project you have created. At this point when the tester wants to create a test they can choose from a view as well as the keys in the view to decide which widgets to target with test commands.

## Flutter

To implement this we will start with the creation of a package that the user can add into their flutter project. This package will be have a build_runner implementation to generate the automation keys that we'll sync and it'll have a sync class that will post all this data to the users project.

## TestSweets Generator

_Note: If you're not going to Unit test every part of this package you will not work on it. If you're struggling with unit testing ask me (Dane) for help_

The generator will make use of annotations and `Key`'s that are supplied to widgets. The keys will be in a specific format to allow us to extract the correct details for it. Each view file that has its own keys defined will be annotated with a `@SweetView()` annotation. This will indicate to the build_runner that we want to scan this view for keys to synchronise. In the view there will be keys that follow the following format.

[Widget type]\_[Widget name]

There are 5 different widget types at this point.

- **touchable**: This is any widget that the user can tap to interact with the application
- **scrollable**: This is any widget that the user can scroll to interact with the application
- **text**: This is a plain text widget that the TestSweets application can read
- **general**: This is any widget that will have to be checked for visibility or anything like that
- **view**: This should ONLY be used for widgets that take up an entire navigation entry
- **input**: This is an input field that takes user input from the keyboard

An example of this would be for an input field on the login view. The email field Key would be `input_email` and the password field would be `input_password`. The login button will have the key `touchable_login`. If the Key value passes 1 word we'll use camel casing for the naming, something like `touchable_forgotPassword`. The generator will get the views marked with the `@SweetView()` annotation and create `AutomationKey`'s from it. The automation key model will look as follows.

```dart
@freezed
abstract class AutomationKey with _$AutomationKey {
  factory AutomationKey({
    String name,
    WidgetType type,
    String view,
  }) = _AutomationKey;

  factory AutomationKey.fromJson(Map<String, dynamic> json) =>
      _$AutomationKeyFromJson(json);
}

enum WidgetType {
  touchable,
  text,
  general,
  view,
  input,
}
```

The values in these keys will be assigned as follows.

- **type**: This comes from the first part of the key value split by `_`. i.e. touchable_login the type will equal `touchable`.
- **name**: This comes from the the second part of the key value split by `_`. i.e. touchable_login the name will equal `login`
- **view**: This comes from the class that has been annotated with the `@SweetView()` annotation. The full name will be used and we'll write name parsers as we see the various naming styles that come in. Some devs will use HomeView, HomePage, HomeScreen, HomeComponent, etc. We'll normalise the name so that the testers only see `Home` when writing their scripts. That we will do on the TestSweets application side.

During the generation we will generate the structure that will be uploaded to our endpoint using the project key. It will simply upload a list of widgets in the following form.

```dart
var automationKeys = [
  AutomationKey(name: 'login', type: WidgetType.input, view: 'LoginView'),
  AutomationKey(name: 'password', type: WidgetType.input, view: 'LoginView'),
  AutomationKey(name: 'login', type: WidgetType.touchable, view: 'LoginView'),
  ...
];

// projectId is passed in to the function from the main function
SweetSync.uploadKeysForProject(automationKeys,  projectId);
```

These keys will be uploaded to a cloud function that then inserts it into the required product.

**DO THIS AFTER THE UPLOAD WORKS**
We'll have to generate a credential file for the dev to put into their code base that will help us authorise the api call since it'll be viewable through network traffic inspection. We wouldn't want malicious users to destroy other users projects when they find their project id's. They'll need to have the generated authentication details as well as the project id.

### TestSweets Sync

In the code the dev will have to call the function to perform the upload of the generated data. This will happen in the main function before the dev runs the app.

```dart
// Verbose true will log as each view's keys is uploaded.
SweetSync.syncKeys(projectId: '<project-id>', verbose: true);
```

What this function will do is make an http post request with the json from the above generated automationKeys list. These values will be inserted, each on as a new document, in a sub collection in the project. The subcollection will be called automationKeys and each document will be an AutomationKey. This will allow us to do real-time rapid queries that will be much faster than storing the collection as a list of maps.

## Future Feature

These features are for when all the above works 100%.

### Upload progress widget

In the future we will provide a UI blocking widget that will show the progress for the uploaded keys so the dev can know when the upload is complete. Before that is added the verbose logs will print out in the console so the dev will have some kind of indication on whether the upload / sync is complete or not

### Precondition and Post Conditions

In addition to view annotations the devs will also be able to annotate actions that can be executed during or after a test. Things like logout, clearing cache, closing the app, etc. I still have to think about how this will work so we'll leave this out for now.
