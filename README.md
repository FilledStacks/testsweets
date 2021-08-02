# TestSweets

TS Sync will allow for easier synchronisation between a code base and your TestSweets projects. Currently the way the tester will create tests is by getting all of the keys from the developer per view and then create tests using those keys. What TS Sync will do is cut out the process of keeping track of all the keys on views and which ones can be used. It will look at all the keys in the project, find what view it's associated with, generate a key index and then push that to the TestSweets backend where it'll be associated with the project you have created. At this point when the tester wants to create a test they can choose from a view as well as the keys in the view to decide which widgets to target with test commands.

Read more about it [here](https://github.com/FilledStacks/testsweets/tree/master/packages/testsweets#testsweets-)

## TestSweets Generator

_Note: If you're not going to Unit test every part of this package you will not work on it. If you're struggling with unit testing ask me (Dane) for help_

The generator will make use of annotations and `Key`'s that are supplied to widgets. The keys will be in a specific format to allow us to extract the correct details for it. This will indicate to the build_runner that we want to scan this view for keys to synchronise.

Read more about it [here](https://github.com/FilledStacks/testsweets/tree/master/packages/testsweets_generator)

## Future Feature

These features are for when all the above works 100%.

### Upload progress widget

In the future we will provide a UI blocking widget that will show the progress for the uploaded keys so the dev can know when the upload is complete. Before that is added the verbose logs will print out in the console so the dev will have some kind of indication on whether the upload / sync is complete or not

### Precondition and Post Conditions

In addition to view annotations the devs will also be able to annotate actions that can be executed during or after a test. Things like logout, clearing cache, closing the app, etc. I still have to think about how this will work so we'll leave this out for now.
