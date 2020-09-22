# Authorize Android Device

Android devices can only be used for debugging apps if your computer is "authorized" to develop on.

## Devices

> If Expo CLI is running, stop it with <kbd>ctrl+c</kbd> -- this will stop [ADB][adb].

1. Disconnect your Android device from the computer.
2. Revoke USB Debugging on the device:
   - Open the `Settings` app on your device.
   - **Navigate:** `Developer Options` -> select _Revoke USB debugging authorizations_.
3. Reconnect the device:
   - The device will prompt you to agree to connect the computer. You must confirm it.
4. The computer is now authorized for debugging!

## Genymotion

1. Open `Genymotion` -> `Settings` -> `ADB` -> select _Use custom Android SDK tools_
2. Point it to your Android SDK directory.

By default, Android Studio installs the SDK tools in the following folders:

- **Linux**: `/home/your_username/Android/Sdk`
- **macOS**: `/Users/your_username/Library/Android/sdk`
- **Windows**: `%AppData%\Local\Android\Sdk`

> For more help with Genymotion, refer to [their docs][genymotion].

[adb]: https://developer.android.com/studio/command-line/adb
[genymotion]: https://docs.genymotion.com/desktop/3.0/02_Application/021_Configuring_Genymotion.html#adb
