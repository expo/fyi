# How projects are uploaded to EAS Build

When you run `eas build`, we need to get your source code from your development machine to one of our macOS or Linux build workers. In order to do this, EAS CLI will collect and compress project files into a single archive, and then upload that archive to private cloud storage that is accesible only to the build worker. By default, EAS CLI will produce the archive by performing a shallow `git clone` of your project and then compressing the cloned directory with `tar`.

## What files are included in the archive?

You likely do not want to upload your `node_modules` directory, or maybe you have a `.env` file that is ignored by source control. Because EAS CLI uses does shallow `git clone` of your project before compressing it, your `.gitignore` configuration will be leveraged, and only files that are included in the latest commit will be included in the archive.

You can test this on your development machine against your local project directory by running the following command:

```
# Replace paths below with paths that make sense for your machine / operating system
git clone --local --no-hardlinks --depth 1 file:///path/to/your/git/repo- ~/path/to/clone/to
```

Alternatively, a fresh `git clone` from your remote would also be sufficient.

## How can I upload files to EAS Build if they are gitignored?

Environment variables are easy enough to handle, you can set those values using [Secrets](https://docs.expo.dev/build-reference/variables/); but, in some cases, your build may depend on **files** that you consider sensitive and do not want to commit to source control.

In these cases, you can encode the contents of the file with `base64`, save that string as secrets, and then create the file in an EAS Build hook. See ["How to use Git submodules"](https://docs.expo.dev/build-reference/how-tos/#how-to-use-git-submodules) for an example. Alternatively, you can opt out of using Git and use `.easignore` instead.

## How do I opt out of using Git?

You can set the `EAS_NO_VCS=1` environment variable to skip using Git for all EAS CLI commands. When generating the archive with this variable set, EAS CLI will look for a `.easignore` file, which follows the same format as `.gitignore`. If no `.easignore` file is present in the project root, it will fallback to using the `.gitignore`.