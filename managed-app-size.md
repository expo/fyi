# App size when using prebuild (e.g., "managed workflow")

[EAS Build](https://docs.expo.dev/build/) will ship only the code that you include in your app. In pure JavaScript projects, it will [run prebuild](https://docs.expo.dev/workflow/prebuild/) in order to compile the project. This generates the native projects and links the dependencies that you have installed in your **package.json**. Minimum app sizes are roughly 2mb to 3mb (this changes slightly depending on the Expo SDK / React Native version).

### Use the App Store and Play Store data rather than the binary size as your benchmark

Let's address a common question: a developer runs a build then looks at the resulting artifact that they have downloaded and asks something like "why is my app 50mb? that's huge!"

The reason is that this is not actually the size of your app, in the way that you care about that. Typically you care about the "download size" on the App Store or Play Store, and you can think of this as the "upload size" *to* the App Store and Play Store instead. Both Apple and Google have techniques for slicing your build up into binaries intended specifically for certain devices.

On Android, all new apps submitted to the Play Store must be built as an [Android App Bundle (.aab)](https://developer.android.com/platform/technology/app-bundle) rather than an Android Application Package (.apk). Only once you have submitted the binaries to their respective stores will you be able to see the download size for various different device types.

The only truly accurate way to see what your final app size will be shipped to users is to upload your app to the stores and view the information on your developer dashboard.
