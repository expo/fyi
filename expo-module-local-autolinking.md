# Expo Modules autolinking when using the --local flag

If using `npx create-expo-module --local` you will get the following message:

```
The local module will be created in the modules directory in the root of your project.
```

---

Expo autolinking mechanism by default searches two directories in the project root for linkable modules:
- node_modules
- modules

The second directory is configurable by setting `nativeModulesDir` in the following manner in `package.json`:

```json package.json
"expo": {
  "autolinking": {
    "nativeModulesDir": "differentDirectory"
  }
}
```

If you override this property make sure to move your native modules to the new directory.
