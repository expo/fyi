# Deploy Expo Go to your TestFlight internal team

Currently, SDK 55 and higher are not available on the Apple App Store ([learn more](https://expo.dev/changelog/expo-go-and-app-store-may-2026)). The `eas go` command builds a version of the Expo Go app on EAS and deploys it to your TestFlight internal team — making it available to install on any device in your team. This command does not count against the build usage for your account, it counts as workflow minutes. You can choose the SDK version with `--sdk-version`, so if you're in the middle of exploring an idea or learning something with Expo Go, you can stay on the SDK you need regardless of releases.

That said, you may alternatively want to consider migrating your project to using a [development build](https://docs.expo.dev/develop/development-builds/expo-go-to-dev-build/), which provides you with everything that you need to build an app that you ship to stores.

## How it works

1. Run `eas go` from anywhere — no local project setup needed.
2. EAS builds the Expo Go app for the SDK version you choose (defaults to the latest supported).
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

## FAQ

**Do I need a Mac?**

No. The build runs on EAS Build servers in the cloud.

**How is this different from a development build?**

`eas go` is just another way of distributing Expo Go, and so everything from [this blog post](https://expo.dev/blog/expo-go-vs-development-builds) applies equally.

**Can I use this on Android?**

`eas go` targets iOS and TestFlight. On Android, you can install any version that you choose by sideloading the APK, either with Expo CLI or https://expo.dev/go.
