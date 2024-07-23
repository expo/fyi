# Change to APNS entitlement handling in SDK 51

Prior to SDK 51, Expo prebuild was automatically adding the Apple push notification entitlement for all iOS apps built with the Expo SDK.

In response to customers who are not using notifications, and who did not want this entitlement added, we [modified the Expo prebuild code](https://github.com/expo/expo/pull/27924) so that the APNS entitlement is only added automatically if the app has the `expo-notifications` package installed.

Since the APNS entitlement is no longer always present, this will lead to a warning when submitting an app to the App Store. _Note that this is a warning only, and will not cause the app to be rejected._ Example message:

> Your app appears to register with the Apple Push Notification service, but the app signature's entitlements do not include the "aps-environment" entitlement. If your app uses the Apple Push Notification service, make sure your App ID is enabled for Push Notification in the Provisioning Portal, and resubmit after signing your app with a Distribution provisioning profile that includes the "aps-environment" entitlement.

## What impact does this warning have on my app?

If you are not using push notifications, then it has no impact - you can ignore it.

## What is responsible for triggering this warning?

This warning is coming from two different checks that Apple is doing:

1. Apple will send this warning if there is a mismatch between the capabilities information previously sent to Apple’s developer portal, and the entitlements file in the app. A mismatch can also happen in a newly created app with SDK 51 if the app is created without `expo-notifications`, a provisioning profile is created, and then the `expo-notifications` package and notifications code is added later.
2. Apple also checks the application binary for calls to the `UIApplicationDelegate` method `application:didRegisterForRemoteNotificationsWithDeviceToken:`. Apple will send the warning if it finds a call to this method, even if that call is in a 3rd party library and not in your application's app delegate. The `expo-modules-core` package's `ExpoAppDelegate` class implements this method for all Expo apps, in order to support applications that use notifications. Expo is currently investigating different approaches for removing this call from apps that do not need it.

## How can I stop receiving this warning?

### If you do not use push notifications in your app

- Go to the Apple developer portal and delete the APNS capability from the app there, if it is present.
- Due to the App Store static analysis that looks for notification methods in code, as described above, this will not yet be sufficient to prevent the warning. We're working on a good long-term solution, but for now you can [use patch-package](https://expo.fyi/eas-patch-package) to remove the [3 notification delegate methods from ExpoAppDelegate in expo-modules-core](https://github.com/expo/expo/blob/98732cc16e6d24017499eb152aba4af98bd2fed6/packages/expo-modules-core/ios/AppDelegates/ExpoAppDelegate.swift#L108-L159). We will update this FYI in the future when we have a better solution.

### If you do want to use push notifications in your app

- Ensure that you have added the notifications entitlement. You can do configure this in Xcode if you are manage your iOS project directly, or expo-notifications will handle it automatically if you use [CNG](https://docs.expo.dev/workflow/continuous-native-generation/). Alternative notification libraries should provide a config plugin to add the entitlement. If not, [you can add it manually in your app config](https://docs.expo.dev/build-reference/ios-capabilities/#entitlements). 

## Additional information

More information on how to work with Apple capabilities and entitlements can be found in our [documentation](https://docs.expo.dev/build-reference/ios-capabilities/).
