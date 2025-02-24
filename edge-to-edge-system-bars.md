# `expo-status-bar` / `expo-navigation-bar` and edge-to-edge

Using `expo-status-bar` or `expo-navigation-bar` in apps with edge-to-edge layout enabled may cause unexpected behavior, as they currently use [deprecated APIs](https://developer.android.com/about/versions/15/behavior-changes-15#deprecated-apis). This could result in the feature not working entirely.

Instead, use the `SystemBars` component from [`react-native-edge-to-edge`](https://github.com/zoontek/react-native-edge-to-edge):

_package.json_

```diff
{
  "dependencies": {
-   "expo-navigation-bar": "<version>",
-   "expo-status-bar": "<version>",
+   "react-native-edge-to-edge": "<version>"
  }
}
```

_in your app_

```diff
import { useEffect } from "react";
- import * as NavigationBar from "expo-navigation-bar";
- import { StatusBar } from "expo-status-bar";
+ import { SystemBars } from "react-native-edge-to-edge";

export default function App() {
- useEffect(() => {
-   NavigationBar.setButtonStyleAsync("dark");
- }, []);

  return (
    <>
-     <StatusBar style="light" />
+     <SystemBars style={{ statusBar: "light", navigationBar: "dark" }} />
    </>
  );
}
```
