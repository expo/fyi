# `expo upload:android`

In `expo-cli@5`, `expo upload:android` has been moved to [`eas submit`](https://docs.expo.dev/submit/introduction/) in the package `eas-cli`.

## Why it was removed

We added `expo upload:android` as a way to test the "submission service", originally behind the flag `--use-submission-service` which we later made into the default behavior of `expo upload:android`. The submission service was always intended to be `eas submit`, we added it to Expo CLI to make it easier for existing users to try while we refined the iOS version of the submissions service.

Now that EAS Submit is generally available, we've removed the command from Expo CLI to reduce the install size of `expo-cli` and help us move towards our ultimate goal of versioning Expo CLI with the Expo SDK to improve the longevity of Expo projects.

At the time of writing, development on the `expo upload:android` was frozen for about one year while `eas submit` continued to be improved. `expo upload:ios` has already removed in favor of `eas submit`, and this move completes moving submission tools that integrate with EAS services to EAS CLI.

We plan to eventually move all cloud service related functionality out of Expo CLI and into EAS related tooling like EAS CLI, this is akin to modern web development tooling where local dev server tooling is separate from cloud/hosting tooling. This will help us land better features faster for both categories of tooling, and drastically improve install times.

Sorry for any inconveniences this may have caused. You can downgrade your local version of Expo CLI if you're not ready to change your processes yet, but the migration shouldn't take too long.

## Migration

Configuration in `eas submit -p android` is done using a [`eas.json` config](https://docs.expo.dev/submit/eas-json/#android-specific-options) file in addition to CLI arguments.

| `expo upload:android`      | `eas submit` |
| -------------------------- | ------------ |
| `--latest`                 | `--latest`   |
| `--id`                     | `--id`       |
| `--path`                   | `--path`     |
| `--url`                    | `--url`      |
| `--verbose`                | `--verbose`  |
| `--android-package`        | Automatic    |
| `--type`                   | Automatic    |
| `--use-submission-service` | N/A          |
| `--config`                 | N/A          |

**Migrating to `eas.json`**

| `expo upload:android` | `eas.json`                           |
| --------------------- | ------------------------------------ |
| `--key`               | [`serviceAccountKeyPath`][sakp-l]    |
| `--track`             | [`track`][t-l]                       |
| `--release-status`    | [`releaseStatus`][rs-l]              |
| N/A                   | [`changesNotSentForReview`][cnsfr-l] |

[sakp-l]: https://docs.expo.dev/submit/eas-json/#serviceaccountkeypath
[t-l]: https://docs.expo.dev/submit/eas-json/#track
[rs-l]: https://docs.expo.dev/submit/eas-json/#releasestatus
[cnsfr-l]: https://docs.expo.dev/submit/eas-json/#changesnotsentforreview
