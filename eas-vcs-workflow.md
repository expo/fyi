## VCS Workflows

EAS CLI integrates with version control systems (VCS) to access information about the project and to package it when uploading to EAS Build. Currently, EAS CLI supports 3 integration modes. You can select which fits best in your workflow.

### No-Commit Git Workflow (Default) 

- It uses `git` to find the root of the project and other useful metadata (branch, commit hash, and so on).
- It does not require commits before a build.
- It uploads a copy of your working directory to EAS Build.
- It respects `.gitignore` files (with some exceptions, see the migration notes below).

### Full Git Workflow

- It can be enabled by adding `{ "cli": { "requireCommit": true } }` at the root level of your `eas.json`.
- It uses `git` to find the root of the project and other useful metadata (branch, commit hash, and so on).
- It requires a clean working git tree to build.
- It respects `.gitignore` files.
- It uploads a shallow clone of your repository to EAS Build. This preserves your last commit's metadata like author, message, commit hash, and so on.

### No-VCS Workflow

- It can be enabled by setting the environment variable `EAS_NO_VCS=1`.
- It does not use any VCS tooling (like the `git` command).
- It respects `.gitignore` files (the same as in the no-commit workflow).
- It uploads a copy of your working directory to EAS Build.

## Migration to No-Commit Workflow

We have recently switched the default VCS workflow to the no-commit workflow. However, the full git workflow is still recommended way of using EAS Build. The main motivation behind that change is to simplify onboarding for new users by removing the requirement to commit every time they start a build.

If you are switching from the full git workflow to no-commit, you need to keep in mind a few limitations:
- If EAS CLI happens to make any changes to the project, we can't show you the git diff. You will still be prompted before we make them.
- The no-commit workflow does not use git for packaging, so there could be some inconsistencies when creating a copy of your repository to upload it to EAS Build.
  - If you have multiple `.gitignore` files, they are applied in isolation starting from the root, so if you have an ignore rule like `test/example` in the parent directory and `!example/example1` in the `test` directory then the entire `example` directory will still be ignored.
  - The `node_modules` directory is ignored by default.
  - Even if you are using git-crypt, all the files are uploaded as they are in your project directory. This means all sensitive files could be uploaded to EAS Build in a non-encrypted state.
- When EAS Build processes your build in the cloud, the `.git` directory is not present there. This might affect some of the tools that rely on git to read certain values, e.g. sentry includes the commit hash when uploading source maps.
- [macOS case-sensitivity issues](https://github.com/expo/fyi/blob/master/macos-ignorecase.md) won't affect you when you use this workflow, but it will still affect anyone that clones that repository.
