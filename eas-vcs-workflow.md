# EAS CLI and Version Control Systems (VCS)

EAS CLI provides out of the box integration with [Git](https://git-scm.com/) to access information about your project and to package it when uploading to EAS Build. By default, EAS CLI uses Git as follows:

- It uses `git` to find the root of the project and other useful metadata (branch, commit hash, and so on).
- It does not require commits before a build.
- It uploads a copy of your working directory to EAS Build.
- It respects `.gitignore` files (with some exceptions, see the [migration notes](#migration-notes)) or `.easignore` files.

## Alternative workflows for working with VCS

There are two alternative ways to integrate with version control systems built-in to EAS CLI: you can either integrate more deeply with Git, or not integrate with Git at all.

### Full Git Workflow

This workflow is recommended for most projects because it ensures that each of your builds is associated with a Git commit, and therefore is reproducible. It also works better with third-party tools that hook into Git in your project to extract metadata for their own purposes, for example, error reporting services.

- It can be enabled by adding `{ "cli": { "requireCommit": true } }` at the root level of your `eas.json`.
- It uses `git` to find the root of the project and other useful metadata (branch, commit hash, and so on).
- It requires a clean working git tree to build.
- It respects `.gitignore` files.
- It uploads a shallow clone of your repository to EAS Build. This preserves your last commit's metadata like author, message, commit hash, and so on.

### No VCS Workflow

If you are using a different version control system, or if you are not using any, then you can use this workflow to build your project without any Git integration.

- It can be enabled by setting the environment variable `EAS_NO_VCS=1`.
- It does not use any VCS tooling (like the `git` command).
- It respects `.gitignore` files (the same as in the default workflow) or `.easignore` files.
- It uploads a copy of your working directory to EAS Build.
- By default the project root is the current folder, this can be overriden by setting the environment variable `EAS_PROJECT_ROOT=<monorepo_root>`.

## Migration notes

In `eas-cli@>=0.34.0` the default behavior in EAS CLI is no longer the "Full Git Workflow"; committing your changes will not be required to run a build. You will be prompted to select whether you would like to migrate to the new default the first time you run a build with a new EAS CLI version.

That said, there are good reasons to use that workflow; please refer to the [Full Git Workflow](#full-git-workflow) section above for more information. The main motivation behind changing the default is to simplify onboarding for new users by removing the requirement to commit every time they start a build.

If you are switching to the new default, you should consider the following limitations:

- If EAS CLI happens to make any changes to the project, we can't show you the Git diff. You will still be prompted before we make the changes.
- Only the Full Git Workflow uses Git for packaging (it does a shallow clone); in other cases, EAS CLI attempts to mimic this behavior, but there could be some inconsistencies between `git clone` and our algorithm.
  - If you have multiple `.gitignore` files, they are applied in isolation starting from the root, so if you have an ignore rule like `test/example` in the parent directory and `!example/example1` in the `test` directory then the entire `example` directory will still be ignored.
  - The `node_modules` directory is ignored by default.
  - Even if you are using `git-crypt`, all the files are uploaded as they are in your project directory. This means all sensitive files could be uploaded to EAS Build in a non-encrypted state.
  - The content of submodules will be included as they are in your working directory.
- The `.git` directory is not uploaded to EAS Build. So if you are using any tools that depend on the state of the Git repository, this might result in unexpected behavior (e.g. Sentry reads the commit hash when uploading the source maps).
- [macOS case-sensitivity issues](https://github.com/expo/fyi/blob/master/macos-ignorecase.md) won't affect you when you use this workflow, but it will still affect anyone that clones that repository.
