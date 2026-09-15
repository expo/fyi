# iOS scene-based life cycle in SDK 58

Starting with SDK 58, Expo apps on iOS use the UIKit scene-based life cycle (`UIScene`). The iOS 27 SDK requires it: apps built with Xcode 27 that still use the application-based life cycle do not launch correctly on iOS 27.

This guide explains what changed, who needs to act, and how to migrate.

## Quick summary

**You don't need to do anything if:**

- Your project uses [Continuous Native Generation](https://docs.expo.dev/workflow/continuous-native-generation/) and you don't commit the **ios** directory. Run `npx expo prebuild --clean` after upgrading and the new files are generated for you.
- Your custom native code is in config plugins that use `ExpoAppDelegateSubscriber`, or in Expo modules. Events are forwarded to subscribers under the new life cycle.

**You need to act if:**

- You maintain the **ios** directory by hand. See [Migrating a hand-managed iOS project](#migrating-a-hand-managed-ios-project).
- You have a bare React Native app that uses Expo modules. Run `npx install-expo-modules@latest`, which migrates the project for SDK 58 and newer.
- You override `UIApplicationDelegate` methods directly, or ship a library that does. See [Libraries and custom app delegate code](#libraries-and-custom-app-delegate-code).

## What changed

Under the application-based life cycle, `AppDelegate` created the `UIWindow` in `application(_:didFinishLaunchingWithOptions:)` and received every URL, user activity, and foreground and background callback.

Under the scene-based life cycle, UIKit creates a `UIWindowScene` and calls a scene delegate. The window is created in `scene(_:willConnectTo:options:)`, and UIKit no longer calls these `UIApplicationDelegate` methods:

- `application(_:open:options:)`
- `application(_:continue:restorationHandler:)`
- `applicationDidBecomeActive(_:)`, `applicationWillResignActive(_:)`, `applicationDidEnterBackground(_:)`, and `applicationWillEnterForeground(_:)`
- `application(_:performActionFor:completionHandler:)` for quick actions

React Native core has not adopted the scene life cycle, so Expo provides the scene infrastructure:

- `ExpoAppSceneDelegate` is a `UIWindowSceneDelegate` base class. On `scene(_:willConnectTo:options:)` it creates the window from the connecting scene and starts React Native ([expo/expo#46733](https://github.com/expo/expo/pull/46733)).
- `AppDelegate` conforms to `ExpoReactNativeFactoryProvider`, so the scene delegate can retrieve the React Native factory created in `didFinishLaunchingWithOptions`.
- `ExpoAppSceneDelegate` routes URL, user activity, Handoff, life cycle, and quick action events back through `ExpoAppDelegate`, which forwards them to your overrides and to `ExpoAppDelegateSubscriber` implementations ([expo/expo#49925](https://github.com/expo/expo/pull/49925), [expo/expo#50032](https://github.com/expo/expo/pull/50032)). Delivery stays single, so a legacy override that calls `RCTLinkingManager` itself does not produce a second `url` event.
- `npx expo prebuild` generates **SceneDelegate.swift** and a `UIApplicationSceneManifest` entry in **Info.plist** ([expo/expo#46734](https://github.com/expo/expo/pull/46734)).
- Expo packages no longer read geometry from `UIScreen.main`. `expo-modules-core` provides scene-aware helpers for the key window and screen geometry.

## Migrating a hand-managed iOS project

The quickest way to see the target state is to run `npx expo prebuild --platform ios` in a scratch copy of your project and diff the generated **ios** directory against yours. The three changes are below.

### 1. Add a scene delegate

Create **SceneDelegate.swift** next to **AppDelegate.swift** and add it to your app target:

```swift
internal import Expo

@objc(SceneDelegate)
class SceneDelegate: ExpoAppSceneDelegate {
  // Extension point for config plugins.
}
```

### 2. Declare the scene manifest

Add this to your app's **Info.plist**. The `UISceneDelegateClassName` value must resolve to the class above, so keep the `$(PRODUCT_MODULE_NAME)` prefix.

```xml
<key>UIApplicationSceneManifest</key>
<dict>
  <key>UIApplicationSupportsMultipleScenes</key>
  <false/>
  <key>UISceneConfigurations</key>
  <dict>
    <key>UIWindowSceneSessionRoleApplication</key>
    <array>
      <dict>
        <key>UISceneConfigurationName</key>
        <string>Default Configuration</string>
        <key>UISceneDelegateClassName</key>
        <string>$(PRODUCT_MODULE_NAME).SceneDelegate</string>
      </dict>
    </array>
  </dict>
</dict>
```

### 3. Update the app delegate

`AppDelegate` now conforms to `ExpoReactNativeFactoryProvider`, keeps a reference to the factory and delegate it creates, and no longer creates the window. This is the SDK 58 template:

```swift
internal import Expo
import React
import ReactAppDependencyProvider

@main
class AppDelegate: ExpoAppDelegate, ExpoReactNativeFactoryProvider {
  var window: UIWindow?

  var reactNativeDelegate: ExpoReactNativeFactoryDelegate?
  var reactNativeFactory: RCTReactNativeFactory?

  public override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    let delegate = ReactNativeDelegate()
    let factory = ExpoReactNativeFactory(delegate: delegate)
    delegate.dependencyProvider = RCTAppDependencyProvider()

    reactNativeDelegate = delegate
    reactNativeFactory = factory

    // The window is created and React Native is started by `SceneDelegate` under the
    // scene-based life cycle (required by the iOS 27 SDK).
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

class ReactNativeDelegate: ExpoReactNativeFactoryDelegate {
  // Extension point for config-plugins

  override func sourceURL(for bridge: RCTBridge) -> URL? {
    // needed to return the correct URL for expo-dev-client.
    bridge.bundleURL ?? bundleURL()
  }

  override func bundleURL() -> URL? {
#if DEBUG
    return RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: ".expo/.virtual-metro-entry")
#else
    return Bundle.main.url(forResource: "main", withExtension: "jsbundle")
#endif
  }
}
```

If your previous `AppDelegate` created the window, set a root view controller, or called `factory.startReactNative(...)` itself, remove that code. The scene delegate does it now.

## Libraries and custom app delegate code

- **Overrides on `ExpoAppDelegate` keep working.** If you override `application(_:open:options:)`, `application(_:continue:restorationHandler:)`, the active and background callbacks, or quick action handling on your `AppDelegate` subclass, Expo forwards the scene events to them. Keep calling `super`.
- **`ExpoAppDelegateSubscriber` keeps working.** Config plugins and modules that register a subscriber receive the same events as before.
- **Direct `UIApplicationDelegate` hooks do not fire.** Code that swizzles or subclasses `UIApplicationDelegate` outside of `ExpoAppDelegate`, for example a library that expects `applicationDidBecomeActive(_:)` to be called on the app delegate by UIKit, needs a scene delegate equivalent such as `sceneDidBecomeActive(_:)`, or should move to `ExpoAppDelegateSubscriber`.
- **Do not use `ExpoAppSceneDelegate` in extensions.** It is marked unavailable in app extensions and widget targets ([expo/expo#46799](https://github.com/expo/expo/pull/46799), [expo/expo#47894](https://github.com/expo/expo/pull/47894)).
- **Avoid `UIScreen.main` and `UIApplication.shared.keyWindow`.** With scenes, read geometry from the scene a view belongs to. `expo-modules-core` exposes `Utilities.keyWindow()` and scene-aware geometry helpers for modules to reuse.

## Troubleshooting

- **The app launches to a black screen on iOS 27.** The scene manifest or **SceneDelegate.swift** is missing, or `UISceneDelegateClassName` does not resolve. Compare against a freshly generated project.
- **Deep links open the app but `Linking.getInitialURL()` returns `null`.** Update to the latest SDK 58 `expo` package. Cold-start URLs under the scene life cycle were fixed in [expo/expo#47628](https://github.com/expo/expo/pull/47628).
- **A URL or user activity arrives twice.** Your `AppDelegate` override forwards to `RCTLinkingManager` and Expo does too. Remove the manual call; Expo dedupes the notification it posts, but a second manual dispatch path can still double up.
- **Quick actions or Handoff stopped working.** Make sure you are on `expo` from SDK 58 beta or newer. Forwarding for these was added in [expo/expo#49925](https://github.com/expo/expo/pull/49925) and [expo/expo#50032](https://github.com/expo/expo/pull/50032).

## Related

- [SDK 58 beta release notes](https://expo.dev/changelog/sdk-58-beta)
- [Apple: Specifying the scenes your app supports](https://developer.apple.com/documentation/uikit/specifying-the-scenes-your-app-supports)
