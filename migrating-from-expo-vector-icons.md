# Migrating from @expo/vector-icons to react-native-vector-icons

Since SDK 54, we recommend using packages from [@react-native-vector-icons](https://github.com/oblador/react-native-vector-icons) instead of `@expo/vector-icons`. This short guide will help you migrate your existing code. In case you encounter a problem, [open an issue](https://github.com/expo/vector-icons).

## Installation

First, install the new package(s) according to the table below, and replace the imports. 

> [!WARNING]
> Mixing the same icon families from `@expo/vector-icons` and `@react-native-vector-icons/*` in a project leads to hard-to-diagnose issues, ensure you replace all imports.


| Old Import                                  | New Import                                         |
| ------------------------------------------- | -------------------------------------------------- |
| `@expo/vector-icons/AntDesign`              | `@react-native-vector-icons/ant-design`            |
| `@expo/vector-icons/Entypo`                 | `@react-native-vector-icons/entypo`                |
| `@expo/vector-icons/EvilIcons`              | `@react-native-vector-icons/evil-icons`            |
| `@expo/vector-icons/Feather`                | `@react-native-vector-icons/feather`               |
| `@expo/vector-icons/FontAwesome`            | `@react-native-vector-icons/fontawesome`           |
| `@expo/vector-icons/FontAwesome5`           | `@react-native-vector-icons/fontawesome5`          |
| `@expo/vector-icons/FontAwesome6`           | `@react-native-vector-icons/fontawesome6`          |
| `@expo/vector-icons/Fontisto`               | `@react-native-vector-icons/fontisto`              |
| `@expo/vector-icons/Foundation`             | `@react-native-vector-icons/foundation`            |
| `@expo/vector-icons/Ionicons`               | `@react-native-vector-icons/ionicons`              |
| `@expo/vector-icons/MaterialCommunityIcons` | `@react-native-vector-icons/material-design-icons` |
| `@expo/vector-icons/MaterialIcons`          | `@react-native-vector-icons/material-icons`        |
| `@expo/vector-icons/Octicons`               | `@react-native-vector-icons/octicons`              |
| `@expo/vector-icons/SimpleLineIcons`        | `@react-native-vector-icons/simple-line-icons`     |
| `@expo/vector-icons/Zocial`                 | `@react-native-vector-icons/zocial`                |

## Set up `expo-font` config plugin

This is an optional step that can be beneficial to your app's performance, as it avoids loading icon font files at runtime. [Read more](https://github.com/oblador/react-native-vector-icons/blob/master/docs/SETUP-EXPO.md).

## Remove the old package

After migrating your imports, remove the old package:

```bash
npm uninstall @expo/vector-icons
# or
yarn remove @expo/vector-icons
```

## Examples

### Before (using @expo/vector-icons)

```tsx
import React from "react";
import Ionicons from "@expo/vector-icons/Ionicons";
import MaterialIcons from "@expo/vector-icons/MaterialIcons";
import FontAwesome from "@expo/vector-icons/FontAwesome";

export default function IconExample() {
  return (
    <>
      <Ionicons name="md-checkmark-circle" size={32} color="green" />
      <MaterialIcons name="favorite" size={24} color="red" />
      <FontAwesome name="heart" size={20} color="pink" />
    </>
  );
}
```

### After (using react-native-vector-icons)

```tsx
import React from "react";
import Ionicons from "@react-native-vector-icons/ionicons";
import MaterialIcons from "@react-native-vector-icons/material-icons";
import FontAwesome from "@react-native-vector-icons/fontawesome";

export default function IconExample() {
  return (
    <>
      <Ionicons name="md-checkmark-circle" size={32} color="green" />
      <MaterialIcons name="favorite" size={24} color="red" />
      <FontAwesome name="heart" size={20} color="pink" />
    </>
  );
}
```

### Custom Icon Sets

If you were using `createIconSet` from `@expo/vector-icons`, replace it with the equivalent from `@react-native-vector-icons/common`:

```tsx
// Before
import createIconSet from "@expo/vector-icons/createIconSet";

// After
import createIconSet from "@react-native-vector-icons/common";
```

## Troubleshooting

### Icon Names

Due to updated icon families, some icon names might be slightly different. Check the [react-native-vector-icons directory](https://oblador.github.io/react-native-vector-icons/).

## Need Help?

- [react-native-vector-icons documentation](https://github.com/oblador/react-native-vector-icons)
- [Icon directory](https://oblador.github.io/react-native-vector-icons/)
- [`@expo/vector-icons` issue tracker](https://github.com/expo/vector-icons)
