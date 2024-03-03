# Migrating from sentry-expo to @sentry/react-native

As of SDK 50, `sentry-expo` has been merged into `@sentry/react-native`, and `sentry-expo` is now deprecated. The `sentry-expo` package will continue to work in SDK 50, but we recommend moving to `@sentry/react-native`. This change allows us to deduplicate efforts and ensure a better, always up to date experience for folks that use Sentry in their projects. After migrating to `@sentry/react-native`, it is now as easy as `eas update --channel <channel> && npx sentry-expo-upload-sourcemaps dist` to publish and update upload the corresponding sourcemaps.

In this guide, we'll walk you through the steps to migrate from `sentry-expo` to `@sentry/react-native`:

- Upgrade to Expo SDK 50 or higher
- Remove `sentry-expo` and install `@sentry/react-native`
- Update your `sentry-expo` imports to `@sentry/react-native`
- Update your `app.json` to include the Sentry plugin and remove the hook
- Update your **metro.config.js** to include the Sentry transformer plugin

## Ugrade to Expo SDK 50 or higher

Learn more in the ["Upgrade Expo SDK" doc](https://docs.expo.dev/workflow/upgrading-expo-sdk-walkthrough/)

## Remove `sentry-expo` and install `@sentry/react-native`

On your terminal, run the following commands to remove `sentry-expo` and install `@sentry/react-native`:

- `npm uninstall sentry-expo` (subsitute `npm` with the package manager of your choice)
- `npx expo install @sentry/react-native`

## Update your `sentry-expo` imports to `@sentry/react-native`

- Replace `import * as Sentry from 'sentry-expo';` with `import * as Sentry from '@sentry/react-native';` in your codebase. Also, [wrap your `App` component with `Sentry.wrap()`](https://docs.expo.dev/guides/using-sentry/#initialize-sentry).
- Remove the `enableInExpoDevelopment` field from your `Sentry.init` call, if you use it.
- Replace any usage of `Sentry.Native.*` with `Sentry.*`, where `Sentry` is imported from `@sentry/react-native` as above (e.g. `Sentry.Native.captureException` -> `Sentry.captureException`)
- Replace any usage of `Sentry.Browser.*` with `Sentry.*`, where `Sentry` is imported from `@sentry/browser`.

## Update your `app.json` to include the Sentry plugin and remove the hook

- Remove the the `sentry-expo` `postPublish` hook from your `app.json` if you have it.
- Replace the `sentry-expo` plugin with the `@sentry/react-native/expo` plugin. Move any configuration under `config` from the `postPublish` hook to config for the plugin.
- Do not include your auth token in the plugin configuration. Use the `SENTRY_AUTH_TOKEN` environment variable instead ([learn more](https://docs.expo.dev/guides/using-sentry/#app-configuration)). Anything included in your plugin configuration will be present in your build and update bundles.

For example:

```json
{
  "expo": {
    "plugins": [
      [
        "@sentry/react-native/expo",
        {
          // removed the "authToken" field that was set in the plugin
          "project": "--",
          "organization": "--"
        }
      ]
    ]
  }
}
```

## Update your **metro.config.js** to include the Sentry transformer plugin

To enable this, you need to add the following to your **metro.config.js** file (if you don't have the file yet, create it in the root of your project):

```js
// This replaces `const { getDefaultConfig } = require('expo/metro-config');`
const { getSentryExpoConfig } = require('@sentry/react-native/metro');

// This replaces `const config = getDefaultConfig(__dirname);`
const config = getSentryExpoConfig(__dirname);

module.exports = config;
```

> Curious what this is for? Sentry hooks into Metro to inject a runtime polyfill to read your debug ID, which is generated at build time to uniquely identify the bundle, and then that debug ID is used to associate errors, source maps, and releases. This saves you needing to provide identification metadata to Sentry manually.

## What's next?

You're done! If you run into any issues, refer to the ["Using Sentry" guide in the Expo docs](https://docs.expo.dev/guides/using-sentry/) and the [@sentry/react-native docs](https://docs.sentry.io/platforms/react-native/).
