# Android app size

Let's address a common question: a developer runs a build for a simple app and then looks at the resulting artifact and asks something like "why is my app 50mb? that's huge!"

The reason is that **this is not actually the size of your app as it will be distributed on the Google Play Store** (or other stores). Learn more about why this is the case and how to get a more accurate picture of your app's size.

## APKs (Android Packages)

When you build an APK with Gradle in a React Native project, the default behavior is to create a universal binary, which contains all the resources for all the different device types that your app supports. For example, it includes asset for every screen size, every CPU architecture, and every language, even though a single device will only need one of each. This means you can share this one file with anybody to install directly to their device, perhaps with [Orbit](https://expo.dev/orbit) or `adb` directly, and that will work.

Of course, if you're running an incredibly popular app store that serves millions of users, you don't want to send the same 50mb file to every single user, especially if they're only going to use a fraction of the resources in the APK. This is why the Google Play Store and other app stores have a feature called "App Bundles" (Android) that allows you to upload a single binary and then the store will generate a custom binary for each user based on their device's needs.

## AABs (Android App Bundles)

On Android, all new apps submitted to the Play Store must be built as an [Android App Bundle (.aab)](https://developer.android.com/platform/technology/app-bundle).apk). Only once you have submitted the binaries to their respective stores will you be able to see the download size for various different device types.

## "So how big is my app?"

Typically, what app developers care about the "download size" on the Play Store (what the users see in the store listing when they go to download the app). This will be the size of the APK that Google Play generates from your AAB, which is tailored to the user's device. This is the size that users will see when they go to download your app.

The only truly accurate way to see what your final app size will be shipped to users is to upload your app to the stores and view the information on your developer dashboard.

## FAQ

### Why did my APK size increase after upgrading to React Native 0.73?

React Native 0.73 / Expo SDK 50 bumped the `minSdkVersion` to `23`. This had the side effect of making the default value of [`extractNativeLibs`](https://developer.android.com/guide/topics/manifest/application-element#extractNativeLibs`) now `false`.

> If set to "false", your native libraries are stored uncompressed in the APK. Although your APK might be larger, your application loads faster because the libraries load directly from the APK at runtime.

The following table shows that while the APK size increased, which may slightly impact download time for testers with [internal distribution](https://docs.expo.dev/build/internal-distribution/), the Google Play Store size remained the same.

| SDK | APK (debug variant) | APK (release variant) | AAB     | Google Play |
|-----|---------------------|-----------------------|---------|-------------|
| 49  | 66 MB               | 27.6 MB               | 28.2 MB | 11.7 MB     |
| 50  | 168.1 MB            | 62.1 MB               | 27.4 MB | 11.7 MB     |

If you would like to revert back to the previous behavior, you can set `useLegacyPackaging` to `true` in your **gradle.properties** or by using [`expo-build-properties`](https://docs.expo.dev/versions/latest/sdk/build-properties/)