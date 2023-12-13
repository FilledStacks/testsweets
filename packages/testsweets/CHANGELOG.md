### 1.11.2

- fix: always render widgets regardless of scroll visibility 
- fix: iOS capture UI under the handlebar

### 1.11.1

- fix: fixes new widgets created in the top left corner of the view

### 1.11.0

- feat: Keeps all interaction points on screen, at 50% opacity, while adding a new one.
- feat: Adds ability to hide all interaction points to allow interaction with the host app
- feat: Removes automatic interaction point add when opening `Widget Capture` bottom sheet.

- fix: Don't allow spaces when naming a interaction point

- chore: Adds `TESTSWEETS_VERBOSE_LOGS` environment variable to control TestSweets log output

### 1.10.0

- Removes the Stacked Services package
- Creates a custom Snackbar service to show messagees

### 1.9.0

Adds constructor for `TestSweetsNavigatorObserver`. This is a fix for a bug that occurs when you add the observer to multiple navigators. The only instance of this bug happening is in `goRouter` when using `shellRoutes` and you need to add the observer to multiple places. 

Going forward documentation will ask for navigators to be added as follows:

```dart
navigatorObservers: [
    TestSweetsNavigatorObserver(),
],
```

Instead of

```dart
navigatorObservers: [
    TestSweetsNavigatorObserver.instance,
],
```

### 1.8.9
- Fix all analyzer issues

### 1.8.8
- Fix the gap between capturing interaction on scrollable and moving the list to sync it
- Remove deprecate code from testroutetracker
- Reduce the get interactions calls to the DB

### 1.8.7
- Test integrity feature

### 1.8.6+2
- Fix bugs

### 1.8.6+1
- Re-add responsiveness to interactions
- Driver layout new UI that match the capture UI

### 1.8.5
- Add scrollable interaction feature

### 1.7.5
- Fix route bug

### 1.7.4
- Fix testsweets doesn't respond to clearStackAndShow
- Fix scroll comand verification require a target to succeed

### 1.7.3
- Fix bugs

### 1.7.2
- Reverse to use the builder instead of wrapping the MaterialApp
- Fix conflict with client code
  
### 1.7.1
- Fix keyboard draw twice due to have 2 MaterialApps
- Fix quick edit is so sensitive
- When tap a widget show a toast with its name

### 1.7.0

- Redesigning the capturing layout
- Add attach/deatach widgets feature
- Add quick edit position feature

### 1.6.1
- Fix `buildAndUpload` for windows and mac
- Relative automation point is now optional(old keys will not break any more)

### 1.6.0

**Relative automation point placement**: We will now remember what the device resolution was that the automation point was captured on and try our best to scale in proportion those automation points to different size screens.

### 1.5.6

- Fixes the testsweets run command

### 1.5.5

- Fixes layout in landscape mode for the overlay

### 1.5.4

- Removes default factory constructor for the `TestSweetsNavigatorObserver`

### 1.5.3

### Improvements

- Removes the requirement for the user to use flutter driver in their project by including the setup in our package.

## 1.5.2

- Fixes edit mode

## 1.5.1

- Fixes bug that causes parent view text to dissapear

## 1.5.0

### Features

- Nested views swapping when navigation bar is detected

### Improvements

- UI updates to the capture tool

## 1.4.9

- Adds a debug icon to see which keys are on screen when automating

## 1.4.8

- Adds functionality to show parent widgets when the child is the current route. Used for bottom nav functionality

## 1.4.7

- Updates the naming of the Bottom nav tracking in `TestSweetsNavigatorObserver`

## 1.4.6

### Features

- Show view names during widgetDescription capture
- Show view names during inspect mode
- Add functionality to track bottom nav bar switches as new pages

## 1.4.5

- Improves UX for capturing widgets
- Adds new alias properties for better viewnames
- Adds new enabled functionality to turn overlay on or off

## 1.4.4

- Use correct string version of widget type in the `automationKey` value

## 1.4.3

- Makes sure that view widgets format keys as `viewName_widgetType` and normal keys format, `viewName_widgetType_widgetName`
- Validation for widget names to follow camel case pattern
- General UI updates to match designs

## 1.4.2

- Updates NO_ROUTE_PARAMETER to NoRoute
- Disable overlay capture when not in Debug mode
- Readme updates
- `buildAndUpload` command now continues even when no `automationKeys` are written
- Inspec view UI updates in realtime

## 1.4.1+1

- Removes warnings from packages

## 1.4.1

### Improvements

- Hide view widget description when Inspect Mode is active
- Allows start capture and inspect buttons to be moved to the top or bottom of screen
- Removes "Capture View" button and replaced with automatic view capture
- Adds ability to capture scrollable widgets

## 1.4.0

### New Feature

- On screen widget key capture
- Allows the user to capture widget keys on screen, removing the need to add keys directly into the code.
- Keys captured is synced with testsweets auto complete

## 1.3.4

- Add new `uploadKeys` command
- Replace the old `upload` command with `uploadApp`
- More unit tests

## 1.3.3

- Fixes dart-define arguments going missing when building the app

## 1.3.2+2

- Adds readme instructions for new multi package scraping

## 1.3.2+1

- Updates readme instructions

## 1.3.2

- Bumps http and get_it versions

## 1.3.1

- Adds dynamic key generation to be included into automation keys

## 1.3.0

- Replace parameters in command with a .testsweets config file

## 1.2.2

- Updates the upload url for builds again to point to the old functionality

## 1.2.1

- Updates the upload function to upload a list of Strings instead of a list of Automation Key models

## 1.2.0

- Adds functionality to allow the uploading of fake automation key entries for runtime generated keys.

## 1.1.0

- The `upload` and `buildAndUpload` commands now check that there is no already uploaded build with the same version as the build being uploaded. It is an error to upload a build to an already existing version.

## 1.0.0

### Breaking Change

- Removes the `syncAutomationKeys` function. Automation keys are now uploaded with the build. See README.

## 0.3.1

- Fixes http immutable header bug

## 0.3.0

- Updates to null safety

## 0.2.1

- Adds buildAndUpload command

## 0.2.0

**Automatic build integration**

## 0.1.1

- Allows for easier view name keys. `login_view` is accepted now

## 0.1.0+1

- Updates the readme for the package with actual steps to setup the package.

## 0.1.0

- Add Testsweets Builder for inspecting widgets.

## 0.0.1

- Initial release.
