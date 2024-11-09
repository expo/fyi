# Expo Router navigation dependencies

Expo Router is built on top of [React Navigation](https://reactnavigation.org/), and uses React context to control navigation state. Having multiple copies of React Navigation in your project's dependencies can cause conflicts and unexpected behavior.

Most dependency issues can be resolved by running `npx expo install --fix` in your top level project directory.

If you continue to have issues it may be due to sub-dependencies conflicts, where you may have multiple versions of React Navigation, or the same version of React Navigation installed multiple times. You will need to inspect your dependency tree to determine which of these issues you are experiencing. To output the dependency tree run `npm list @react-navigation/native`. This command will work even if you are not using `npm` as your package manager, however you may choose to use similar commands such as `yarn why @react-navigation/native`.

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

If a dependency is installing an older version of React Navigation, you will need to update the dependency to use the same version of React Navigation as the rest of your project. Alternatively, you can force the version used by setting a [npm `overrides`](https://docs.npmjs.com/cli/v7/using-npm/config#overrides) or [yarn `resolutions`](https://classic.yarnpkg.com/en/docs/selective-version-resolutions/) in your `package.json. However, this may cause issues if the dependency is not compatible with the newer version of React Navigation.

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

Package managers optimize install time over deduplication and over time this can cause multiple versions of a package being installed. If you see multiple copies of the same version of React Navigation in your dependency tree, you can run either `npm dedupe` or `yarn dedupe` to remove these unneeded duplicate dependencies.

Alternatively, you can remove your `node_modules` folder and your `package-lock.json` / `yarn.lock` file and run `npm install` or `yarn install` respectively. This will force your package manager to re-resolve the dependency tree.
