# Android URI Scheme

#### 🤔 What Happened

The package `uri-scheme` wasn't able to automatically modify your Android project's URI schemes. This is often because the `AndroidManifest.xml` is misconfigured.

#### 💡 Possible Solutions

In your project's `AndroidManifest`

- Expo/React Native: `MyApp/android/app/src/main/AndroidManifest.xml`
- Other: `MyApp/app/src/main/AndroidManifest.xml`

Ensure the following adjustments have been made:

1. Configure the `launchMode` of `MainActivity` to `singleTask` in order to receive intent on existing `MainActivity`. [Android Guide](http://developer.android.com/training/app-indexing/deep-linking.html#adding-filters).
2. Add the new `intent-filter` inside the `MainActivity` entry with a `VIEW` type action.

```xml
<!-- Somewhere in your AndroidManifest.xml -->
<activity
    android:name=".MainActivity"
    android:launchMode="singleTask">
    <!-- Don't add URI schemes to this intent filter -->
    <intent-filter>
        <action android:name="android.intent.action.MAIN" />
        <category android:name="android.intent.category.LAUNCHER" />
    </intent-filter>
    <!-- Add your URI schemes here -->
    <intent-filter>
        <!-- Ensure you have these action/categories in your filter -->
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
        <!-- This is the actual URI scheme -->
        <data android:scheme="myapp" />
    </intent-filter>
</activity>
```

> This is a native change so you'll need to rebuild your app to use it.

If your project is configured according to this doc and `uri-scheme` still isn't working, then please open an issue on [`expo/expo-cli`](https://github.com/expo/expo-cli/issues/new/choose) with `[uri-scheme]` in the title.

### 🔗 More Info

- [Source Code for uri-scheme](https://github.com/expo/expo-cli/tree/master/packages/uri-scheme)
- [Android Guide][webpack-bundle-analyzer]

[android-linking]: http://developer.android.com/training/app-indexing/deep-linking.html#adding-filters
