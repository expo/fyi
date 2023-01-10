# EAS Build: migrating from Intel workers to M1

## 1. Install the latest EAS CLI

It's recommended to always use the latest version of EAS CLI, and in this case it's required to use at least eas-cli@3.3.0 to use M1 workers as described in this doc.

## 2. Configure **eas.json**

### 2.1. Add the `resourceClass` field to your build profile

For example:

```json
{
 "build": {
    "fast": {
      "ios": {
        "resourceClass": "m1-medium"
      }
    },
    "development": {
      "extends": "fast",
      "developmentClient": true,
      "distribution": "internal"
    },
    "production": {
      "extends": "fast"
		}
  }
}
```

### 2.2. Update the `image` field if needed

macOS images for Monterey (12.x) and newer are available on M1 workers. You can find more information about available build images here: https://docs.expo.dev/build-reference/infrastructure/

## 3. Run your first M1 build

For most projects on SDK 47 and greater, a build that succeeds on Intel workers will also succeed on M1 workers.

The most common type of error that developers encounter is compatibility with native extensions or custom tools that don't support Apple silicon yet. For the best results, we recommend updating those dependencies to more recent versions if they cause build failures. For example, if your project depends on `sharp` you may need to update it to a more recent version.

If your build fails, you should apply your preferred software troubleshooting process. If you're unable to resolve the issue, refer to the [Troubleshooting build errors and crashes](https://docs.expo.dev/build-reference/troubleshooting/) guide, and finally the [How to ask a good question](https://docs.expo.dev/build-reference/troubleshooting/#how-to-ask-a-good-question) section at the bottom of the page if you're still stuck. We will also update this guide to provide guidance for common issues as more developers begin using M1 workers on EAS Build.