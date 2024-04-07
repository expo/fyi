# Configuring expo-updates

You are here because we detected a mismatch between the values set in the `Expo.plist`/`AndroidManifest.xml` and the values set in the [app.json/app.config.js](https://docs.expo.dev/versions/latest/config/app/#updates) or with command line flags.

This suggests you are publishing to a different build than you intend!

To fix the warnings you should decide which values are correct and sync them.

To publish an update to an existing build with different values for any of these fields, we recommend checking out an older commit or branch in your repository where these values match the build you're targeting. Always be sure to publish an update to a test or staging channel before publishing to production.

### Update URL

The URL from which expo-updates will fetch update manifests.

The update URL can be configured in a couple of different ways, so make sure to check each of them if you are confused by what you are seeing. 
  1. By setting the `updates.url` field in the `app.json`/`app.config.js`.
  2. If no updates URL is specified, the `owner` and the `slug` fields will be used to generate one: `https://exp.host/@${owner}/${slug}`. 
  3. It can also be set by passing a URL to the `--public-url` flag of the `expo export` command.

To learn more about `expo-updates` configuration look [here](https://github.com/expo/expo/blob/main/packages/expo-updates/README.md#configuration).
