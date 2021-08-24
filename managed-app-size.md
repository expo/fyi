# App size in the managed workflow

Using `expo build:[ios|android]` to build your managed apps can result in 15mb to 20mb base install sizes. To understand why this is the case, please refer to [this post](https://blog.expo.dev/expo-managed-workflow-in-2021-5b887bbf7dbb), which explains how the build process works. Long story short, the entire Expo SDK is included in your build.

The primary benefit of including the entire Expo SDK is that you can confidently update your app over-the-air and know that the JavaScript bits will be compatible with the native bits, because the native bits are all the same for a given SDK version. You can add a capability to your app such as using the camera where you had not before and do so safely with an over-the-air update.

## Use EAS Build instead of `expo build` for smaller app sizes

If app size is more important to you than easier over-the-air-updates, you may want to consider using [EAS Build](https://docs.expo.dev/build/introduction/) instead. You can still use over-the-air updates in your apps built with EAS Build, you just need to [be a bit more careful](https://docs.expo.dev/build/updates/). As of April, 2021, you can build your managed apps with EAS Build to get up to a 10x reduction in download and install size. [Learn more in this post](https://blog.expo.dev/eas-build-april-preview-update-ebd7dff9dd25), and refer to [this guide for migrating from `expo build`](https://docs.expo.dev/build-reference/migrating/).

## Other tips

### Use the App Store and Play Store data rather than the binary size as your benchmark

Let's address a common question: "Why is my app 50mb? I thought it was supposed to be around 20mb!"

Developers are often confused when they do a build of their app and see that the file we produce is actually in the order of 50mb rather than 20mb. The reason is that both Apple and Google have techniques for slicing your binaries up into binaries intended specifically for certain devices. We enable this on iOS automatically by building your standalone app with [bitcode enabled](https://developer.apple.com/documentation/xcode/reducing_your_app_s_size/doing_basic_optimization_to_reduce_your_app_s_size). On Android, we recommend that you build an [Android App Bundle (.aab)](https://developer.android.com/platform/technology/app-bundle) rather than an Android Application Package (.apk). Only once you have submitted the binaries to their respective stores will you be able to see the download size for various different device types.

### Use Android App Bundles

Building an APK does not allow Google to optimize your binary for different devices. Using an Android App Bundle will cut your size in the store listing nearly in half.

### Optimize image assets

Run `npx expo-optimize` in your project to automatically compress all of your image assets with minimal quality loss.