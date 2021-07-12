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
