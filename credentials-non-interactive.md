# Setting up credentials in non-interactive mode

In order to set up credentials in non-interactive mode, you must do one of the following:

1. Set up credentials before by running the command in interactive mode. You can do this by running `expo build:[platform]` or `expo credentials:manager -p [platform]`.
2. Provide Apple Credentials to generate missing credentials. Do this by passing in the `--apple-id` and `--team-id` flags in addition to the `EXPO_APPLE_PASSWORD` environment variable.
3. Pass in missing credentials with build flags. For example, to pass in a Distribution Certificate, you need to set the `--dist-p12-path` and `--team-id` flags in addition to the `EXPO_IOS_DIST_P12_PASSWORD` env var. See full documentation [here](https://docs.expo.io/versions/latest/workflow/expo-cli/)
