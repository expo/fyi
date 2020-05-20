# Deprecating the AR module

This module has been experimental its entire lifetime. As of SDK 37, the module is not widely used, and it is only included in the iOS App Store development client (not standalone apps built with `expo build:ios`) -- meaning it cannot be used in production in managed workflow projects. In order to build a production app with the AR module, you need to use ExpoKit or the bare workflow.

We’ve decided to focus our limited resources elsewhere, so the iOS development client version 2.15.5 will be the last SDK release that includes this module. When SDK 38 is released, the AR module will be removed from **all** SDK versions in the iOS App Store development client. This means you will no longer be able to use the iOS development client to develop or experiment with the AR module.

Existing ExpoKit projects using the AR module will of course be unaffected.

If you would like to continue developing with the AR module in a bare workflow project, the native module formerly included in the iOS Expo client will remain in git history in the open-source Expo repository. You are welcome to view the latest [TypeScript module](https://github.com/expo/expo/blob/sdk-37/packages/expo/src/AR.ts) and [Objective-C implementation](https://github.com/expo/expo/tree/sdk-37/ios/Exponent/Versioned/Optional/ARKit) from the SDK 37 release branch, and use these as a starting point in your own project, respecting the repository's [MIT license](https://github.com/expo/expo/blob/master/LICENSE). At the time of this writing (May 2020), the Expo team has no plans to continue maintaining or releasing this code.
