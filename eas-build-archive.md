# How projects are uploaded to EAS Build

When you run `eas build`, we need to get your source code from your development machine to one of our macOS or Linux build workers. In order to do this, EAS CLI will collect and compress project files into a single archive, and then upload that archive to private cloud storage that is accessible only to the build worker. By default, EAS CLI will produce the archive by copying all files starting from the root of the git repository with the exception of `.git`, `node_modules` and all files matched by rules from `.gitignore` (or `.easignore` if specified).

## What files are included in the archive?

You likely do not want to upload your `node_modules` directory, or maybe you have a `.env` file that is ignored by source control. EAS CLI is always respecting `.gitignore` files, but depending on your configuration there might be certain edge cases where eas behavior is not 100% compliant with git.

#### EAS CLI 

By default or if you set `EAS_NO_VCS` environment variable, EAS CLI will use it's own implementation to package the repository, as a result files uploaded to the worker might be a bit different than what is stored in git:
  - If you have multiple `.gitignore` files, they are applied in isolation starting from the root, so if you have an ignore rule like `test/example` in the parent directory and `!example/example1` in the `test` directory then the entire `example` directory will still be ignored.
  - The `node_modules` directory is ignored by default.
  - Even if you are using `git-crypt`, all the files are uploaded as they are in your project directory. This means all sensitive files could be uploaded to EAS Build in a non-encrypted state.
  - After upload to EAS Build your `.git` directory won't exists, so if you are using any tools that read your vcs information when building that information won't be included (e.g. sentry can read commit hash when uploading sourcemaps).
  - The content of the submodules will be included as they are in your working directory.

If you set `{ "cli": { "requireCommit": true } }` at the root level of your `eas.json`, EAS CLI will use `git clone --depth 1 ...` command to create shallow clone of your repository. With this approach content uploaded to the EAS builder will be exactly the same as in git, including info like branch, commit hash, and so on.

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

Default workflow does not require that you commit your changes, but `git` itself is still used to read some metadata about the repository. You can set the `EAS_NO_VCS=1` environment variable to skip using Git for all EAS CLI commands.
