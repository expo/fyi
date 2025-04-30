# Subscribing to important application events

Your app or library may need to subscribe to application events such as `onCreate` (Android), `applicationDidFinishLaunching` (iOS) and more. Often times, it's necessary to hook into these events to perform, for example, a third-party SDK setup.

[Expo Modules API](https://docs.expo.dev/modules/overview/) supports integrating with these APIs from your modules, without needing to modify the underlying native project. This can be achieved with [Android lifecycle listeners](https://docs.expo.dev/modules/android-lifecycle-listeners/) and [iOS AppDelegate subscribers](https://docs.expo.dev/modules/appdelegate-subscribers/). We'll collectively call these "Subscribers" in this document.

## Migrating legacy config plugins

You may be using a config plugin to add code inside the same methods that the Subscribers allow hooking into. Using Subscribers is the recommended approach, as they are more robust and less error-prone, since they compose well with multiple listeners compared to modifying code with a regular expression in a config plugin. For example, in SDK 53, `AppDelegate` was migrated from Objective-C to Swift, which would break config plugins that only supported Objective-C.

If you are using a config plugin to perform a task that can be done by a Subscriber, we recommend you [switch to Subscribers](#migrating-to-subscribers-recommended). Alternatively, read [instructions below](#updating-the-config-plugin) to migrate your config plugin to support Swift.

### Migrating to Subscribers (recommended)

Read more about this approach and see examples in ["Developing and debugging a plugin"](https://docs.expo.dev/config-plugins/development-and-debugging/#ios-appdelegate). For a step-by-step guide for libraries, follow ["integrate Expo Modules API into an existing library"](https://docs.expo.dev/modules/existing-library/#subscribing-to-application-events).

A good, minimal example of using Subscribers in a community Expo Module is `react-native-app-security`: see its [Android lifecycle listener](https://github.com/bamlab/react-native-app-security/blob/c1a861cbd348f404ec18ffae90d1c9bdc66bc00d/android/src/main/java/tech/bam/rnas/AndroidReactActivityLifecycleListener.kt) and [iOS AppDelegate subscriber](https://github.com/bamlab/react-native-app-security/blob/c1a861cbd348f404ec18ffae90d1c9bdc66bc00d/ios/RNASAppLifecyleDelegate.swift).

### Updating the config plugin

If you want to make modifications using a config plugin, make use of utility functions exported from `expo/config-plugins` listed below. For an example of a config plugin that modifies the `AppDelegate.swift/mm` and `MainActivity.kt/java`, refer to [`react-native-bootsplash` config plugin](https://github.com/zoontek/react-native-bootsplash/blob/388d6be3d7082f60fdafe4bbfead73c17f00f0a8/src/expo.ts).

_This list is non-exhaustive._

- [`mergeContents`](https://github.com/expo/expo/blob/69b526e3584d33a6897d925bc645da5d2e21dbf3/packages/%40expo/config-plugins/src/utils/generateCode.ts#L35) to merge a piece of code to a file. This will add the code only if not already present.
- for a more fine-grained control, use [`findSwiftFunctionCodeBlock`](https://github.com/expo/expo/blob/ed38cf95cc4d819540f4576c3926bff55cab1d54/packages/%40expo/config-plugins/src/ios/codeMod.ts#L171), [`insertContentsInsideSwiftClassBlock`](https://github.com/expo/expo/blob/ed38cf95cc4d819540f4576c3926bff55cab1d54/packages/%40expo/config-plugins/src/ios/codeMod.ts#L236C17-L236C52) and [`insertContentsInsideSwiftFunctionBlock`](https://github.com/expo/expo/blob/ed38cf95cc4d819540f4576c3926bff55cab1d54/packages/%40expo/config-plugins/src/ios/codeMod.ts#L269) for determining whether a function exists or creating it, and inserting code inside it.
