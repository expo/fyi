# Replacing your existing app on the app stores

If you have a new version of your app built with Expo tools and you'd like to replace your existing app on the app stores with it, here's a simple guide to help you through the process.

## iOS

1. **Configure bundle identifier:**

   - Ensure your Expo app uses the same [bundle identifier](https://docs.expo.dev/versions/latest/config/app/#bundleidentifier) as your existing App Store listing.

2. **Build and deployment:**

   - If you're using EAS Build, then you can build and let automatic credential management use the rest. If you're not, then you can reuse whatever your previous deployment process was.

## Android

1. **Configure application identifier:**

   - Ensure your Expo app uses the same application identifier ([`package` in app config](https://docs.expo.dev/versions/latest/config/app/#package)) as your existing Play Store listing.

2. **Signing the app using existing keystore:**

   - Ensure that you sign your Android app using your existing keystore. If you're using EAS Build, you can learn more about how to do that in the ["Use existing credentials" guide](https://docs.expo.dev/app-signing/existing-credentials/).

## Other considerations

You may want to consider how to migrate your application data. This may require [writing a native module](https://docs.expo.dev/modules/overview/) to be able to read it and write it to a new location / format. For example, to ensure users remain authenticated.