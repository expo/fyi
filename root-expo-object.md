# Migrating from the root-level `expo` object in the Expo config

Previous versions of Expo CLI encouraged users to have a top-level `expo: {}` object in the project's Expo config (`app.json`), this extraneous object contained all of the project config. When support for `app.config.js` and `app.config.json` were added, the root-level `expo` object became optional.

You can instead use the root-level object in the Expo config (`app.json`) to configure your project and [Expo CNG](https://docs.expo.dev/workflow/continuous-native-generation/):

**app.json**

```diff
{
-  "expo": {
    "name": "beta",
    "icon": "./icon.png",
    "plugins": [
        ["expo-router", { }]
    ]
-  }
}
```

> We recommend Visual Studio Code users install the [Expo Tools](https://marketplace.visualstudio.com/items?itemName=expo.vscode-expo-tools) extension to get auto-completion of properties in **app.json** files.

### Resolution with `expo` object

If the project Expo config has a root-level `expo` object, then all other fields will be removed:

**Input app.json**

```json
{
  "name": "alpha",
  "displayName": "alpha",
  "expo": {
    "name": "beta"
  }
}
```

When this config is read by Expo CLI, the root-level `name` and `displayName` will be removed:

**Output app.json**

```json
{
  "name": "beta"
}
```

### Migrating the config

Starting in Expo 51, a warning will be printed informing you to remove the root-level `name` and `displayName` properties or migrate the root-level `expo` object (preferred).

To migrate, simply remove the extraneous `expo` object:

**Old app.json**

```diff
{
-    "name": "alpha",
-    "displayName": "alpha",
-    "expo": {
        "name": "beta"
-    }
}
```

The new config should look as follows (`displayName` is not a supported property of Expo CLI):

**New app.json**

```json
{
  "name": "beta"
}
```

### Arbitrary fields

If you want to use arbitrary fields in the Expo config, use the `extra` object in the Expo config. Learn more: [Configuring the Expo config » `extra`](https://docs.expo.dev/versions/latest/config/app/#extra).
