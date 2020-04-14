# Release builds with expo-updates

When you do a release build in a bare React Native app with expo-updates, the JavaScript bundle that is included is the *most recently published bundle* - that is, the last bundle that was generated when you ran `expo publish`. Typically you will want to publish just before doing a new release build.

🚨 If you ejected from the managed workflow: even if you have published before, after ejecting and before the first time you do a release build for iOS (`yarn ios --configuration Release`) or Android (`yarn android --variant Release`), you must run `expo publish` once. You may want to verify that the `app.manifest` and `app.bundle` files described in [expo.fyi/embedded-assets](http://expo.fyi/embedded-assets) are included in your project as expected.

### Want to remove expo-updates from your app?

If you do not need over-the-air updates, you may want to remove expo-updates from your app. To remove it, do the opposite of the steps described in the [expo-updates installation instructions](https://github.com/expo/expo/blob/master/packages/expo-updates/README.md). It is included by default in projects generated with `expo init` or `expo eject` because we expect that most users will want this functionality.
