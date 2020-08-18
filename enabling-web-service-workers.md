# Enabling web service workers

Expo's Webpack config has all the required plugins for building a [progressive web app](https://developers.google.com/web/progressive-web-apps/), but the offline support is **disabled** by default.

To enable offline support you can do the following:

- Eject the Webpack config:
  - Run `expo customize:web`
  - Select `webpack.config.js`
- Modify the config file and pass the option `offline: true` to the creator method.

```js
const createExpoWebpackConfigAsync = require("@expo/webpack-config");

module.exports = async function (env, argv) {
  const config = await createExpoWebpackConfigAsync(
    {
      ...env,
      // Passing true will enable the default Workbox + Expo SW configuration.
      offline: true,
    },
    argv
  );
  // Customize the config before returning it.
  return config;
};
```

- For more info on how service workers are setup in Expo or how you can customize the Workbox plugin, see this doc [@expo/webpack-config#service-workers](https://github.com/expo/expo-cli/tree/master/packages/webpack-config#service-workers)

## Considerations

- Offline support can be confusing for many because the website will only update if all tabs and windows with your website are closed. Often it's easier to just force refresh (⌘+R).
- Service workers can only be run from a [secure origin (https)](https://developers.google.com/web/fundamentals/primers/service-workers#you_need_https). This doesn't apply to `localhost`.
- The service worker will be disabled in development mode. You can test it by building the project locally `expo build:web` and running the project from a local https server.
