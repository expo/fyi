# Prebuilt modules

> **Note**
>
> For SDK 48 and above, we do not ship modules prebuilt with iOS binaries anymore. Previously, an iOS binary for a module was prebuilt for a specific SDK and it had issues with different Xcode or React Native versions that the binary was not prebuilt against. Modules that are now built with [Expo Modules API](https://docs.expo.dev/modules/overview/) compile faster and are more lightweight in general.

As we care about the compilation time of your apps using Expo modules, we've started shipping most of them with prebuilt iOS binaries instead of just the source code. If only you use CocoaPods version `1.10.0` or higher, Xcode will use these binaries by default.

Even so, as always, there is a risk that it will lead to some unexpected issues—especially when the versions of dependent modules are incompatible with each other. We do our best in order not to lead to such a situation, but if you encounter any related issues during build time or crashes in the runtime, we kindly ask you to report this to us by [creating an issue on our monorepo](https://github.com/expo/expo/issues/new?labels=needs+review&template=bug_report.md) and to build affected modules from sources (you can find the guide below).

Modules with prebuilt binaries will not expose implementation files to your Xcode project, but just its headers and the binary. This makes contributing to these modules a bit harder because even if you modify these implementation files, they won't be seen by Xcode. The same applies to the use of [patch-package](https://www.npmjs.com/package/patch-package) and any scripts that modify the native code at `postinstall` step. Even though we don't recommend doing such modifications, we provide the ability to build individual modules from sources.

## How to build modules from sources

Just set the global Ruby variable at the top of your `Podfile` and list all the packages that you want to build from sources by their NPM package name, as below:

```ruby
$ExpoUseSources = ['expo-camera', 'expo-notifications']
```

and run `pod install` after all.

If you want to entirely opt out of this feature and build all modules from sources—just specify the environment variable `EXPO_USE_SOURCE` when running `pod install`, as below:

```
EXPO_USE_SOURCE=1 pod install
```
