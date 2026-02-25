# Deploy Expo Go to your TestFlight internal team

The `eas go` command builds a version of the Expo Go app signed with your Apple Developer account and deploys it to your TestFlight internal team — making it available to install on any device in your team without needing a Mac or Xcode. It currently only supports SDK 55, but in the future this will make it possible for you to choose the SDK version of Expo Go that you install on your device.

## How it works

1. Run `eas go` from your project directory.
2. EAS builds the Expo Go app for your project's SDK version.
3. The build is automatically submitted to App Store Connect.
4. Your TestFlight internal team members receive it as a TestFlight build they can install on their devices.

## Getting started

Make sure you have the latest version of `eas-cli` installed:

```bash
npm install -g eas-cli
```

Then run:

```bash
eas go
```

You will be prompted to sign in with your Apple Developer account if you haven't already. The CLI handles code signing and submission automatically.

## Requirements

- An [Apple Developer account](https://developer.apple.com/) ($99/year).
- A project configured with EAS (`eas.json`). If you don't have one, `eas go` will guide you through setup.

## FAQ

**Do I need a Mac?**

No. The build runs on EAS Build servers in the cloud.

**How is this different from a development build?**

Expo Go is a sandbox that comes pre-loaded with the Expo SDK — you don't need to run prebuild or configure native code. A [development build](https://docs.expo.dev/develop/development-builds/introduction/) is a custom native app that includes your specific native dependencies. If your project uses libraries with custom native code, you should use a development build instead.

**Can I use this on Android?**

`eas go` targets iOS and TestFlight. On Android, you can install any version that you choose by sideloading the APK, either with Expo CLI or https://expo.dev/go.
