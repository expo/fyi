# Bumping Android Version Code

## 🤔 What Happened

If you're submitting your Android app to Google Play Store using the `eas submit` command, you may encounter the error saying you've already submitted a particular version of the app.

## 💡 Solution

### Configure automatic version management

EAS Build can manage your version code for you and increment on every build, so you never have to think about it again. Learn more in the ["App version management" guide](https://docs.expo.dev/build-reference/app-versions/).

### Manually increment version code

Increment the value for the `android.versionCode` key in `app.json`. Optionally, commit this change. Then, build a new app archive with `eas build`. Wait for the build to finish and run `eas submit`, or use `eas build --auto-submit`.

[<img src="./assets/bumping-android-version-code/01-bumping-android-version-code.png" width="800" />](./assets/bumping-android-version-code/01-bumping-android-version-code.png)