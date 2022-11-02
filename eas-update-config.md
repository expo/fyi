# Configuring EAS Update

## Update URL

EAS Update fetches updates from an `UPDATE_URL` given by: `https://u.expo.dev/${projectID}`.

You can find out a projects ID by running `eas project:info`.

### App.json/App.config.js

Set the `updates.url` field in the `app.json`/`app.config.js` to the `UPDATE_URL`.

```diff
"expo": {
  ...
  "updates": {
    ...
+   "url": "https://u.expo.dev/${projectID}"
  }
}
```

## Runtime version

A runtime is is a specic JS–native interface. Updates can only run on compatible runtimes. See [runtime version docs](https://docs.expo.dev/distribution/runtime-versions/) for more information.

If you are using the managed workflow (not changing native code), than the runtime version is just the sdk version. Add the following to your `app.json`/`app.config.js`:

```diff
"expo": {
    ...
+  "runtimeVersion": {
+    "policy": "sdkVersion"
+  }
}
```

If you wish to use custom native code the `runtimeVersion` can be set to any string conforming to this [format](https://docs.expo.dev/versions/latest/config/app/#runtimeversion), or you can have us manage it for you with the `nativeVersion` policy.


## Native Configuration
If your project has native files, you will also need to configure them:

### Android

Set (or update) the `expo.modules.updates.EXPO_UPDATE_URL"` metadata in the `AndroidManifest.xml`:

```diff
  ...
  <application android:name=".MainApplication" android:label="@string/app_name" android:icon="@mipmap/ic_launcher" android:roundIcon="@mipmap/ic_launcher_round" android:allowBackup="true" android:theme="@style/AppTheme" android:usesCleartextTraffic="true">
+   <meta-data android:name="expo.modules.updates.EXPO_UPDATE_URL" android:value="https://u.expo.dev/${projectID}"/>
+   <meta-data android:name="expo.modules.updates.EXPO_RUNTIME_VERSION" android:value="${runtimeVersion}"/>
    ...
```

### iOS
Set (or update) the `EXUpdatesURL` in the `Expo.plist`:

```diff
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    ...
+   <key>EXUpdatesURL</key>
+   <string>https://u.expo.dev/${projectID}</string>
+   <key>EXUpdatesRuntimeVersion</key>
+   <string>${runtimeVersion}</string>
  </dict>
</plist>
```
