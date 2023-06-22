# Missing Headers in EAS Update

You've made a request to the EAS Update without the required headers.

## Fetching manually

If you are manually fetching the manifest from the Expo servers with a command like `wget` or `curl`, you can specify the missing information in query parameters instead of headers for an easier debugging experience. See more details [here](https://docs.expo.dev/eas-update/debug/#inspecting-manifests-manually).

## Prebuild

If you've encountered this error after running `npx expo prebuild` and have built locally instead of using EAS Build, make sure you've followed the correct steps to configure EAS Update. See [here](https://docs.expo.dev/eas-update/build-locally/) and [here](https://docs.expo.dev/eas-update/debug/#debugging-of-native-code-while-loading-the-app-through-expo-updates) for more information.

## Verify configuration

If you've already gone through the [setup guide](https://docs.expo.dev/eas-update/getting-started/), verify that you've configured EAS Update correctly by following [this guide](https://docs.expo.dev/eas-update/debug/).
