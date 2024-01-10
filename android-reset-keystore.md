# Resetting your Android Upload key
## Background
[Google Play App Signing](https://support.google.com/googleplay/android-developer/answer/9842756?hl=en) is a security service where Google manages the app signing key on behalf of you as a developer.  All newer apps (and many others) that are live on the Play Store are opted into Play App Signing.

With Play App Signing, Google maintains the signing key used to verify that your app is authentic. Meanwhile, when your app is built, it is signed with a separate "Upload key". Google Play checks your upload key when you are going to publish your app to ensure the app binary is from you. If you lose this key, as long as you still have access to your Play Store account, you can reset it and continue publishing your app.

## Reset your key with EAS-managed credentials
Google provides the most up-to-date information on how to reset your key in their [Play Console Help section on Play App Signing](https://support.google.com/googleplay/android-developer/answer/9842756?visit_id=637973748658459850-3395295471&rd=1#reset), so be sure to consult that if you have any questions. However, the process is generally a little easier if you use EAS to manage your Android app credentials because the EAS CLI can create the new upload keystore for you.

### Generate a new Upload keystore
1. Run `eas credentials`.
2. Choose "Android".
3. Choose the correct build profile, generally your "production" build profile.
4. Choose the "Keystore: Manage everything needed to build your project" option.
5. Delete your old keystore.
6. Choose "Set up a new keystore".
7. Finally, choose "Download existing keystore" to download the latest keystore you have created in the previous step. This will display fingerprint info for your keystore and download a **.jks** file at the root of your project directory.

### Reset your upload key on the Play Store
These directions can change at Google's discretion, so it is always best to check [their latest instructions](https://support.google.com/googleplay/android-developer/answer/9842756?visit_id=637973748658459850-3395295471&rd=1#reset). As of November 2023, you can reset your upload key via an option under your app in the Play Store Console:
[<img src="./assets/android-reset-keystore/playstore-console-reset-key.png" width="800" />](./assets/android-reset-keystore/playstore-console-reset-key.png)
