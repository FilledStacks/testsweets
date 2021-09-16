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

**Improvements**

- Hide view widget description when Inspect Mode is active
- Allows start capture and inspect buttons to be moved to the top or bottom of screen
- Removes "Capture View" button and replaced with automatic view capture
- Adds ability to capture scrollable widgets

## 1.4.0

**New Feature**: On screen widget key capture

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

- **Breaking Change**: Removes the `syncAutomationKeys` function. Automation keys are now uploaded with the build. See README.

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
