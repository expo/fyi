# Troubleshooting your Expo SDK upgrade

While much of your upgrade to the next SDK version can be accomplished in a [few steps](https://docs.expo.dev/workflow/upgrading-expo-sdk-walkthrough/), every app is different. There are practically infinite combinations of dependencies and custom code. There may be things you need to test or fix after running the upgrade command before your app is working 100% on the new SDK version.

This goal of this guide is provide background on what goes into an SDK upgrade and some battle-tested strategies for troubleshooting upgrades, so you can be ready to quickly narrow down root cause and get your app working on the next version.

## What's included in an Expo SDK upgrade?
An SDK upgrade includes:
- Changes to core functionality in the `expo` module and its dependencies
- New versions of Expo SDK (`expo-*`) packages, such as `expo-updates`, `expo-camera`, and `expo-dev-client`
- Updates to other critical packages, such as `react-native-reanimiated`, `react-native-screens`, or React Navigation packages (when using Expo Router)
- An upgrade to the next version of `react-native`, including associated packages like Metro Bundler.

That last item is key: each Expo SDK upgrade is keyed to a React Native version. You are upgrading React Native at the same time, so your JavaScript/Typescript, any custom native code you write, and third party packages will need to be compatible with that version of React Native.

Knowing the different categories of what is getting updated can help us look in the right general direction when we have an issue, going from "it's not working" to "this specific functionality in the new version of that specific package has a specific issue."

## Before you upgrade

These few things can really help you start your upgrade on the right foot.
- [Migrate to development builds](https://docs.expo.dev/develop/development-builds/introduction/). If you're still using Expo Go for testing, migrate to development builds before you upgrade. Expo Go is limited in how it can simulate the functionality of your standalone app. Migrating to development builds before you upgrade will give you a good baseline for comparing between old and new versions, and will set you up for being ready to create a development build under the new SDK version. Once you're on development builds, you will have the flexibility to upgrade on your own schedule with less pressure.
- **Start your upgrade on a separate git branch**. You should be able to switch back to working on your previous version if your upgrade takes a little longer than expected. Only merge your upgrade into main once you've confirmed everything is working and you're ready to ship.
- **Upgrade one thing at a time**. Starting with SDK 52, many developers are also upgrading their apps to use the React Native New Architecture. Do the upgrade to SDK 52 first, and then try [enabling the New Architecture](https://docs.expo.dev/guides/new-architecture/#enable-the-new-architecture-in-an-existing-project), so you can better tell at what step an issue occurred. Likewise, upgrade one SDK version at a time so don't miss any important breaking changes.

## Tips for troubleshooting

Below are some general approaches to troubleshooting, in a general order of things you should try first and are quick fixes, to things you should try when the quick fixes don't resolve the issue.

### Check Expo Doctor warnings
Run `npx expo-doctor@latest`. You'll get warnings about out-of-date packages, any packages that are known to be not compatible with the New Architecture, and alerts about other common pitfalls.

If you see any out-of-date dependencies, run `npx expo install --fix` to upgrade to the latest patch version. Maybe those updates include a fix to your issue!

If you're migrating to New Architecture and see that a package does not support it, go to that package's repository and check for any information in the readme or issues.

### Double-check the SDK changelog

The [changelogs](https://docs.expo.dev/workflow/upgrading-expo-sdk-walkthrough/#sdk-changelogs) include notes about any breaking changes, such as deprecated API's that were removed or changes required by Android or Apple SDK's.

### Clear node modules

Sometimes our **node_modules** folder gets into an unexpected state when a lot of things change. If and when these errors occur often depends on what package manager you're using or if your app is inside a monorepo.

Run `rm -rf node_modules` to delete **node_modules** and all of its contents, and then run your package manager again to recreate it (`Remove-Item -Path "node_modules" -Recurse -Force` on PowerShell).

Sometimes just removing the folder and reinstalling dependencies is enough, but if that doesn't work, you can also try deleting the lockfile (e.g., **yarn.lock**, **package-lock.json**) and deleting **node_modules** at the same time, and then reinstalling dependencies. Your lockfile will likely change slightly after doing this, which may end up being just the fix you need.

### Clear the bundler cache

You can also clear the Metro Bundler cache by running `npx expo start -c`.

### Check Github repositories for third-party packages

If you see an error either when building or running your app that looks to be specific to a third party package, check their Github. They may have posted a new release that resolves the issue, or in the Issues list other users may be discussing a workaround.

On EAS Build, if you see a compilation error for a third-party package in the Gradle or Fastlane step, it may be that your current version doesn't support the new version of React Native that you just upgraded to. Check their releases for a new version. It's also possible that they are still working on support for the latest React Native version.

### Check for old workarounds that might not be needed anymore

This could take on a lot of forms, but sometimes we do things to workaround issues, and those workarounds can be the source of the problem after you upgrade. For instance, maybe you set a specific `kotlinVersion` using the `expo-build-properties` config plugin because a package required it at the time, but now you're getting a bundle of syntax errors in the Gradle step. It might be time to remove that configuration!

### Use React Native DevTools to debug JavaScript / Redbox errors

Press `m` to open React Native DevTools when running your app locally, which lets you read console errors, set breakpoints, view network traffic, and more. Setting a breakpoint on unhandled exceptions can help you see the state of your app just before the error, including the function calls leading up to the error.

### Use native logging tools to debug crashes

If your app builds but is crashing when you run it, use [ADB Logcat or macOS Console](https://docs.expo.dev/debugging/runtime-issues/#production-errors) to listen in on native log messages. You'll often see something when reproducing the error with one of these tools connected that will help on your way to getting unblocked.

### Get some fresh air

At this point, if you're still hunting down the issue, you've collected a lot of data points, but they might not form a complete picture yet. If you haven't taken at least a short break by now, this is the time. Take a walk, pet a dog, watch a sunset, whatever. Let all those loose threads sit and simmer in your mind for a bit.

### Create a minimal reproduction

A minimal reproduction is where you take the default app template (`npx react-expo-app@latest`), and try to add just enough code, packages, or configuration to cause the same issue that you see in your app. A one of a few wonderful things can happen when you do this:
1. You might find that you can't reproduce the issue, and this suggests that something else may be causing it. You've eliminated one possibility!
2. You might find that you can't reproduce the issue, but it's becaues you found a problem with your implementation that was easier to see in isolation. So now you can take that learning back to your own code!
3. If you can reproduce the issue, you've just created a valuable artifact that you can pass along to the maintainer when you ask for help, eliminating several obstacles on their way to providing a fix.

### Submit an issue

If you have a minimal reproduction and it's for the Expo SDK or CLI, submit it to the [Expo Github issues list](https://github.com/expo/expo/issues). If we can run it on our end and see the same issue you're seeing, it greatly improves the odds that we'll be able to fix it in short order, or at least be able to suggest a workaround.

If you have a minimal reproduction for another package, submit it to that package's Issues list. Minimal reproductions are helpful and appreciated everywhere.

When you report an issue, describe what is specifically happening versus what you expect to happen. Language like "not working" is typically too vague, as there's many different ways something could be "not working." Descriptions like "I got this error message: {specific error message}" or "the view overlaps the camera notch when it should be under it" help others visualize your issue, whether reporting it via Github or discussing it on Discord.

## Tips for non-CNG projects

If you're managing your own **ios** and **android** folders, a common source of issues during an upgrade are changes to native project files. You can see all the changes to the base native template in the [Native Project Upgrade Helper](https://docs.expo.dev/bare/upgrade). Double-check those, as one line can make a big difference!

## More information

Check out our [troubleshooting guides overview](https://docs.expo.dev/troubleshooting/overview/) for a list of all of our guides for how to debug specific issues and use debugging tools in general. One of the issues presented in here might resemble your issue.