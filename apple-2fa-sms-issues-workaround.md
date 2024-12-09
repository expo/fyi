# Workaround for Apple 2FA SMS issues

> [!NOTE]
> On 2024-11-15 it was reported that [Apple API was throwing internal server errors while trying to send 2FA SMS codes for American phone numbers, when authenticating through EAS CLI](https://github.com/expo/eas-cli/issues/2698). The Expo team has since updated the EAS CLI to match the new authentication requests. The issue should be fixed in version `14.0.3`.

If you are experiencing persisting issues with Apple SMS 2FA while logging in through EAS CLI, you try the following workarounds:

## 1. Remove EAS CLI Apple authentication cache (if you are using EAS CLI version >= `14.0.3`)

Run the following command to remove the Apple authentication cache used by EAS CLI:

```bash
rm -rf ~/.app-store/
```

After removing the cache, try logging in again with the EAS CLI.

## 2. Use `device` 2FA method

Follow [these Apple docs](https://support.apple.com/en-us/102660) to set a trusted device ([for example your Mac](https://github.com/expo/eas-cli/issues/2698#issuecomment-2525401555)) for your Apple account.
Once the trusted device is set up, you can use the `device` 2FA method when prompted `How do you want to validate your account?` in the EAS CLI.
This method will send a 2FA code to your trusted device, which you can then enter in the CLI to authenticate.
