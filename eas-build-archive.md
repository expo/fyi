# How projects are uploaded to EAS Build

When you run `eas build`, we need to get your source code from your development machine to one of our macOS or Linux build workers. In order to do this, EAS CLI will collect and compress project files into a single archive, and then upload that archive to private cloud storage that is accessible only to the build worker. By default, EAS CLI will produce the archive by copying all files starting from the root of the git repository with the exception of `.git`, `node_modules`, and all files matched by rules from `.gitignore` (or `.easignore` if it exists).

> `.easignore` supports [the same path patterns as `.gitignore` files](http://git-scm.com/docs/gitignore), but it can only be located in the root of your git repository and, if it is present, none of the existing `.gitignore` files will be respected by EAS CLI.

## What files are included in the archive?

You likely do not want to upload your `node_modules` directory, or maybe you have a `.env` file that is ignored by source control. EAS CLI always respects `.gitignore` files, but depending on your configuration there might be certain edge cases where EAS behavior is not 100% compliant with git.

You can run `eas build:inspect --platform [ios|android] --stage archive --output ~/target/output/path --profile production` and inspect the output directory (in this case `~/target/output/path`) to see which files are included.

#### EAS CLI 

By default, or if you set the `EAS_NO_VCS` environment variable, EAS CLI will use its own packaging algorithm that approximates `git clone --depth 1 ...` and allows you to build with a dirty git working tree. The following limitations apply when using this approach: 
  - If you have multiple `.gitignore` files, they are applied in isolation starting from the root, so if you have an ignore rule like `test/example` in the parent directory and `!example/example1` in the `test` directory then the entire `example` directory will still be ignored.
  - The `node_modules` directory is ignored by default.
  - Even if you are using `git-crypt`, all the files are uploaded as they are in your project directory. This means all sensitive files could be uploaded to EAS Build in a non-encrypted state.
  - The `.git` directory is not uploaded to EAS Build. So if you are using any tools that depend on the state of the Git repository, this might result in unexpected behavior (e.g. sentry reads the commit hash when uploading the source maps).
  - The content of the submodules will be included as they are in your working directory.

If you set `{ "cli": { "requireCommit": true } }` at the root level of your `eas.json`, EAS CLI will use the `git clone --depth 1 ...` command to create a shallow clone of your repository. With this approach, the project uploaded to EAS Build will be exactly the same as in Git - including information like the branch, commit hash, and so on.

> Note: `.easignore` is not supported if you set `requireCommit: true` in your `eas.json`

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

The default workflow does not require that you commit your changes, but `git` itself is still used to read some metadata about the repository. You can set the `EAS_NO_VCS=1` environment variable to skip using Git for all EAS CLI commands and optionally `EAS_PROJECT_ROOT` to define the root of your project if it is different than location of your `eas.json` file.

If you want to use `.easignore` instead of `.gitignore` with `EAS_NO_VCS=1`, then you need to place it in the directory pointed to by the `EAS_PROJECT_ROOT` environment variable (if it's set), or in the same directory as your `eas.json` otherwise.
