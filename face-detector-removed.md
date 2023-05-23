# Expo Face Detector has been removed from Expo Go

# Why

It used dependencies that were not migrated to ARM64 architecture and were a blocker on migrating Expo Go to ARM iOS simulators.

Related issue: https://issuetracker.google.com/issues/178965151

# How to use it

To use this functionality, you'll have to create a development build or prebuild using `npx expo run:android|ios` commands.

## Prebuilding

Before a native app can be compiled, the native source code must be generated. Expo CLI provides a unique and powerful system called prebuild, which generates the native code for your project including installed native dependencies like expo-face-detector.
[Learn more about prebuilding](https://docs.expo.dev/workflow/prebuild/)

To run the application on Android:
```
npx expo install expo-face-detector
npx expo run:android 
```

```
npx expo install expo-face-detector
npx expo run:ios 
```
## Development builds and EAS Build

If you can't run iOS applications locally, you can still use EAS build and development builds.

https://docs.expo.dev/build/introduction/

https://docs.expo.dev/develop/development-builds/create-a-build/

