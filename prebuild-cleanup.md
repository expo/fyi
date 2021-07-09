# Cleanup after `expo run` and `expo prebuild` commands

If your project is built entirely in JavaScript, you can run them outside of Expo Go on your computer or device with the `expo run` commands. `expo run:ios` and `expo run:android` modify some files in your project and generate iOS and/or Android native project files in order to be able to build and run them on your machine. The modifications are made by running `expo prebuild` behind the scenes prior to building and running the project. This is the same process that occurs when running a build for your app on EAS Build.

It can sometimes be helpful to use `expo run` commands to build and test your app locally; but, if you typically do your development in Expo Go or in a custom development client built with EAS Build, you probably don't want to keep the modifications and generated files around after you are done testing. The iOS and Android projects include many files and directories and can make your diffs more noisy than needed if you aren't actually using them for anything except `expo run`.

**To clean up after `expo run` and `expo prebuild` commands**, you can either add the generated files to your `.gitignore` or manually delete them. The following files/directories are modified or generated when these commands are invoked:

## Modified and generates files and directories

- `.gitignore`: for developers who choose to commit the `ios/` and `android/` directories to source control, modifications are made to the `.gitignore` file to exclude files within those directories that do not belong in source control, such as build caches.
- `app.json`: this may be modified if `ios.bundleIdentifier` or `android.package` aren't set, because those values are required to generate native projects.
- `index.js`: if it does not already exist in your project, it will be created to ensure that a Metro bundler instance started by React Native, without Expo CLI, will build your app correctly.
- `metro.config.js`: if it does not already exist in your project, it will be created to ensure that Metro will extend default configuration from `expo/metro-config` when it is started by React Native, without Expo CLI.
- `package.json`: several libraries will be added if they aren't already used by the project, and the `"main"` entry point will be removed if it uses the default `"node_modules/expo/AppEntry.js"`, once again to ensure that the Metro bundler instance started by React Native rather than Expo CLI will work as expected.
- `node_modules/`: `npm` or `yarn` will run after `package.json` is modified, likely resulting in changes to your `node_modules/` directory.
- `ios/`: this directory will contain the native project files for your iOS app, generated from your app configuration.
- `android/`: this directory will contain the native project files for your Android app, generated from your app configuration.

## Manually deleting and reverting files

You can delete the `ios` and `android` directories, delete any other untracked files and revert other changes with `git checkout`. If you revert the changes to `package.json`, then run `npm install` or `yarn` again afterwards.

> 💡 Most additional weight and code added to your repository would come from the `ios/` and `android/` directories. You can delete those and commit the rest of the side effects of `expo run` / `expo prebuild` if you want, in order to minimize side effects of subsequent use of the command.

## Using `.gitignore` to ignore files instead of deleting and reverting

In addition to the values added to your existing `.gitignore`, you may want to add entries for both `ios` and `android` to ignore those directories entirely.
