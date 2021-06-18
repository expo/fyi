# Hermes Android Config

While Expo managed workflow supports Hermes, the `jsEngine` value in app config (`app.json` or `app.config.js`) is the single source to determine the JavaScript executor for React Native.
For bare workflow apps, please make sure the Android native project is set up as following patches.

## Patches for Native Project

Adding `expo-jsEngine=hermes` in `android/gradle.properties`

```diff
--- a/android/gradle.properties
+++ b/android/gradle.properties
@@ -27,3 +27,7 @@ android.enableJetifier=true

 # Version of flipper SDK to use with React Native
 FLIPPER_VERSION=0.54.0
+
+# The hosted JavaScript engine
+# Supported values: expo.jsEngine = "hermes" | "jsc"
+expo.jsEngine=hermes
```

Making `enableHermes` to reference gradle property in `android/app/build.gradle`

```diff
--- a/android/app/build.gradle
+++ b/android/app/build.gradle
@@ -78,7 +78,7 @@ import com.android.build.OutputFile
  */

 project.ext.react = [
-    enableHermes: false,
+    enableHermes: (findProperty('expo.jsEngine') ?: "jsc") == "hermes",
 ]

 apply from: '../../node_modules/react-native-unimodules/gradle.groovy'
```

## How it works for building

In ["Prebuilding"](https://expo.fyi/prebuilding) stage, config plugins will read `jsEngine` value in app config and replace `expo.jsEngine` value in `android/gradle.properties`.
This makes gradle to build apps with correct jsEngine.

## How it works for bundle publishing

Both `expo publish` and `expo export` reference `jsEngine` value in app config.
If the `jsEngine` is hermes, the generated JavaScript bundle will be a Hermes bytecode bundle.

Since in bundle publishing stage, we don't go over prebuilding and building.
For bare workflow apps, please make sure the jsEngine value to be consistent between app config (`app.json` or `app.config.js`) and `android/gradle.properties`.















