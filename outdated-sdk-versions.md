# Using outdated SDK versions

At any given time, Expo provides support for the latest several SDK versions. You can see the exact supported versions on the [API reference](https://docs.expo.dev/versions/latest/). Unsupported versions are removed from the documentation.

We recommend upgrading your project to the latest SDK version as soon as possible to get the latest improvements, but this isn't always practical for every team, so the supported lifetime of an SDK version is approximately one year. This roughly follows the cadence for iOS and Android releases, which come with new minimum requirements for all apps. These requirements can't always be easily backported to all SDK versions.

## Submitting to app stores

Apple and Google regularly update their required iOS/Android SDK version requirements. If you are using an older Expo SDK version, your project may not compile with the latest iOS SDK or with the latest version of Xcode, and these requirements change annually. Similar rules apply for Android.

You may see an error like this when submitting an app:

> SDK version issue. This app was built with the iOS 15.0 SDK. All iOS and iPadOS apps submitted to the App Store must be built with the iOS 16.1 SDK or later, included in Xcode 14.1 or later.

If you see this error, you will need to upgrade your project to a newer SDK version. More information is available in the [upgrade guide](https://docs.expo.dev/workflow/upgrading-expo-sdk-walkthrough/). Alternatively, on EAS Build you can try changing the build worker image to use the required Xcode version; however, this isn't without risks. Sometimes your app may compile but subtle regressions will be introduced. The safest option is to upgrade your project to a newer SDK version.

## Using Expo Go on outdated SDK versions

You can continue to use Expo Go on for old SDK versions by installing it through Expo CLI. Run `npx expo start` in your project and launch it from the interactive prompt — the Expo Go app will be installed with the correct version for your project. Note that this is not possible on iOS devices, only on simulators, due to restrictions around sideloading.

You may continue to use [development builds](https://docs.expo.dev/develop/development-builds/use-development-builds/) for as long as your device will continue to run your app.
