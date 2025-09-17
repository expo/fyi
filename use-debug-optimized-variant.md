# How to use the `debugOptimized` build variant

In React Native `0.81`, the team introduced a new build variant aimed at improving the developer experience for those developing on low-end devices or emulators. 
This is achieved by running C++ optimization on the debug build while still keeping the debugger enabled. 

Starting from SDK 54, you can use this variant in your project.

## Enabling the `debugOptimized` variant

When building your project locally using `npx expo run:android`, you can pass an additional flag to choose the build variant. 

Run: `npx expo run:android --variant debugOptimized` to build a debug version with optimized C++.

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
