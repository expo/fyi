# Configuring Hermes on Android

The `jsEngine` value in app config (`app.json` or `app.config.js`) is the single source to determine the JavaScript executor for your Expo app, but if you use the bare workflow for your project, please make sure the Android native project is set up as following patches.

> This configuration is automatic for projects initialized with SDK 42 and higher.

## Patches for the Android native project

### Add `expo-jsEngine=hermes` in `android/gradle.properties`

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

### Make `enableHermes` reference the `expo.jsEngine` gradle property in `android/app/build.gradle`

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

## How this works for standalone apps on EAS Build

During the ["prebuild"](https://expo.fyi/prebuilding) stage for managed apps, config plugins will read `jsEngine` value in app config and replace `expo.jsEngine` value in `android/gradle.properties`. This makes gradle build apps with the specified JavaScript engine.

## How this works for publishing updates

Both `expo publish` and `expo export` reference `jsEngine` value in app config.  If the `jsEngine` is set to `"hermes"`, then the generated JavaScript bundle will be a Hermes bytecode bundle.

For bare workflow apps, please make sure the `jsEngine` value is consistent between app config (`app.json` or `app.config.js`) and `android/gradle.properties`.