# Expo SDK Xcode Compatibility

Expo SDKs support up to a specific Xcode version. If you use a newer, unsupported version, your build may fail. See [Support for Android and iOS versions](https://docs.expo.dev/versions/latest/#support-for-android-and-ios-versions).

If you build in the cloud using [EAS Build](https://docs.expo.dev/build/introduction/), make sure the [iOS server image](https://docs.expo.dev/build-reference/infrastructure/#ios-server-images) in your [build profile](https://docs.expo.dev/build/eas-json/#build-profiles) is compatible with your SDK.

If you build locally, either upgrade your SDK version or use an earlier compatible Xcode version.
