# Using Prebuild without NPM access
Within some corporate networks, direct access to NPM may be disabled, with all package installs going through a private repository like AWS CodeArtifact. Most Expo CLI commands that interact with package managers (such as `npx expo install`) utilize **.npmrc** and any embedded auth tokens. However, `npx expo prebuild` is not currently able to pass these auth tokens while downloading the native project template that's that Prebuild uses when generating your native code. You can work around this by specifying a template (either from Github of a local file) and passing it as a parameter to the Prebuild command.

## Using a template from Github

> The method generates valid projects, but some of the files and folder names may contain hashes instead of friendly names. If you will be doing a lot of introspection of the files generated during Prebuild, you may prefer the local file method below.

If Github can be accessed over the network, you can specify a Github link. The default template is located in the **templates/expo-template-bare-minimum** folder inside the [Expo repository](https://github.com/expo/expo).

1. Find the correct template for your SDK version. For example, the SDK 50 version is available at https://github.com/expo/expo/tree/sdk-50/templates/expo-template-bare-minimum. Substitute "sdk-50" for your required SDK.
2. Pass this URL to Prebuild, e.g., `npx expo prebuild --template https://github.com/expo/expo/tree/sdk-50/templates/expo-template-bare-minimum`

## Using a template from a local file
If you cannot access NPM or Github from your CLI, you can use a local template from the [Expo repository](https://github.com/expo/expo) or elsewhere. The default template used by Prebuild is located in the **templates/expo-template-bare-minimum** folder.

1. Find the correct template for your SDK version. For example, the SDK 50 version is available at https://github.com/expo/expo/tree/sdk-50/templates/expo-template-bare-minimum. Substitute "sdk-50" for your required SDK.
2. Download this folder. You can download the **expo-template-bare-minimum** folder by cloning the entire repository, or via a tool like [Download Github Directory](https://download-directory.github.io/). The latter will put the files in a **.zip**, so you will need to unzip those prior to the next step.
3. Put the folder in a tarball using `npm pack`. You can do this from the macOS terminal via `npm pack expo-template-bare-minimum`. This will create a **expo-template-bare-minimum.tgz** file. NOTE: there may differences in tarballs created with other tools that may cause issues, so be sure to use `npm pack`.
4. Pass this file to Prebuild, e.g., `npx expo prebuild --template expo-template-bare-minimum.tar.gz`.

# Using a template with `create-expo-module`
`npx create-expo-module` downloads a template in a similar way and thus may not work without direct NPM access. You can specify a template as a folder path to avoid needing to download it.

1. Download the folder contents of expo-modules-template (e.g., https://github.com/expo/expo/tree/sdk-50/packages/expo-module-template, except replace "sdk-50" with your desired SDK version).
2. Pass the path to the command, e.g., `npx create-expo-app --source ./expo/packages/expo-module-template`.