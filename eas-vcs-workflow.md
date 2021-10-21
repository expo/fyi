## Workflows

`eas-cli` integrates with version control systems (vcs) to access information about the project and to package it when uploading to the builder. Currently we are supporting 3 modes and you can select which fits best in your workflow.

### No-Commit git workflow (default) 

- Is using git to find the root of the project and other useful metadata (branch, commit hash, ...).
- Does not require commits before a build.
- Uploads copy of you working directory to the builder.
- Respects `.gitignore` files (with some exceptions, see migration notes bellow).

### Full git workflow

- Can be enabled by adding `{ cli: { requireCommit: true } }` in root of your `eas.json`.
- Is using git to find the root of the project and other useful metadata (branch, commit hash ...).
- Requires clean working git tree to build.
- Respects `.gitignore` files.
- Uploads a shallow clone of your repository to the builder(preserves info about last commit like author, message, hash ...).

### No-Vcs workflow

- Can be enabled by setting env `EAS_NO_VCS=1`.
- Does not use any git (or any other vcs) tooling.
- Respects `.gitignore` files (the same as no-commit workflow).
- Uploads a copy of your working directory to the builder.

## Migration to no-commit workflow

We are switching the default behavior to `no-commit` workflow, but full git workflow is still a recommended way of using eas build. Main motivation behind that change is to simplify onboarding for the new users by removing requirement to commit every time they make a build.

If you are switching from full git workflow to `no-commit` you need to keep in mind a few limitations:
- If `eas-cli` is making any changes to the project, we can't show you diffs of those changes (you will still be prompted before we make them).
- `No-Commit` workflow does not use git for packaging, so there are some inconsistencies when creating a copy of you repository to upload it to the builder.
  - If you have multiple gitignore files, then they are applied in isolation starting from the root, so if you have ignore rule e.g. `test/example` in parent directory and `!example/example1` in `test` directory then entire example directory will still be ignored
  - The `node_modules` directory is ignored by default.
  - If you are using git-crypt, then all the files will be uploaded as they are in your working directory, so potentially they won't be encrypted.
- When we run build on the remote repository, `.git` directory won't be present there, which might affect some of the tools that are relying on git to read certain values e.g. sentry includes commit hash when uploading sourcemaps.
- [MacOS case-sensitivity issues](https://github.com/expo/fyi/blob/master/macos-ignorecase.md) won't affect you when you use this workflow, but it will still affect anyone that clones that repository.
