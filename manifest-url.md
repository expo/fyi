# Manifest URL

An Expo app manifest is similar to a [web app manifest](https://developer.mozilla.org/en-US/docs/Web/Manifest) -
it provides information that Expo needs to know how to run the app and other relevant data. [Read more in "How Expo Works"](https://docs.expo.io/versions/latest/workflow/how-expo-works/#expo-manifest).

When you publish a project you are given a manifest URL. This is where your app will look for updates in the future.
The URL you are given is not directly accessible in the web browser without adding some additional headers or parameters.

For example, the manifest URL for the app with the slug `native-component-list` published by the user `community` is `https://exp.host/@community/native-component-list`.
If we want to inspect this in our web browser, we can add `/index.exp?sdkVersion=37.0.0` to it. The end result is: [https://exp.host/@community/native-component-list/index.exp?sdkVersion=37.0.0](https://exp.host/@community/native-component-list/index.exp?sdkVersion=37.0.0).
