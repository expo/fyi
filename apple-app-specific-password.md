# Apple App-Specific Password

The Apple app-specific password is a password for your Apple ID account that lets you sign in to your Apple account securely from a third-party app. It is one of the authentication methods that can be used by the EAS Submit service to submit your build to the Apple App Store.

### Security

> [!WARNING]
> This authentication method is considered less secure than using the App Store Connect API key because of the broad permissions the app-specific password grants to the actor/service who has it. We recommend using the App Store Connect API key for submitting your builds to the Apple App Store (this is default and recommended authentication method). [Learn more](https://docs.expo.dev/app-signing/security/#apple-app-specific-password).

### How do I generate an app-specific password?

1. Sign in to your [Apple ID account](https://appleid.apple.com/account/home).
2. Go to the _Security_ section and click `Generate Password` under _App-Specific Passwords_.
3. Follow the instructions on your screen.

> [!NOTE]
> **Important note**: To generate and use app-specific passwords, your Apple ID must be protected with [two-factor authentication](https://support.apple.com/kb/HT204915) (2FA).

You can learn more about app-specific passwords [here](https://support.apple.com/en-us/HT204397).

## How do I use the app-specific password once I have generated it?

You can use [EAS CLI](https://github.com/expo/eas-cli) to submit your build to the Apple App Store using the app-specific password.
The app-specific password is passed to the EAS CLI as an environment variable called `EXPO_APPLE_APP_SPECIFIC_PASSWORD`.

Use the following command to submit your iOS build using the app-specific password:

```bash
EXPO_APPLE_APP_SPECIFIC_PASSWORD=your_app_specific_password eas submit -p ios
```
