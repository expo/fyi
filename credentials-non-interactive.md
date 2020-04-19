# Setting up credentials in non-interactive mode

In order to set up credentials in non-interactive mode, you must do one of the following:

1. Set up credentials before by running the command in interactive mode. You can do this by running `expo build:[platform]` or `expo credentials:manager -p [platform]`.
2. Pass in missing credentials with build flags. You can fetch your credentials by running `expo fetch:ios:certs` and then passing them in to the build command.

The following credentials are required:

## Distribution Certificate

You need to set the `--dist-p12-path` and `--team-id` flags in addition to the `EXPO_IOS_DIST_P12_PASSWORD` env var. See full documentation [here](https://docs.expo.io/versions/latest/workflow/expo-cli/)

## Push Key

You need to set the `--push-id`, `--push-p8-path` and `--team-id` flags. See full documentation [here](https://docs.expo.io/versions/latest/workflow/expo-cli/)

## Provisioning Profile

You need to set the `--provisioning-profile-path` and `--team-id` flags. See full documentation [here](https://docs.expo.io/versions/latest/workflow/expo-cli/)
