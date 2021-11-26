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
+    "url": "https://u.expo.dev/${projectID}"
  }
}
```

## Native Configuration
If your project has native files, you will also need to configure them:

### Android

Set (or update) the `expo.modules.updates.EXPO_UPDATE_URL"` metadata in the `AndroidManifest.xml`:

```diff
  ...
  <application android:name=".MainApplication" android:label="@string/app_name" android:icon="@mipmap/ic_launcher" android:roundIcon="@mipmap/ic_launcher_round" android:allowBackup="true" android:theme="@style/AppTheme" android:usesCleartextTraffic="true">
+   <meta-data android:name="expo.modules.updates.EXPO_UPDATE_URL" android:value=https://u.expo.dev/${projectID}"/>
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
  </dict>
</plist>
```
