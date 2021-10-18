# Configuring Hermes on iOS

The `jsEngine` value in app config (`app.json` or `app.config.js`) is the single source to determine the JavaScript executor for your Expo app, but if you use the bare workflow for your project, please make sure the native project is set up with the following patches.

> This configuration is automatic for projects initialized with SDK 43 and higher.

## Patches for the iOS native project

### Create `ios/Podfile.properties.json`

```json
{
  "expo.jsEngine": "hermes"
}
```

### Update `ios/Podfile` to reference the Hermes setting from `ios/Podfile.properties.json`

```diff
--- a/ios/Podfile
+++ b/ios/Podfile
@@ -4,13 +4,16 @@ require File.join(File.dirname(`node --print "require.resolve('@react-native-com

 platform :ios, '12.0'

+require 'json'
+podfile_properties = JSON.parse(File.read('./Podfile.properties.json')) rescue {}
+
 target 'HelloWorld' do
   use_expo_modules!
   config = use_native_modules!

   use_react_native!(
     :path => config[:reactNativePath],
-    :hermes_enabled => false
+    :hermes_enabled => podfile_properties['expo.jsEngine'] == 'hermes'
   )

   # Uncomment to opt-in to using Flipper
```

## How this works for standalone apps on EAS Build

During the ["prebuild"](https://expo.fyi/prebuilding) stage for managed apps, config plugins will read `jsEngine` value in app config and replace `expo.jsEngine` value in `ios/Podfile.properties.json`. CocoaPods and Xcode will link with the specified JavaScript engine accordingly.

## How this works for publishing updates

Both `expo publish` and `expo export` reference `jsEngine` value in app config.  If the `jsEngine` set to `"hermes"`, the generated JavaScript bundle will be a Hermes bytecode bundle.

For bare workflow apps, please ensure the `jsEngine` value is consistent between app config (`app.json` or `app.config.js`) and `ios/Podfile.properties.json`.
