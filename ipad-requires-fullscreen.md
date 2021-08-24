# iPad requires full screen

When submitting your app to App Store, you may encounter an error saying that your app orientation doesn't support iPad multitasking. This happens because Expo apps do not support multitasking by default and, when multitasking isn't supported, Apple requires that your app is opened in fullscreen.

To fix this, you have to force your app to require fullscreen.
- If you're using `expo build` / `expo run` / `eas build` to build your app, please set the [`expo.ios.requireFullScreen`](https://docs.expo.dev/versions/latest/config/app/#requirefullscreen) to `true` in `app.json`.
  > Prior to Expo SDK 43, this option is `true` by default.
- If you're using bare workflow and building with Xcode, please follow these steps:
  1. Open your Xcode project.
  2. Go to `General` -> `Deployment Info`.
  3. Select the `Requires full screen` checkbox.
