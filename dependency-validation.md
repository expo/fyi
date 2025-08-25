# Configuring dependency validation

There may be circumstances where you want to use a version of a package that is different from the version recommended by `npx expo install`. In this case, you can exclude specific packages from version checking by using the `expo.install.exclude` property in your project's **package.json**.

> [!IMPORTANT]
> Using different versions than recommended may cause your app to not work properly in Expo Go. Consider using [Development Builds](https://docs.expo.dev/develop/development-builds/create-a-build) instead.

## `install.exclude`

The following commands perform a version check for the libraries installed in a project and give a warning when a library's version is different from the version recommended by Expo:

- `npx expo start` and `npx expo-doctor`
- `npx expo install` (when installing a new version of that library or using `--check` or `--fix` options)

By specifying the library under the install.exclude array in the **package.json** file, you can exclude it from the version checks:

```json
{
  "expo": {
    "install": {
      "exclude": ["expo-updates", "expo-splash-screen"]
    }
  }
}
```

See the [**package.json** configuration guide](https://docs.expo.dev/versions/latest/config/package-json/) for more options.
