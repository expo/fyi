# Default macOS filesystem is case-insensitive 

The default macOS filesystem is case-insensitive. This means that for any new file or directory (explicitly created or copied/moved), the casing is preserved when listing files but it's ignored when you want to access the file. The situation might be a bit different when you refer to the file in your code, e.g. imports in React Native are case-sensitive. If you create file `Example.tsx` and import it as `'./example'`, it won't work in React Native. However, it would work in node.

### Syncing local filesystem with the git repository state

On macOS, the `core.ignorecase` git config option is enabled by default.

So if you change:
 - filename `Example.tsx` -> `example.tsx`
 - all imports from `'./Example'` -> `'./example'` 

then only the `import` changes will be tracked by git, but the filename change is ignored.

As a result, it will work for you locally but it will fail for anyone that clones that repo (including EAS Build that is using `git` to create a shallow clone of the repo to upload project sources to the remote builders).

To resolve issues caused by the case inconsistencies you need to either disable `core.ignorecase` by running `git config core.ignorecase false` or rename problematic files manually using `git mv`.
