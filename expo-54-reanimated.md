# Renimated and SKD 54

With the release of SDK 54, the recommended version of `react-native-reanimated` has moved to `4.x`. For many apps, upgrading will involve some manual steps, like installing the `react-native-worklets` package. 
You'll find all the necessary steps in the official migration guide provided by the Reanimated team [here](https://docs.swmansion.com/react-native-reanimated/docs/guides/migration-from-3.x/).

A key point to note: if you're using `expo-babel-preset`, it automatically manages the reanimated Babel plugin for you. 
This means there's no need to change it to `react-native-worklets/plugin`, unless you manually specified a plugin in your project configuration.

# Using SDK 54 with legacy architecture 

Although SDK 54 supports the legacy architecture, keep in mind that `react-native-reanimated` v4 is designed exclusively for the new architecture. We highly recommend making the switch to the new architecture when you can.
If that's not feasible, you can still use SDK 54 with the legacy architecture, but you will need to downgrade `react-native-reanimated` to version v3.

Since our tooling enforces the default version of packages, you will need to exclude `react-native-reanimated` from being checked by adding those lines to `package.json`:
```
{
  "expo": {
    "install": {
      "exclude": [
        "react-native-reanimated@~4.0.1"
      ]
    }
  }
}
```
