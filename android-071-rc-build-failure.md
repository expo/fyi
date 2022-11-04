# Android build errors after React Native 0.71-rc release

On November 4, 2022, React Native 0.71-rc was released, which introduced an issue for projects using libraries that depend on `'com.facebook.react:react-native:+'`.

There is no single error message that will surface in every project when this happens. If you are using react-native-reanimated, you may see the following:

```
[stderr] /home/expo/workingdir/build/workspaces/app/node_modules/react-native-reanimated/android/src/main/java/com/swmansion/reanimated/layoutReanimation/ReanimatedUIManager.java:38: error: no suitable constructor found for UIManagerModule(ReactApplicationContext,List<ViewManager>,ReaUiImplementationProvider,int)
[stderr]     super(
[stderr]     ^
[stderr]     constructor UIManagerModule.UIManagerModule(ReactApplicationContext,ViewManagerResolver,int) is not applicable
[stderr]       (actual and formal argument lists differ in length)
[stderr]     constructor UIManagerModule.UIManagerModule(ReactApplicationContext,List<ViewManager>,int) is not applicable
[stderr]       (actual and formal argument lists differ in length)
```

**If you use prebuild on EAS Build** (ie: you don't have commit `ios` and `android` directories to Git) then this regression has already been resolved for you, and no action is required. If you encountered this error when building on November 4th, then run your build again.

**If you have a bare project**, then you can either regenerate your `android` directory with `prebuild` or you can manually apply the following patch to your `android/build.gradle`:

```diff
+def REACT_NATIVE_VERSION = new File(['node', '--print', "JSON.parse(require('fs').readFileSync(require.resolve('react-native/package.json'), 'utf-8')).version"].execute(null, rootDir).text.trim())
+
 allprojects {
+    configurations.all {
+        resolutionStrategy {
+            force "com.facebook.react:react-native:" + REACT_NATIVE_VERSION
+        }
+    }
+
     repositories {
         mavenLocal()
         maven {
```

<hr />

- Curious for more details? See [facebook/react-native/issues/35204](https://github.com/facebook/react-native/issues/35204) for discussion about this issue.
