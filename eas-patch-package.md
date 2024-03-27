# Using `patch-package` on EAS

If you want to make changes to code inside a dependency, [`patch-package`](https://github.com/ds300/patch-package) provides a convenient solution to do that. It allows you to make changes directly to your **node_modules** directory, then generate a patch file that you can commit to source control and will be automatically re-applied to the package in **node_modules** when you run `npm install` (or `yarn`, etc.).

Out of the box, `patch-package` is fully compatible with EAS. If you follow the [installation instructions](https://github.com/ds300/patch-package?tab=readme-ov-file#set-up) for `patch-package`, including adding the `postinstall` script to your **package.json**, then any patches you have created in your project using `patch-package` will automatically be applied on EAS as part of the 'Install dependencies' step, just like on your local machine.

> **Note**: make sure that the **patches** folder that is created by `patch-package` is added to source control, so it will be included when your source code is uploaded to EAS.

The output from `patch-package` is available in the logs for the 'Install dependencies' step on your build details page.