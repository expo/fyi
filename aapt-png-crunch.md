# Android App Packaging Tool (AAPT2) and PNG optimization

Android Gradle Plugin (AGP) will automatically run PNG Crunch to losslessly compress PNG images during release builds of your app, as part of the AAPT2 packaging process.

## Common problems

### Build errors when processing .png files that not actually PNGs

In some cases, developers may end up with **.png** files that are actually JPEG files, or some other file type. When PNG Crunch attempts to compress these files, it will error and the build will fail. The error message will look something like this:

```
ERROR:/home/expo/workingdir/build/android/app/build/generated/res/createBundleReleaseJsAndAssets/drawable-mdpi/image.png: AAPT: error: file failed to compile.
```

To fix this, you can either delete the offending file, or convert it to a PNG file.

### Inflating file size by processing compressed PNG files

If you are already performing your own PNG optimization in advance of your build (which you may be doing in order to ensure the best possible compression and that the PNGs are also optimized for web and iOS), then running the files through PNG Crunch again may result in larger file sizes ([source](https://developer.android.com/topic/performance/reduce-apk-size#groovy)).

## Disabling PNG Crunch

You can disable it by setting `enablePngCrunchInReleaseBuilds` to `false` on the [`android` config in expo-build-properties](https://docs.expo.dev/versions/latest/sdk/build-properties/#pluginconfigtypeandroid).

Alternatively, if you do not use [CNG](https://docs.expo.dev/workflow/continuous-native-generation/), you can make the following change to your `android/app/build.gradle` file:

```diff
android {
  // ...existing configuration

  buildTypes {
    release {
      // ... existing configuration

      pngCrunch false
    }
  }
}
```
