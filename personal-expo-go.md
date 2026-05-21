# Your personal Expo Go on TestFlight

After `eas go` completes, your custom Expo Go build has been submitted to App Store Connect and is on its way to TestFlight.

## What to expect

**App Store processing takes a few minutes.** Once it's done, the build will appear in TestFlight and anyone on your internal test team will be able to install it.

You can check the status at any time on [App Store Connect](https://appstoreconnect.apple.com).

## Installing on a device

1. Open the **TestFlight** app on your iOS device.
2. Find your Expo Go build and tap **Install**.
3. Once installed, open it and scan a QR code or enter a project URL as you normally would.

## Using a specific SDK version

By default, `eas go` uses the latest supported SDK. To pin a version:

```bash
eas go --sdk-version 55.0.0
```

## Sharing with your team

The build is distributed as a TestFlight internal build, so anyone you've added to your App Store Connect internal test group can install it directly from TestFlight — no App Store review required.

## FAQ

**The build doesn't appear in TestFlight yet.**

App Store Connect processing usually takes 5–15 minutes. If it's been longer, check App Store Connect for any compliance or export issues.

**Can I have multiple SDK versions installed at once?**

No — like the public Expo Go, only one version can be installed at a time. Run `eas go --sdk-version <version>` to switch.

**Is this the same app as the public Expo Go?**

It uses the same Expo Go source but is signed with your Apple Developer account and distributed through your own TestFlight, so it's treated as a separate app on the device.
