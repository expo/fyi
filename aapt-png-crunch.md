# Android App Packaging Tool (AAPT2) and PNG optimization

Android Gradle Plugin (AGP) will automatically run PNG Crunch to losslessly compress PNG images during release builds of your app, as part of the AAPT2 packaging process.

In some cases, you may want to disable PNG Crunch. For example, if you are already performing your own PNG optimization, then running the files through PNG Crunch again may result in larger file sizes.

You can disable it by adding the following to your `android/app/build.gradle` file:

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

If you use Continuous Native Generation (CNG), you will have to use a config plugin to apply this change.