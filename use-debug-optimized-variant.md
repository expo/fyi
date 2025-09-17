# How to use the `debugOptimized` build variant

In React Native `0.81`, the team introduced a new build variant known as `debugOptimized`. It is aimed at improving the developer experience for those developing on low-end Android devices or emulators. 
This is achieved by running C++ optimization on the debug build while still keeping the debugger enabled. 

Starting from SDK 54, you can use this variant in your project.

## Enabling the `debugOptimized` variant

When building your project locally using `npx expo run:android`, you can pass an additional flag to choose the build variant. 

Run the following command to build a debug version with optimized C++:

```
npx expo run:android --variant debugOptimized
```

When building your app using EAS Build, you need to change the Gradle command in your `eas.json` as follows:
```json
{
  "build": {
    "development": {
      "android": {
        "gradleCommand": ":app:assembleDebugOptimized"
      }
    }
  }
}
```
