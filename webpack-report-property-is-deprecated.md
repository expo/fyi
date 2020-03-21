# Webpack `report` property is deprecated

#### 🤔 What Happened

In Expo web beta, the [`@expo/webpack-config`][webpack-config] had bundle reporting features installed by default, these features could be enabled in two different ways (which are both now deprecated).

**Version 1**: `app.json`

Enabling the [`webpack-bundle-analyzer`][webpack-bundle-analyzer] via the Expo config `app.json`. This was removed to cut down on untyped versioned configs which can't change that often (once quarterly).

```js
{
  expo: {
    web: {
      build: {
        report: {
          /* various settings */
        },
      },
    },
  },
}
```

**Version 2**: `webpack.config.js`

Enable and configure the [`webpack-bundle-analyzer`][webpack-bundle-analyzer] via the custom `webpack.config.js` config. This was removed to cut down on 'hidden features' that you install by default, removing it made `expo-cli` install and update faster.

```js
const createExpoWebpackConfigAsync = require('@expo/webpack-config');

module.exports = (env, argv) => {
  return createExpoWebpackConfigAsync(
    {
      ...env,
      report: true, // { /* various settings */ },
    },
    argv,
  );
};
```

#### 💡 Possible Solutions

The optimal approach is to simply install the package when you need it, then add it to the Webpack config. This gives you more control on the version of [`webpack-bundle-analyzer`][webpack-bundle-analyzer] and the settings it uses.

1. Install `yarn add -D webpack-bundle-analyzer`
2. Customize the Webpack config:

   - `expo customize:web`
   - Select `webpack.config.js`
   - If you've already installed the [`@expo/webpack-config`][webpack-config] package, ensure it's updated.

3. Add the Webpack plugin to the list of plugins:

```js
const createExpoWebpackConfigAsync = require('@expo/webpack-config');
// Import the bundle analyzer
const { BundleAnalyzerPlugin } = require('webpack-bundle-analyzer');

module.exports = async (env, argv) => {
  const config = await createExpoWebpackConfigAsync(env, argv);

  // It's best to add this only in production builds.
  if (env.mode === 'production') {
    config.plugins.push(
      new BundleAnalyzerPlugin({
        // In the past we would default to outputting in the `web-report` folder, you don't need to do this.
        path: 'web-report',
      }),
    );
  }
  return config;
};
```

### 🔗 More Info

- [`webpack-bundle-analyzer`][webpack-bundle-analyzer]
- [`@expo/webpack-config`][webpack-config]

[webpack-bundle-analyzer]: https://www.npmjs.com/package/webpack-bundle-analyzer
[webpack-config]: https://www.npmjs.com/package/@expo/webpack-config
