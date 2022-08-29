# Missing Native Module Errors

If you are trying to run your project in Expo Go and getting the following error:

```
Your JavaScript code tried to access a native module, <ModuleName>, that isn't supported in Expo Go.
To continue development with <ModuleName>, you need to create a development build of your app.
```

you probably added an npm package to your project that isn't supported in Expo Go. Expo Go includes support for the modules in the [Expo SDK](https://docs.expo.dev/versions/latest/), and if you need to develop using a native module outside of this set, you'll need to make a development build.

A development build is like a version of Expo Go that's customized for your project. It includes all the customizations, like native modules, that you need for development. [Read more about development builds](https://docs.expo.dev/development/introduction/).

If you've installed a new native module in your project and you want to continue developing other parts of your project in Expo Go, then you can also disable these errors as explained below. [Learn more about providing fallbacks for custom native modules in Expo Go](https://docs.expo.dev/bare/using-expo-client/).

### I'm already running a development build

If you are already running a development build and seeing this similar message:

```
Your JavaScript code tried to access a native module, <ModuleName>, that doesn't exist in this development build.
Make sure you are using the newest available development build of this app and running a compatible version of your JavaScript code. If you've installed a new library recently, you may need to make a new development build.
```

you probably added an npm package to your project and tried to use it in JavaScript before making a new development build. Make sure you have the latest available development build of your project installed on the device you're trying to use. You may need to make a new development build, as described [here](https://docs.expo.dev/development/build/#running-a-build).

### How do I disable these errors?

We understand that while errors like these are intended to be helpful, sometimes they just get in the way. You can disable these errors globally by adding the following line to the top of your App.js:

```javascript
import 'expo/disable-missing-native-module-errors';
```

You can also handle errors for individual modules by switching the respective imports to optional requires in a try-catch block, like so:

```javascript
let MyModule;
try {
  MyModule = require('my-module');
} catch (e) {
  ...
}
```
