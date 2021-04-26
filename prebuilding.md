# Prebuilding

In Expo, _prebuilding_ is the process of generating the native runtime code for your React project. Prebuild can be used to automatically link and configure complex native modules that have implemented CocoaPods, autolinking, and config plugins.

## How it works

Think of prebuild like a bundler for native code, and the `app.json` like the bundler config file (`webpack.config.js` or `metro.config.js`).

When you run a bundler, it'll generate an output folder (like `dist`, or `build`) which is ready to deploy and run, this folder can be modified by hand but it's strongly discouraged because rerunning the bundler would overwrite any manual changes you made.

In `expo prebuild` the generated folders are `/ios` and `/android`, when you run prebuild it'll generate iOS and Android projects which are ready to deploy and run. If you want to upgrade a library or change a native value, simply update your `app.json` and rerun `expo prebuild` (sometimes `expo prebuild --clean` to nuke the changes). This custom managed workflow provides most of the benefits of bare, and managed workflow at the same time.

After `expo prebuild` is complete, the native `ios` and `android` folders should always be in a runnable state, if not then the project failed to prebuild.

New libraries can be added by installing them with npm or yarn, then adding them to the `plugins` array of your Expo config (`app.json` or `app.config.js`), running `expo prebuild` will ensure

However you might need to use a library that doesn't have a config plugin yet, or maybe you need to write some custom native code yourself.
For these cases you'll have to manually modify the `/ios` and `/android` folders, doing this means you'll no longer be able to safely rerun `expo prebuild`. Any new library you want to install will have to be setup manually, and all of your packages will have to be upgraded by hand (basically just standard react native development).

You can technically still rerun `expo prebuild` in bare workflow but it's strongly discouraged since config plugins may not be aware of the state of your project. For example, if you installed `expo-camera` the plugin would add a line to your Android app's `build.gradle`, if you then uninstalled `expo-camera` the only way `prebuild` would know to remove that line would be if the `build.gradle` was reset (by regenerating the entire project).

### Closer look

Running `expo prebuild` will do the following:

1. Prebuild will clone a [blank native template][native-template] and copy the `/ios`, and `/android` folders into the project if they don't exist.
2. Ensure the project is no longer using the Expo fork of `react-native` which has sandboxed AsyncStorage and disables the DevMenu for use in the Expo Go app.
3. Then the `app.json` or `app.config.js` config files are read, and a list of all the config plugins is collected.
4. CocoaPods are installed before any native changes are applied to ensure that all the proper native code is linked on iOS.
5. Finally, the config mods are evaluated, this applies changes to the native files. i.e. `name` -> rename ios name and android name. `icon` -> generate icons. `splash` -> generate splash screens.

And that's it! Most of the work is done at the last step inside the [config plugin][config-plugins] system.

### Difference between eject and prebuild

`expo prebuild` is very similar to `expo eject`, the core difference being that `eject` is intended to be run once, and `prebuild` can be used multiple times. The eject command assumes that your `ios` and `android` folders are modified by hand (bare workflow) and will warn you if they might be overwritten, whereas the prebuild command should only be used when you're `ios` and `android` folders are completely generated and can be regenerated any time (kinda like the `node_modules` folder).

## Can my project use prebuild?

Any managed Expo project can use prebuild.

If your project has native folder `/ios` or `/android`, and those projects have manual native changes (bare workflow), then you cannot use prebuild safely. You'll have to migrate your project to the custom managed workflow before you can use prebuild.

## Migrating

Project migration depends on the packages your project is using. All Expo packages support prebuild as of SDK 41, switching to Expo packages can make migration much smoother.

The first step is to ensure your iOS and Android projects build when correctly when running `yarn ios` or `yarn android`. Ensure your app is in a working state before continuing.

Next, setup version control for your project, we recommend using git. This will help you revert changes if anything goes wrong.

<!-- TODO: Automate this step -->

Create an `app.config.js` or `app.json` in your project root folder. Manually define [all of the value](https://docs.expo.io/versions/latest/config/app/) in your app.json that align with your native app. This is the hardest step. You can test your changes by running `expo prebuild` and seeing if anything critical in your `ios` or `android` folders is changing (especially in the `Info.plist` or `AndroidManifest.xml`).

Now open your `package.json` and take note of any package in your `dependencies` object that has native code. You can check [reactnative.directory](https://reactnative.directory/) and see if they say "Expo Go", if they don't then they might need extra setup.

After you have your list of plugins, check each plugin's docs to see if they mention a config plugin, if so add them to your `app.json` plugins array.

For example:

```js
module.exports = {
  plugins: ["expo-camera", "expo-facebook"],
};
```

Run `expo config --type prebuild` to ensure the plugins actually exists and no errors occur.

Finally, you can clear your `/ios` and `/android` folders, then regenerating them by running: `expo prebuild --clean`

Running `yarn ios` and `yarn android` should build successfully build the native projects. You can keep modifying the `app.json` and config plugins, then running `expo prebuild` or `expo prebuild --clean` to sync up changes until it works.

If you have an issue, you can always revert changes in git to undo.

Your project is fully migrated when you can safely delete and regenerate working native code by running `expo prebuild --clean`.

## Anti Pitch

Prebuild was created to give users the ease of creating native apps with just React and TypeScript while still allowing them to add custom native code. But this may not be right for all users. Here are some current issues with `expo prebuild`:

### Not all packages have config plugins yet

Since prebuild is new, not enough projects have a config plugin yet. Adding one is pretty straightforward so this may not be an issue for very long, but it does take a bit of time for new technology to catch up with an ecosystem.

<!-- TODO: https://reactnative.directory/ to check for plugin support -->

If you find a library that requires extra setup and doesn't have a config plugin, you should open a PR or an issue so that the maintainer is aware of the feature request.

Some packages like [`react-native-blurhash`](https://github.com/mrousavy/react-native-blurhash) and [`react-native-mmkv`](https://github.com/mrousavy/react-native-mmkv) don't require any additional native setup so they don't even need a config plugin!

Packages like [`react-native-ble-plx`](https://github.com/Polidea/react-native-ble-plx), or [`react-native-firebase`](https://github.com/invertase/react-native-firebase) do require additional setup and therefore require a config plugin to be used with `expo prebuild` and managed EAS build.

### React Native version

`expo prebuild` generates native code based on the version of `expo` you're project has installed, so a project with SDK 41 (`expo@41.0.0`) would generate a react-native 62 app.

Expo SDK lags behind the `react-native` releases because it can only upgrade when all of the modules in the Expo ecosystem are fully compatible with a version of `react-native`, this often means having to upstream bug fixes to ensure stability for our users.

### Expo platform compatibility

Prebuild can only be used for native platforms that are supported by the Expo SDK. This means iOS and Android for the time being. In time we plan to support many more platforms, but team size and limited resources prevent us from being able to maintain them at the moment. The stability of out-of-tree platforms like `react-native-macos` and `react-native-windows` are also considered.

You can still use prebuild for your `ios`, and `android` projects but any extra platforms will have to be configured manually for the time being.

With the exception of web, which doesn't require `expo prebuild` since it uses the browser instead of a custom native runtime.

### Adding simple native code changes is slower

All native changes must be added via node modules, CocoaPods, autolinking, and config plugins.

This means if you want to add some quick native file to your project your best bet is to do it in bare workflow then later add it to a module via a monorepo (we recommend [expo-yarn-workspaces](https://www.npmjs.com/package/expo-yarn-workspaces)).

If you want to do something like modifying the gradle properties file, you'll have to write a plugin for that [example](https://github.com/expo/expo/blob/1c994bb042ad47fbf6878e3b5793d4545f2d1208/apps/native-component-list/app.config.js#L21-L28). Of course this could be easily automated with helper plugin libraries, but it is a bit slower if you need to do it often. If your native project requires many custom changes, then your best bet might be to drop down to bare, and take another look at custom managed workflow in a couple months.

[config-plugins]: https://docs.expo.io/guides/config-plugins/
[native-template]: https://github.com/expo/expo/tree/master/templates/expo-template-bare-minimum
