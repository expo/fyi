# Workaround for Apple 2FA SMS issues

> [!NOTE]
> On 2024-11-15 it was reported that [Apple API was throwing internal server errors while trying to send 2FA SMS codes for American phone numbers, when authenticating through EAS CLI](https://github.com/expo/eas-cli/issues/2698). The Expo team has since updated the EAS CLI to match the new authentication requests. The issue should be fixed in version `14.0.3`.

If you are experiencing persistent issues with Apple SMS 2FA while logging in through EAS CLI, **you should switch to using the `device` 2FA method**. Apple has recently changed their APIs in a way that has made this auth method less reliable for external tools (for example, see [fastlane#28816](https://github.com/fastlane/fastlane/issues/28816)). At Expo, we have adjusted our implementation to fix many cases but we do not have any direct access to the information that would allow us to feel confident that we can fix it in every scenario. For this reason, we strongly recommend moving to device 2FA instead.

We'll continue improving the SMS 2FA as best we can, and EAS CLI currently handles it better than any other tool that we are aware of, but we can't guarantee that it will be reliable. It is possible that Apple may be moving away from the SMS 2FA method, given that it is generally considered to be less secure than alternative approaches.

## How to setup and use `device` 2FA method with EAS CLI

Follow [these Apple docs](https://support.apple.com/en-us/102660) to set a trusted device ([for example your Mac](https://github.com/expo/eas-cli/issues/2698#issuecomment-2525401555)) for your Apple account.
Once the trusted device is set up, you can use the `device` 2FA method when prompted `How do you want to validate your account?` in the EAS CLI.
This method will send a 2FA code to your trusted device, which you can then enter in the CLI to authenticate.

## Remove EAS CLI Apple authentication cache (if you are using EAS CLI version >= `14.0.3`)

If you still encounter this issue while using EAS CLI version >= `14.0.3`, you can try to remove old Apple authentication cache.
It seems to fix the issue for some users.

Run the following command to remove the Apple authentication cache used by EAS CLI:
```bash
rm -rf ~/.app-store/
```

After removing the cache, try logging in again with the EAS CLI.

## Bypass Apple authentication for `eas submit` using `ascAppId`

If you're experiencing Apple 2FA issues specifically with `eas submit`, you can bypass the Apple authentication prompt entirely by adding your App Store Connect App ID to your `eas.json` configuration.

### How to find your App Store Connect App ID:

1. Go to https://appstoreconnect.apple.com
2. Sign in and select your app
3. Look at the URL - it will be in this format: `https://appstoreconnect.apple.com/apps/1234567890/...`
4. Copy the numeric ID (e.g., `1234567890`)

### Add to your `eas.json`:
```json
{
  "submit": {
    "production": {
      "ios": {
        "ascAppId": "1234567890",
        "appleId": "your-apple-id@example.com"
      }
    }
  }
}
```

After adding this configuration, `eas submit --platform ios` will skip the interactive Apple login and 2FA steps entirely, using the App Store Connect API directly.

## Bypass Apple authentication for `eas build` using `--non-interactive` flag

If you're experiencing Apple 2FA issues with `eas build`, you can bypass the authentication prompt by using the `--non-interactive` flag. This skips the Apple auth prompt entirely and uses the existing remote iOS credentials stored on the Expo server.
```bash
npx eas-cli build --platform ios --profile production --non-interactive
```

This method works because:
- It bypasses the interactive authentication flow
- Uses cached/remote credentials already configured in your Expo account
- Avoids triggering the problematic Apple 2FA SMS verification

**Note:** This only works if you have previously set up iOS credentials for your project. If this is your first build, you'll need to authenticate at least once interactively or set up credentials through other means.
