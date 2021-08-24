# Setting up ios credentials in non-interactive mode

In order to set up credentials in non-interactive mode, you must do one of the following:

## Run build before in interactive mode

Set up credentials before by running the command in interactive mode. You can do this by running `expo build:ios` or `expo credentials:manager -p ios`.

## Pass credentials in via build flags

Pass in missing credentials with build flags. You can fetch your credentials by running `expo fetch:ios:certs` and then passing them in to the build command.

The following credentials are required:

### Distribution Certificate

You need to set the `--dist-p12-path` and `--team-id` flags in addition to the `EXPO_IOS_DIST_P12_PASSWORD` env var. See full documentation [here](https://docs.expo.dev/versions/latest/workflow/expo-cli/)

### Push Key

You need to set the `--push-id`, `--push-p8-path` and `--team-id` flags. See full documentation [here](https://docs.expo.dev/versions/latest/workflow/expo-cli/)

### Provisioning Profile

You need to set the `--provisioning-profile-path` and `--team-id` flags. See full documentation [here](https://docs.expo.dev/versions/latest/workflow/expo-cli/)
