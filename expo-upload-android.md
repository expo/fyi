# `expo upload:android`

In `expo-cli@5`, `expo upload:android` has been moved to [`eas submit`](https://docs.expo.dev/submit/introduction/) in the package `eas-cli`.

## Why it was removed

We added `expo upload:android` as a way to test the "submission service", originally behind the flag `--use-submission-service` which we later made into the default behavior of `expo upload:android`. The submission service was always intended to be `eas submit`, we added it to Expo CLI to make it easier for existing users to try while we refined the iOS version of the submissions service.

Now that EAS Submit is fully stable and ready for public use, we've removed the Expo CLI copy to reduce the install size of `expo-cli` and help us move towards our ultimate goal of versioning Expo CLI with the Expo SDK to improve the longevity of Expo projects.

We haven't improved or upgraded `expo upload:android` in over a year whereas `eas submit` continues to be improved with bug fixes and support. `expo upload:ios` was already removed in favor of `eas submit` 4 months prior to the android deprecation.

We plan to eventually move all cloud service related functionality out of Expo CLI and into EAS related tooling like EAS CLI, this is akin to modern web development tooling where local dev server tooling is separate from cloud/hosting tooling. This will help us land better features faster for both categories of tooling, and drastically improve install times.

Sorry for any inconveniences this may have caused. You can always downgrade your local version of Expo CLI but this isn't recommended as EAS Submit should act as a 100% drop-in replacement.
