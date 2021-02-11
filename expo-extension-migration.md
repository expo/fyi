# Migration off the expo extension

> TL;DR: Starting in Expo SDK 40, the `.expo.js` extension is deprecated in favor of optional imports.

Files with the `.expo.*` extension will no longer be used in SDK 41+, and the `EXPO_TARGET` environment variable is deprecated.

## Background

In the past, it was impossible to import files that didn't exist using the Metro bundler. Even if you wrapped a require statement in a try/catch, Metro would just fail to bundle instead of throwing. We've upstreamed a fix in SDK 40+ which correctly throws an error:

```ts
try {
  // If expo-camera doesn't exist, Metro would just crash instead of throwing :(
  require("expo-camera");
} catch (error) {
  // Starting in SDK 40+ the error will be thrown meaning you can optionally check if modules exist!
}
```

To combat this, we created the `.expo.js` extension which would get used in the Expo client or legacy turtle V1 builds (`expo build`). This feature was primarily used by library authors who wanted to support standalone versions of expo packages like `react-native-camera` if `expo-camera` wasn't installed in the project. In SDK 40+ this can be done using try/catch syntax.

## Examples

### Alternative Modules

If you wanted to use `expo-camera` in your app when running in Expo Go, but some other package when running outside of Expo Go, you had to use a workflow extension.

#### Before

You used to have to create a "workflow specific" file extension before optional imports

`Camera.expo.js` (this file would be used in Expo environments)

```ts
export * from "expo-camera";
```

`Camera.js` (this file would be used in all other environments)

```ts
export * from "another-camera-package";
```

#### After

Now you can simply use the optional import syntax:

`Camera.js`

```js
let camera;
try {
  camera = require("expo-camera");
} catch {
  camera = require("another-camera-package");
}
module.exports = camera;
```

### Detecting Expo

If you wanted to detect if you were running in Expo go, you needed to use workflow extensions, instead, you should use `expo-constants`.

#### Before

`isExpo.expo.js` (this file would be used in Expo environments)

```ts
export const isExpo = true;
```

`isExpo.js` (this file would be used in all other environments)

```ts
export const isExpo = false;
```

#### After

Now you can use a far more reasonable approach:

```ts
let isExpo = false;
try {
  const Constants = require("expo-constants");
  // True if the app is running in an `expo build` app or if it's running in Expo go.
  isExpo =
    Constants.executionEnvironment === "standalone" ||
    Constants.executionEnvironment === "storeClient";
} catch {}
```

## Reasoning

We've decided to deprecate the `.expo.*` workflow extension as soon as possible because it's a nonstandard bundler feature which adds increased complexity to React projects.
Lower complexity means it's easier to make other bundlers and tools work with Expo.

## Resources

- Optional imports discussion [discussions-and-proposals#120](https://github.com/react-native-community/discussions-and-proposals/issues/120)
- Optional imports PR [metro#511](https://github.com/facebook/metro/pull/511)
