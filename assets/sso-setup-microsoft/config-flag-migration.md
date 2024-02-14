# Migrating away from `--config` in Expo CLI

> Note: this document is intended for outdated versions of Expo tools, and it refers to the classic build service and the global Expo CLI. These tools have both been replaced, by EAS Build and Expo CLI respectively. If you are reading this document and this note, there is a good chance that the contents here do not apply to you.

The `--config` flag for commands like `expo start` and `expo publish` was added to provide developers with a mechanism to switch between different `app.json` configuration files to support use cases like staging environments and white labeling.

At the time the flag was introduced, dynamic configuration with `app.config.js` was not possible. Now that it is, we are deprecating the `--config` flag in favor of using `app.config.js`. The `--config` flag will continue to work for existing use cases, but it won't be supported in new scenarios, such as on EAS Build and embedding app config when building native projects locally.

The migration process itself is quick, here's how you can do it.

### Migrating from using multiple `app.json` files with `--config` to `app.config.js`

Imagine you have three config files: `app.json`, `app.staging.json`, and `app.production.json`. When you run your app locally for development, you run `expo start`. When you build and publish for staging, you run `expo build:[ios|android] --config app.staging.json` and `expo publish --config app.staging.json`. You'd use a similar sort of thing for `app.production.json`.

Here's an example `app.json` for development, if you're reading this you probably already understand what you would change for staging and produciton.

```
{
  "expo": {
    "name": "MyApp (Development)",
    "slug": "myapp",
    "icon": "./assets/icon.png",
    "splash": "./assets/splash.png",
    "extra": {
      "apiUrl": "https://localhost:3000/api"
    }
  }
}
```

We can migrate to `app.config.js` and switch the configuration that we use depending on an environment variable. We can specify the environment variable at the same time as we run a command with Expo CLI, for example: `APP_ENV=production expo build:android`. On Windows this will be slightly different and it depends on your shell, but you can use `npx cross-env APP_ENV=production expo build:android` if you're not sure what to do.

While there is essentially unlimited flexibility in how you structure your project, here are two possible ways you may do this: move all of the config to `app.config.js`, or keep the config files separate and load the appropriate file from `app.config.js`.

#### 1. **Move all config to `app.config.js`**

Create `app.config.js`, and copy and paste your config into one file.

```js
const commonConfig = {
  slug: "myapp",
  icon: "./assets/icon.png",
  splash: "./assets/splash.png",
};

module.exports = () => {
  if (process.env.APP_ENV === "production") {
    return {
      ...commonConfig,
      name: "MyApp",
      extra: {
        apiUrl: "https://production.com/api",
      },
    };
  } else if (process.env.APP_ENV === "staging") {
    return {
      ...commonConfig,
      name: "MyApp (Staging)",
      extra: {
        apiUrl: "https://staging.com/api",
      },
    };
  } else {
    return {
      ...commonConfig,
      name: "MyApp (Development)",
      extra: {
        apiUrl: "https://localhost:3000/api",
      },
    };
  }
};
```

#### 2. **Keep config in separate files, select the config in `app.config.js`**

Rename your `app.json` to `app.development.json` and create `app.config.js` with the following contents:

```js
module.exports = () => {
  if (process.env.APP_ENV === "production") {
    return require("./app.production.json");
  } else if (process.env.APP_ENV === "staging") {
    return require("./app.staging.json");
  } else {
    return require("./app.development.json");
  }
};
```

### Verifying your configuration

You can use the `expo config` command to verify that your config is switching based on environment variables as expected. For example, run `APP_ENV=production expo config --type public` to see what your app config evaluates to with the `APP_ENV` set to `production`.
