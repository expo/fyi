# Deprecated globals

#### 🤔 What Happened

Expo has historically exported several APIs on the global `__expo` and `Expo` objects in order to make it easier for libraries to interoperate between Expo managed environments and bare React Native projects.

All of these APIs have since been extracted from the `expo` package itself and other techniques are available to solve the problem that the globals were intended to solve.

**Global exports will be removed in SDK 41.**

#### 💡 Solution

**If you are an app developer** and you just want to find out how to get rid of this warning, you should first determine if you are using the global object directly in your own codebase, and if not then it is likely from one of your dependencies.

If it's in your own codebase, then install the corresponding package and import from it instead of using the global. For example, for `Constants (expo-constants)` you would run `npx expo install expo-constants` and then change `global.__expo.Constants` to `import Constants from 'expo-constants';`.

If it's not in your own codebase, then you can search your `node_modules` directory for `__expo.[API_NAME]` - for example `__expo.Icon`, and also `Expo.[API_NAME]`. You can then check if the library has updated to remove the dependency on the global, or use [patch-package](https://www.npmjs.com/package/patch-package) to patch the issue directly in your `node_modules` and open an issue or pull request to resolve it. If you don't have time and you just want to ignore the warning, use `LogBox.ignoreLogs(...)` from react-native.

**If you are a library author**, you can provide functionality that only runs in the Expo managed workflow by using an `.expo.[js|ts|tsx]` file, [similar to this example](https://github.com/react-native-async-storage/async-storage/blob/bfd76c7508bcc35d88f6b6c8d2fd525466f77ba0/src/RCTAsyncStorage.expo.js). Alternatively, you can have consumers of your library inject the dependency that, [similar to this example](https://github.com/rt2zz/redux-persist/blame/master/README.md#L10-L19).
