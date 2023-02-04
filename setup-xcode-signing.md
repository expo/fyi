# Setup Code Signing Certificates in Xcode for Development

In order to build an iOS app with custom entitlements, you'll need to setup _code signing certificates_ which Apple uses to track all of the software installed on iOS devices. This means you'll need to connect your Apple developer account to Xcode, Xcode can use this to automatically create an _iOS Development Certificate_ and _Provisioning Profile_ for your project.

> 💡 Certificates are saved to your local Keychain so you don't need to set them up often.

![code-signing-page](https://user-images.githubusercontent.com/9664363/112059266-db521e00-8b18-11eb-9538-2a31c6bd6e39.png)


1. Open your iOS project in Xcode by running `xed ios` or `open ios/<yourproject>.xcworkspace` in your Terminal. If your Expo project doesn't have an `ios` folder, run `expo prebuild -p ios` to generate one locally.
2. Select the first project in the **navigator** then the target with the matching native in the "project and targets list".
3. Select "Signing & Capabilities", ensure you have "Automatically manage signing" selected.
4. Ensure a "Development Team" is selected, this may require that you sign-in to your Apple Developer account.
   1. Press the "Add Account" button next to the team label. Follow the sign in flow.
5. Select a physical device to build the app onto, Xcode will add this device to your account.
6. Build the app onto your device.
   1. You may need to "trust" the device you just added to the Xcode "Development Certificate", this is done in your iOS device.
   2. Navigate: Settings > General > Device Management > [your new certificate] > Trust.
      Learn more: [Apple docs (MaintainingCertificates)](https://developer.apple.com/library/content/documentation/IDEs/Conceptual/AppDistributionGuide/MaintainingCertificates/MaintainingCertificates.html).

Now you can return to Expo CLI and build your project locally with `expo run:ios`. This process only needs to be done once per computer / account, you don't need to do this for every new native project.
