# Enabling web service workers

> Start from a template: `npx create-react-native-app -t with-workbox`

Expo's Webpack config has is capable of generating icons, splash screens, manifests, and metadata for your [progressive web app](https://developers.google.com/web/progressive-web-apps/) based on the app.json and other configuration used for your native app. However, the offline support must be added to your Webpack config manually.

1. Install the required Workbox dependencies: [package.json](https://github.com/expo/examples/blob/cfb044b07385773fac2247be968cc5c0b13be8bf/with-workbox/package.json#L16-L28)
2. Create a local `webpack.config.js` in your project: `expo customize:web`
3. Copy the template [webpack.config.js](https://github.com/expo/examples/blob/master/with-workbox/webpack.config.js)
4. Create the [`src/service-worker.js`](https://github.com/expo/examples/blob/master/with-workbox/src/service-worker.js) and [`src/serviceWorkerRegistration.js`](https://github.com/expo/examples/blob/master/with-workbox/src/serviceWorkerRegistration.js) (the file path is important).

- Optionally, you can create a [noop file](https://github.com/expo/examples/blob/master/with-workbox/src/serviceWorkerRegistration.native.js) for native.

5. In your App.js (or other entry file) [import the registration and invoke the register method](https://github.com/expo/examples/blob/cfb044b07385773fac2247be968cc5c0b13be8bf/with-workbox/App.js#L23).

## Testing

The service worker is disabled in development and requires that you build the app for production and host locally to test.

- Check to make sure you are invoking `serviceWorkerRegistration.register();` and not `serviceWorkerRegistration.unregister();` in your `./App.js`.

- `expo build:web`
- Host the files locally with `npx serve web-build`
  - This uses serve CLI to host your `/web-build` folder.
- Open: http://localhost:5000/
- In chrome, you can hard reset the service workers with <kbd>⌘+shift+R</kbd>

## Considerations

- Offline support can be confusing for many because the website will only update if all tabs and windows with your website are closed. Often it's easier to just force refresh (⌘+R).
- Service workers can only be run from a [secure origin (https)](https://developers.google.com/web/fundamentals/primers/service-workers#you_need_https). This doesn't apply to `localhost`.
- The service worker will be disabled in development mode. You can test it by building the project locally `expo build:web` and running the project from a local https server.

## Deprecated Guide

🚨 This is the deprecated guide for `@expo/webpack-config@<=0.13.3`. Here is the PR that [removed service worker support](https://github.com/expo/expo-cli/pull/3729). You can use the manual setup with any version of `@expo/webpack-config` and we highly recommend doing that.

Expo's Webpack config has all the required plugins for building a [progressive web app](https://developers.google.com/web/progressive-web-apps/), but the offline support is **disabled** by default starting in Expo SDK 39.

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
