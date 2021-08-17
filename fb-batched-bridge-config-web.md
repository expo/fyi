# Cannot access \_\_fbBatchedBridgeConfig on web

#### 🤔 What Happened

The package `react-native` does not support web, so to add web support, we install `react-native-web` and alias `react-native` to `react-native-web` in the Webpack bundler (via `@expo/webpack-config`).
However, this doesn't account for deep imports that reach inside of React Native, e.g. `react-native/Libraries/Core/Devtools/getDevServer`. Sometimes packages will dangerously reach into the internals of `react-native` which breaks the `react-native-web` alias, and effectively calls into native globals like `__fbBatchedBridgeConfig` which don't exist on web.

Expo wraps this error to make it easier to understand, without Expo you may see a different message:

```
__fbBatchedBridgeConfig is not set, cannot invoke native modules
```

#### 💡 Solution

#### Remove internal imports

You can remove the import altogether, or you can move an internal import inside of a platform specific block:

```diff
- import getDevServer from "react-native/Libraries/Core/Devtools/getDevServer";

+ let getDevServer = () => { /* no-op */ }
+ if (Platform.OS !== 'web') {
+    getDevServer = require("react-native/Libraries/Core/Devtools/getDevServer");
+ }
```
