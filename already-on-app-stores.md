If you have a new version of your app that you've built with Expo tools and you'd like to replace your existing app on the app stores with it, how do you do that? It's actually pretty straightforward.

## iOS

- Configure your Expo app to use the same [bundle identifier](https://docs.expo.dev/versions/latest/config/app/#bundleidentifier) on iOS as your existing App Store listing.
- If you're using EAS Build, then you can build and let automatic credential management use the rest. If you're not, then you can reuse whatever your previous deployment process was.

## Android

- Configure your Expo app to use the application identifier (called ["package" in app.json](https://docs.expo.dev/versions/latest/config/app/#package)) on Android as your existing Play Store listing.
- Ensure that you sign your Android app using your existing keystore. If you're using EAS Build, you can learn more about how to do that in the ["Using existing credentials" guide](https://docs.expo.dev/app-signing/existing-credentials/).

## Other considerations

You may want to consider how to migrate your application data. This may require [writing a native module](https://docs.expo.dev/modules/overview/) to be able to read it and write it to a new location / format. For example, to ensure users remain authenticated.