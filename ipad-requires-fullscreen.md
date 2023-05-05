# iPad requires full screen

When submitting your app to App Store, you may encounter an error saying that your app orientation doesn't support iPad multitasking. This happens because Expo apps do not support multitasking by default and, when multitasking isn't supported, Apple requires that your app is opened in fullscreen.

To fix this, you can force your app to require fullscreen. [Learn more](https://docs.expo.dev/versions/latest/config/app/#requirefullscreen)