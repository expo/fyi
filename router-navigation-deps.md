# Expo Router navigation dependencies

Expo Router is built on top of [React Navigation](https://reactnavigation.org/), and uses React context to control navigation state. This means that you have multiple copies of React Navigation in your project, which can cause conflicts if the wrong context is used.

Before investigating any issues with navigation, make sure you have the correct dependencies installed by running `npx expo install --fix` in your top level project directory. This will ensure that the correct versions of React Navigation are installed.

If you are still experiencing issues, this may be due to sub-dependencies conflicts. There are two types of sub-dependencies conflicts, multiple copies of the same version of React Navigation, and multiple versions of React Navigation. You will need to inspect your dependency tree to determine which of these issues you are experiencing. To output the dependency tree run `npm list @react-navigation/native`. This command will still work even if you are not using npm as your package manager. Other package managers like yarn and pnpm have similar commands (`yarn why @react-navigation/native`) that you may choose to use.

## Multiple copies of the same version of React Navigation

```bash
$ npm list @react-navigation/native
expo-router@1.0.0 /Github/expo-router
└─┬ expo-router@4.0.0
  ├─┬ @react-navigation/bottom-tabs@7.0.0
  │ ├─┬ @react-navigation/elements@2.0.0
  │ │ └── @react-navigation/native@7.0.0 deduped
  │ └── @react-navigation/native@7.0.0 deduped
  ├─┬ @react-navigation/native-stack@7.0.0
  │ └── @react-navigation/native@7.0.0 # This is not deduped and is nested
  └── @react-navigation/native@7.0.0
```

Package managers optimize install time over deduplication, over time this can cause multiple versions of a package being installed. If you see multiple copies of the same version of React Navigation in your dependency tree, you can 'reset' your dependency tree by running `npm dedupe` or `yarn dedupe`. This will remove the nested copy of React Navigation and use the top-level copy.

Alternatively, you can remove your `package-lock.json` or `yarn.lock` file and run `npm install` or `yarn install` respectively, forcing the package manager to re-resolve the dependency tree.

## Multiple versions of React Navigation

```bash
$ npm list @react-navigation/native
expo-router@1.0.0 /Github/expo-router
├─┬ expo-router@4.0.0
│ ├─┬ @react-navigation/bottom-tabs@7.0.0
│ │ ├─┬ @react-navigation/elements@2.0.0
│ │ │ └── @react-navigation/native@7.0.0
│ │ └── @react-navigation/native@7.0.0
│ ├─┬ @react-navigation/native-stack@7.0.0
│ │ └── @react-navigation/native@7.0.0
│ └── @react-navigation/native@7.0.0
└─┬ @react-navigation/bottom-tabs@6.5.20  # This older version is causing the conflict
  │ ├─┬ @react-navigation/elements@1.3.31
  │ │ └── @react-navigation/native@6.1.18 deduped
  │ └── @react-navigation/native@6.1.18 deduped # Now we have two versions of @react-navigation/native
```

If a dependency is installing an older version of React Navigation, you will need to update the dependency to use the same version of React Navigation as the rest of your project. Alternatively, you can force the version use by setting a [npm `overrides`](https://docs.npmjs.com/cli/v7/using-npm/config#overrides) or [yarn `resolutions`](https://classic.yarnpkg.com/en/docs/selective-version-resolutions/) in your `package.json. However, this may cause issues if the dependency is not compatible with the newer version of React Navigation.
