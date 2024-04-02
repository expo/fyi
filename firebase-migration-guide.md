# Migrating from Expo Firebase to React Native Firebase

The `expo-firebase-analytics` and `expo-firebase-recaptcha` packages allowed the use of some Firebase features on Classic Builds, Expo Go, and Expo for Web, but developers often encountered version conflicts when trying to use them alongside the rest of the Firebase suite. With EAS Build and development builds, it is much easier to use [React Native Firebase](https://rnfirebase.io/) directly in your entire development workflow, so these `expo-firebase-*` packages have been deprecated and will be removed in SDK 48.

In this guide, we will migrate from the Expo Firebase packages to React Native Firebase by:

- Replacing the Expo Firebase packages with their React Native Firebase equivalents
- Replacing the use of Expo Go for testing with a [development build](https://docs.expo.dev/development/introduction/) customized to your project's needs
- Testing the updated code on your development build

> This guide is intended for those who have been previously using the Expo Firebase packages successfully and are running on SDK's 46, 47, or 48. If you're adding Firebase to your app for the first time, see the [Using Firebase](https://docs.expo.dev/guides/using-firebase/) guide.

## Set up React Native Firebase

On your terminal, run the following commands to remove `expo-firebase-analytics` and install the React Native Firebase packages and other dependencies:

- `npm remove expo-firebase-analytics`
- `npx expo install @react-native-firebase/app @react-native-firebase/analytics`
- `npx expo install expo-build-properties`

Then, in your [Expo config](https://docs.expo.dev/workflow/glossary-of-terms/#expo-config) file, add `expo-build-properties` to the `plugins` array with the following configuration:

```json app.json
{
  "expo": {
    "plugins": [
      [
        "expo-build-properties",
        {
          "ios": {
            "useFrameworks": "static"
          }
        }
      ]
    ]
  }
}
```

If you are using the Bare Workflow, see [React Native Firebase's installation instructions](https://rnfirebase.io/#bare-workflow).

## Update analytics requests

Firebase Analytics requests in React Native Firebase are almost the same &mdash; mostly, they are imported a little differently. Update your code as shown here:

```diff
// update imports
- import * as Analytics from "expo-firebase-analytics";
+ import analytics from "@react-native-firebase/analytics";

// update each `Analytics` reference to call `analytics()`
- Analytics.logEvent("test_analytics_event", {
-  additionalParam: "test",
- });
+ analytics().logEvent("test_analytics_event", {
+  additionalParam: "test",
+ });
```

> Note: `logEvent` is asynchronous, so be sure to use `await` in front of the function call if you are using it in an `async` function.

## Create a development build

If you have been using Expo Go for development and testing, at this point, you will need to migrate to a [development build](https://docs.expo.dev/development/introduction/), as Expo Go does not include the native code used in React Native Firebase.

1. Install `expo-dev-client` in your project by running the following command:

```shell
npx expo install expo-dev-client
```

2. [Follow these instructions from React Native Firebase library docs](https://rnfirebase.io/#managed-workflow) on how to add the config plugin(s) and provide paths to Google's service JSON files in the Expo config file.

3. After following these steps, you can [create a development](https://docs.expo.dev/development/create-development-builds/) build and install it on your test device or simulator.

> **Note:** If you are already using a development build, rebuild your app, as your native code dependencies have changed.

## Test your changes

Test your changes locally on your development build by running:

`npx expo start --dev-client`

Then follow the prompts on the terminal to run it on your simulator, or scan the QR code to run it on your device. Try an action that will register a Firebase Analytics event. Note that it may take a few minutes for events to show up in the Firebase Console.

## Conclusion

Now that you have your own development build, you can use any package from the React Native Firebase library in your development and testing workflow. You're only minutes away from adding [any additional native functionality you'd like](https://docs.expo.dev/development/getting-started/#customizing-your-runtime).

## Other migration scenarios

### Analytics for Expo for web

React Native Firebase only supports iOS and Android. If you previously used `expo-firebase-analytics` to send events from an Expo for web client, you will need to use the Firebase JavaScript (JS) SDK. In the Firebase Console, go to Project Settings, and then your web app, and copy the code under "SDK setup and configuration." You can switch between React Native Firebase and Firebase JS by separating web and native functionality into separate files using [platform-specific extensions](https://docs.expo.dev/workflow/glossary-of-terms/#platform-extensions):

#### analytics.native.js

```js
import analytics from "@react-native-firebase/analytics";

export async function sendAnalyticsEventAsync() {
  await analytics().logEvent("test_analytics_event", {
    additionalParam: "test",
  });
}
```

#### analytics.web.js

```js
import { initializeApp } from "firebase/app";
import { getAnalytics, logEvent } from "firebase/analytics";

// configure and initialize Firebase for web (copy this from the Firebase Console Project Settings for the exact values)
const firebaseConfig = {
  apiKey: "api-key",
  authDomain: "project-id.firebaseapp.com",
  databaseURL: "https://project-id.firebaseio.com",
  projectId: "project-id",
  storageBucket: "project-id.appspot.com",
  messagingSenderId: "sender-id",
  appId: "app-id",
  measurementId: "G-measurement-id",
};

const app = initializeApp(firebaseConfig);
const webAnalytics = getAnalytics(app);

export async function sendAnalyticsEventAsync() {
  await logEvent(webAnalytics, "test_analytics_event", {
    additionaParam: "test",
  });
}
```

### Migrating from expo-firebase-recaptcha

This migration guide demonstrates specifically migrating Firebase Analytics usage from `expo-firebase-analytics` to React Native Firebase. If you are migrating from `expo-firebase-recaptcha`, follow the steps above to add React Native Firebase, create a development build, and then see React Native Firebase's [Phone Authentication](https://rnfirebase.io/auth/phone-auth) documentation for configuring app verification. With the full native capabilities of React Native Firebase now at your disposal, your app can generally use automatic app verification, which uses reCAPTCHA as a fallback mechanism.

### Remove expo-firebase-core

If your project has `expo-firebase-core` explicitly installed (see `"dependencies"` in **package.json** to check), then you'll need to uninstall it. No additional step is required for migration.
