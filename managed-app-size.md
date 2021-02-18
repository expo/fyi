# App size in the managed workflow

A documented [limitation](https://docs.expo.io/introduction/why-not-expo/) of
managed workflow apps is that the minimum size of the standalone app binary
is not as small as a bare React Native "Hello, world!" - it's in the 15mb to
20mb range. In this post I'm going to answer some common questions that Expo
users have about app size, explain why things work how they do, and discuss
some strategies for reducing your app size and limiting growth.

## How the managed workflow works currently

If you're already familiar with how the managed workflow works, then jump ahead
to the recommendations section.

### Understanding the managed workflow through a car metaphor

Let's [use a metaphor](https://youtu.be/K8MF3aDg-bM?t=13849) to make this
easier to think about: if the native iOS and Android parts of a React Native
app are a car, then the JavaScript parts are the driver of the car. The car
has a steering wheel that the driver can use to tell it which way to go, gas
and break pedals to go and stop, and a bunch of knobs to control the air
conditioning, the radio, etc. On its own, the car does nothing - it needs
the driver to tell it what to do.

In a bare React Native app, you start off with a car that has a steering
wheel, a gas pedal, and a brake pedal. That's it. You can drive the car and
it will work perfectly well, but you will quickly find that you want more
from it. There is a good chance that you want to install a rear view mirror,
side mirrors, windshield wipers, turn signals, a navigation system, and so
on. Taking this back to React Native, this means you may want to add tools
like expo-camera, expo-updates, react-native-gesture-handler, and others.

In a managed Expo app we give you the car with all of the bells and whistles
built-in. This means that the car will have some things you won't use, but as
soon as you do need something it's typically right there for you. When you
run `expo install expo-camera` it's like teaching your driver how she can use
an existing capability of the car.

### The benefit of including the full Expo SDK in every standalone app

- **Confident over the air updates**: The primary benefit is that you can confidently update your app over-the-air
and know that the JavaScript bits will be compatible with the native bits,
because the native bits are all the same for a given SDK version. You can add
a capability to your app such as using the camera where you had not before and
do so safely with an over-the-air update.

### The downside of including the full Expo SDK

- **Larger minimum app size**: The first, and the topic of this post, is that your app is likely larger than it
would have been if you used the bare workflow because there are typically going
to be at least some libraries that you aren't using that are included in your build.

## What we are doing right now to make this better in the future

- **Automatically removing what you don't use**: Making it possible to include *only the dependencies that your app uses* in the final build in managed workflow.
- **Safe but flexible over-the-air updates**: New APIs that help you to ensure that your binaries don't receive incompatible over-the-air updates.
- **Building first-class support for custom native code in Expo apps**: We are working on a longer term change to make the main workflow support custom native code (including Expo modules from npm or GitHub that might contain native code) in Expo projects by giving direct control over the Xcode and Android Studio projects.
- **Build service support for bare apps**: Support builds also for bare React Native projects on the Expo build service, so it's easier to eject to the bare workflow if needed and keep building your project the same as before.

Some of this is already available in preview! Read more in [Expo Application Services (EAS): Build and Submit](https://blog.expo.io/expo-application-services-eas-build-and-submit-fc1d1476aa2e). Support for managed apps in EAS Build will be available in preview around the end of Q1 2021, [read more](https://docs.expo.io/build/introduction/). This will resolve the minimum app size concerns by only including the libraries that you actually use in your application at build time.

## A note about using "Hello, world!" apps to make technical decisions

As is the case with most tools, a "Hello, world!" app comparison here isn't particularly useful for making decisions about real world projects. There is no getting around the fact that managed workflow apps are currently larger, but an important factor to consider is that the binary size growth characteristics of a bare app and an managed app are very different. The primary driver for growth in your app size after "Hello, world!" is the assets that you include in the binary (see `assetBundlePatterns` below), whereas bare apps will quickly grow in size as they add capabilities that are already present in managed apps.

## Keeping managed app size small

### Use the App Store and Play Store data rather than the binary size as your benchmark

Let's address a common question: "Why is my app 50mb? I thought it was supposed to be around 20mb!"

Developers are often confused when they do a build of their app and see that the file we produce is actually in the order of 50mb rather than 20mb. The reason is that both Apple and Google have techniques for slicing your binaries up into binaries intended specifically for certain devices. We enable this on iOS automatically by building your standalone app with [bitcode enabled](https://developer.apple.com/documentation/xcode/reducing_your_app_s_size/doing_basic_optimization_to_reduce_your_app_s_size). On Android, we recommend that you build an [Android App Bundle (.aab)](https://developer.android.com/platform/technology/app-bundle) rather than an Android Application Package (.apk). Only once you have submitted the binaries to their respective stores will you be able to see the download size for various different device types.

### Use Android App Bundles

Building an APK does not allow Google to optimize your binary for different devices. Using an Android App Bundle will cut your size in the store listing nearly in half.

### Optimize image assets

Run `npx expo-optimize` in your project to automatically compress all of your image assets with minimal quality loss.

### Bundle only the assets you need, get the rest on demand

You can customize which assets are included in your standalone app builds using the `assetBundlePatterns` field in `app.json`. The default value in new projects is `**/*`, which means it will be bundle every asset that your app uses. You can change this so it includes only the assets that your app *needs* to have available all the time, and the rest will automatically be loaded at runtime over-the-air.

### Opt-in to manual "lean builds" on Android

You can set the `android.enableDangerousExperimentalLeanBuilds` property to `true` in `app.json` to opt-in to only including the Expo SDK packages that you use in your app in your Android standalone app build. This requires that you have expo-updates installed in your project (`expo install expo-updates`), but if you use the feature we also strongly recommend that you either disable over the air updates or that you are very cautious and use release channels for updates to specific binary versions.  Note that the react-native-* packages (eg: react-native-gesture-handler) that are included in the Expo SDK are not currently eligible for exclusion using this approach, only expo-* packages.

Using this approach you can get your binary size down to about 10mb on Android. There is no equivalent feature available on iOS yet, it is in progress.

### If that isn't enough, eject to bare workflow

If the above suggestions don't get you to where you need to be, the managed workflow may not be a good fit for you right now. You can eject to bare workflow and your app will include only the libraries it uses and continue to work exactly as before (perhaps with a few tweaks). However, you will (for now) not be able to use the build service anymore, and you will have to create the binaries on your own machine.
