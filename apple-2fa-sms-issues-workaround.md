# Workaround for Apple 2FA SMS issues

> [!NOTE]
> On 2024-11-15 it was reported that [Apple API was throwing internal server errors while trying to send 2FA SMS codes for American phone numbers, when authenticating through EAS CLI](https://github.com/expo/eas-cli/issues/2698). The Expo team has since updated the EAS CLI to match the new authentication requests. The issue should be fixed in version `14.0.3`.

If you are experiencing persistent issues with Apple SMS 2FA while logging in through EAS CLI, **you should switch to using the `device` 2FA method**. Apple has recently changed their APIs in a way that has made this auth method less reliable for external tools (for example, see [fastlane#28816](https://github.com/fastlane/fastlane/issues/28816)). At Expo, we have adjusted our implementation to fix many cases but we do not have any direct access to the information that would allow us to feel confident that we can fix it in every scenario. For this reason, we strongly recommend moving to device 2FA instead.

We'll continue improving the SMS 2FA as best we can, and EAS CLI currently handles it better than any other tool that we are aware of, but we can't guarantee that it will be reliable. It is possible that Apple may be moving away from the SMS 2FA method, given that it is generally considered to be less secure than alternative approaches.

## How to setup and use `device` 2FA method with EAS CLI

Follow [these Apple docs](https://support.apple.com/en-us/102660) to set a trusted device ([for example your Mac](https://github.com/expo/eas-cli/issues/2698#issuecomment-2525401555)) for your Apple account.
Once the trusted device is set up, you can use the `device` 2FA method when prompted `How do you want to validate your account?` in the EAS CLI.
This method will send a 2FA code to your trusted device, which you can then enter in the CLI to authenticate.
