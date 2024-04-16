# Recommended Additional Setup for Firebase Authentication

Follow the steps described in this guide to enable auth persistence depending on the Firebase version your project uses.

## For Firebase JS SDK version 10 and above

### Enable auth persistence

With the release of `v10.0.0`, the Firebase library [briefly supported local persistence](https://firebase.google.com/support/release-notes/js#version_1030_-_august_22_2023) but with the release of `v10.3.0`, it recommends explicitly importing AsyncStorage as such:

```js
import { initializeApp } from "firebase/app";
import { initializeAuth, getReactNativePersistence } from "firebase/auth";
import AsyncStorage from "@react-native-async-storage/async-storage";

const firebaseConfig = {
  // config copied from Firebase console when creating a web app
};

const app = initializeApp(firebaseConfig);

const auth = initializeAuth(app, {
  persistence: getReactNativePersistence(AsyncStorage),
});

// getAuth() can be used any time after initialization
```

## For Firebase JS SDK version 9 and below

### Switch to the React Native Persistence Manager

The Firebase JS SDK has a persistence manager that uses local storage in React Native. You can update your initialization code as such:

```js
import { initializeApp } from "firebase/app";
import { initializeAuth, reactNativeLocalPersistence } from "firebase/auth";

const firebaseConfig = {
  // config copied from Firebase console when creating a web app
};

const app = initializeApp(firebaseConfig);

// add this to init auth with persistence
initializeAuth(app, {
  persistence: reactNativeLocalPersistence,
});
```

Depending on your version of Firebase and React Native, you may see deprecation warnings or failures, as Firebase uses React Native core local storage. If that is the case, the instructions for using a custom persistence manager can help.

### Use a Custom Persistence Manager

Firebase Auth can be initialized with a custom persistence manager in cases where it doesn't support `@react-native-async-storage/async-storage`:

```js
import { initializeApp } from "firebase/app";
import AsyncStorage from "@react-native-async-storage/async-storage";
import { initializeAuth, getReactNativePersistence } from "firebase/auth";

const firebaseConfig = {
  // config copied from Firebase console when creating a web app
};

const app = initializeApp(firebaseConfig);

// add code below to init auth with custom persistence

const myReactNativeLocalPersistence = getReactNativePersistence({
  getItem(...args) {
    // Called inline to avoid deprecation warnings on startup.
    return AsyncStorage.getItem(...args);
  },
  setItem(...args) {
    // Called inline to avoid deprecation warnings on startup.
    return AsyncStorage.setItem(...args);
  },
  removeItem(...args) {
    // Called inline to avoid deprecation warnings on startup.
    return AsyncStorage.removeItem(...args);
  },
});

initializeAuth(app, {
  persistence: myReactNativeLocalPersistence,
});
```

### Web Compatibility

The above setup works for web when [`web.bundler` is set to `"metro"`]((https://docs.expo.dev/versions/latest/config/app/#bundler)) in your app config (**app.json**/**app.config.js**/**app.config.ts**) , in addition to iOS and Android. If you're using Webpack, the `getReactNativePersistence` import will not work. You can instead initialize Firebase as such:

```js
import { initializeApp } from "firebase/app";
import { initializeAuth, browserLocalPersistence } from "firebase/auth";

const firebaseConfig = {
  // config copied from Firebase console when creating a web app
};

const app = initializeApp(firebaseConfig);

initializeAuth(app, {
  persistence: browserLocalPersistence,
});
```

Note that `browserLocalPersistence` will not exist when running on iOS and Android, so you will need to use `Platform` to switch between configuration methods for web and native.
