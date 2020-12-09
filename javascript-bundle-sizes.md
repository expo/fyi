# JavaScript bundle sizes

React Native JavaScript bundles on iOS and Android are usually significantly larger than app bundles on the web because the runtime and core components result in a ~700kb baseline size. This is not as big of a concern as on the web because JavaScript bundles are typically not downloaded at the time an app is opened, as you would on a website, rather they are embedded in the app binary or downloaded in the background with [expo-updates](https://docs.expo.io/versions/latest/sdk/updates/).

Large bundles can impact startup time because they need to be parsed and executed when the app launches, and this can be slow on low-end devices. You can improve startup time on low-end Android devices in the bare workflow by opting in to using [Hermes](https://hermesengine.dev/) and precompiling your app to Hermes bytecode at buildtime.

You can analyze the contents of your JavaScript bundles using [react-native-bundle-visualizer](https://github.com/IjzerenHein/react-native-bundle-visualizer). It will show you how much each package in your project contributes to the overall bundle size.
