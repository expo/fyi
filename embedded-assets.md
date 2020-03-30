# Embedded Assets

In addition to loading updates from remote servers, apps with `expo-updates` installed also include the necessary capability to load updates embedded in the app binar at build-time. This is critical to ensure that your app can load for all users immediately upon installation, without needing to talk to a server first.

When you run `expo export` or `expo publish` with `expo-updates` installed, Expo CLI will make local copies of the update's manifest (`shell-app-manifest.json`) and JavaScript bundle (`shell-app.bundle`) so they can be included in the Xcode and Android Studio projects and embedded in release-mode application binaries.

For iOS, these files are created by default in the `ios/<your-project-name>/Supporting` directory. **You must add these files to your Xcode project if they are not already added.**

For Android, these files are created by default in the `android/app/src/main/assets` directory. Simply putting them in this directory is sufficient for Gradle to include them in the APK; no further action is needed on your part.
