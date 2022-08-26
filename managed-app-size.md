# App size in the managed workflow

> Note: [the classic build service, `expo build:[ios|android]` is sunset and will run only until 2023](https://blog.expo.dev/turtle-goes-out-to-sea-d334db2a6b60). We do not recommend using it for any new apps, and we recommend all apps migrate to [EAS Build](https://docs.expo.dev/build/introduction/) now.

## App size with `expo build`

Using `expo build:[ios|android]` to build your managed apps can result in 15mb to 20mb base install sizes on the App Store / Play Store. To understand why this is the case, please refer to [this post](https://blog.expo.dev/expo-managed-workflow-in-2021-5b887bbf7dbb), which explains how the build process works. Long story short, the entire Expo SDK is included in your build.

## App size with EAS Build

[EAS Build](https://docs.expo.dev/build/) will ship only the code that you include in your app. In pure JavaScript projects, it will [run prebuild](https://docs.expo.dev/workflow/prebuild/) in order to compile the project. This generates the native projects and links the dependencies that you have installed in your **package.json**. Minimum app sizes are roughly 2mb to 3mb (this changes slightly depending on the Expo SDK / React Native version).

### Use the App Store and Play Store data rather than the binary size as your benchmark

Let's address a common question: a developer runs a build then looks at the resulting artifact that they have downloaded and asks something like "why is my app 50mb? that's huge!"

The reason is that this is not actually the size of your app, in the way that you care about that. Typically you care about the "download size" on the App Store or Play Store, and you can think of this as the "upload size" *to* the App Store and Play Store instead. Both Apple and Google have techniques for slicing your build up into binaries intended specifically for certain devices. We enable this on iOS automatically by building your standalone app with [bitcode enabled](https://developer.apple.com/documentation/xcode/reducing_your_app_s_size/doing_basic_optimization_to_reduce_your_app_s_size).

On Android, we recommend that you build an [Android App Bundle (.aab)](https://developer.android.com/platform/technology/app-bundle) rather than an Android Application Package (.apk). Only once you have submitted the binaries to their respective stores will you be able to see the download size for various different device types.

The only truly accurate way to see what your final app size will be shipped to users is to upload your app to the stores and view the information on your developer dashboard.