# Why `Constants.expoConfig` replaces `Constants.manifest`

`Constants.manifest` is deprecated and will be removed in SDK 50. Its replacement is `Constants.expoConfig`. This page explains this change.

### What manifests are

The manifest in an Expo app specifies the app's assets (like its JavaScript) and configuration data (often fields from app.json). Previously, `Constants.manifest` was the way to access an app's configuration data. With SDK 49, [`Constants.expoConfig`](https://docs.expo.dev/versions/latest/sdk/constants/#expoclientconfig) replaces `Constants.manifest` for this purpose.

### Why this change is happening

The reason for this change is that manifests for [modern updates](https://docs.expo.dev/technical-specs/expo-updates-1/) are different than manifests for classic updates. `Constants.expoConfig` is a consistent way to access an app's configuration data regardless of which type of manifest the app uses. `Constants.expoConfig` also works across Expo Go, development builds, and production builds. And it's consistent whether or not an app is running the code embedded in the build or a downloaded update.

Related to this change, in SDK 49, Expo CLI serves projects in development using the modern updates protocol by default. Before SDK 49, Expo CLI would use the modern updates protocol for apps that had [migrated](https://docs.expo.dev/eas-update/migrate-from-classic-updates/) and the classic updates protocol for apps that hadn't. Now, Expo CLI always defaults to the modern updates protocol since SDK 49 is the [last version](https://blog.expo.dev/sunsetting-expo-publish-and-classic-updates-6cb9cd295378) that will support classic updates.

To make this migration smoother, you can temporarily opt back in to using the classic updates protocol by specifying `"updates": { "useClassicUpdates": true }` in **app.json**. This option is available in SDK 49 only and will not be present in SDK 50.

### How this change may impact you

If your application code or its dependencies use `Constants.manifest`, they will need to switch to using `Constants.expoConfig` instead. We also recommend using `Constants.expoConfig` instead of `Constants.manifest2` where possible. 
