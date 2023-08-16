# Recommended Additional Setup for Firebase Authentication
With the release of [Firebase JS SDK `v10.0.0`](https://npmjs.com/firebase), React Native Persistence is now built directly into the library. If you are using any version **above** `v10.0.0` of Firebase JS SDK, you **do not need to follow any of the steps on this page**.

If you are using a version below `v10.0.0` of the SDK, follow the steps described in this guide.

## Switching to the React Native Persistence Manager
The Firebase JS SDK has a persistence manager that uses local storage in React Native. You can update your initialization code as such:
```js
import { initializeApp } from "firebase/app";
import { initializeAuth, reactNativeLocalPersistence } from "firebase/auth"

const firebaseConfig = {
  // config copied from Firebase console when creating a web app
};

const app = initializeApp(firebaseConfig);

// add this to init auth with persistence
initializeAuth(app,
  {
    persistence: reactNativeLocalPersistence
  }
)
```
Depending on your version of Firebase and React Native, you may see deprecation warnings or failures, as Firebase uses React Native core local storage. If that is the case, the instructions for using a custom persistence manager can help.

## Using a Custom Persistence Manager
Firebase Auth can be initialized with a custom persistence manager in cases where it doesn't support `@react-native-async-storage/async-storage`:
```js
import { initializeApp } from "firebase/app";
import AsyncStorage from '@react-native-async-storage/async-storage';
import { initializeAuth, getReactNativePersistence } from "firebase/auth"

const firebaseConfig = {
  // config copied from Firebase console when creating a web app
};

const app = initializeApp(firebaseConfig);

// add code below to init auth with custom persistence

const myReactNativeLocalPersistence =
  getReactNativePersistence({
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

initializeAuth(app,
  {
    persistence: myReactNativeLocalPersistence
  }
)
```

## Web Compatiblity
The above setup works for web when **web.bundler** is set to "metro" in your Expo Config, in addition to iOS and Android. If you're using Webpack, the `getReactNativePersistence` import will not work. You can instead initialize Firebase as such:
```js
import { initializeApp } from "firebase/app";
import { initializeAuth, browserLocalPersistence } from "firebase/auth"

const firebaseConfig = {
  // config copied from Firebase console when creating a web app
};

const app = initializeApp(firebaseConfig);

initializeAuth(app,
   {
    persistence: browserLocalPersistence
  }
)
```

Note that `browserLocalPersistence` will not exist when running on iOS and Android, so you will need to use `Platform` to switch between configuration methods for web and native.
