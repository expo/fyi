# Using absolute import paths with local Expo Modules

**When importing an Expo module created using `npx create-expo-module --local`**:

You can use an absolute import path in place of a regular relative import:

`import module from "my-module";`,


To do this you need to include the `paths.*` wildcard in [your tsconfig file](https://www.typescriptlang.org/tsconfig#paths).
>
```tsconfig.json
{
  "compilerOptions": {
    "paths": {
      "*": ["./modules/*"]
    }
  },
  "extends": "expo/tsconfig.base"
}
```
>
And change the `metro.config.js` file to the following:
>
```metro.config.js
// Learn more https://docs.expo.io/guides/customizing-metro
const { getDefaultConfig } = require('expo/metro-config');
const path = require('path');

const defaultConfig = getDefaultConfig(__dirname);

defaultConfig.extraNodeModules = {
  modules: path.resolve(__dirname, 'modules'),
};

module.exports = defaultConfig;
```
