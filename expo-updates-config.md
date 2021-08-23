# Configuring expo-updates

You are here because we detected a mismatch between the values set in the `Expo.plist`/`AndroidManifest.xml` and the values set in the [app.json/app.config.js](https://docs.expo.dev/versions/v42.0.0/config/app/#updates) or with command line flags.

This suggests you are publishing to a different build that you intend!

To fix the warnings you should decide which values are correct and sync them.

### Update URL

The URL from which expo-updates will fetch update manifests.

The update URL can be configured in a couple of different ways, so make sure to check each of them if you are confused by what you are seeing. 
  1. In the app.json/app.config.js by setting the `updates.url` field. 
  2. If no updates URL is specified, the `owner` and the `slug` fields will be used to generate one: `https://exp.host/@${owner}/${slug}`. 
  3. It can also be set by passing a URL to the `--public-url` flag of the `expo export` command.

To learn more about `expo-updates` configuration look [here](https://github.com/expo/expo/blob/master/packages/expo-updates/README.md#configuration).
