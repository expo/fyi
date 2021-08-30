# case-insensitive filesystem on macOS

By default filesystem on macOS is not case sensitive, for new (exlicitly created or copied/moved) files or directories the case of the filename is preserved when listing files, but it's ignored when you want to access specific file e.g. opening/deleting/moving. The situation might be a bit different when you refer to the file in code e.g. javascript import in react-native is case sensitive, because bundler reads exisiting files with correct case and all other operation happens inside the bundler in case sensitive way without filesystem interactions. If you create file `Example.tsx` importing it as `'./example'` won't work in react-native, but it would work in `node` becuse there is no bundler there and all imports use filesystem directly.

### Syncing local case changes with state of the git repository 

On macOS git option `core.ignorecase` is enabled by default, so e.g. 

If you change 
 - filename `Example.tsx` -> `example.tsx`
 - all imports from `'./Example'` -> `'./example'` 

then only import changes will be tracked by git, but file will still be called `Example.tsx`.

As a result it will work for you locally, but it will fail for anyone that clones that repo including EAS Build that is using `git` to create shallow clone of the repo to upload project sources to the remote builders.

To resolve issues caused by case inconsistency you need to either disable `core.ignorecase` by running `git config core.ignorecase false` or rename conflicitng files manually using `git mv`
