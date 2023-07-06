# Gradle 8 Migration for Custom Expo Modules

Starting from Expo SDK 49 (React Native 0.72), the React Native Android project uses Gradle 8 as the default version. If your project includes custom Expo Modules, you might encounter build errors or warnings related to this change. This migration guide provides step-by-step instructions to resolve any issues and ensure Gradle 8 compatibility.

## Error: Unknown property `classifier`

If you encounter an error similar to the following:

```
* What went wrong:
A problem occurred evaluating project ':tester'.
> Could not set unknown property 'classifier' for task ':tester:androidSourcesJar' of type org.gradle.api.tasks.bundling.Jar.
```

You can apply the following patch to your module's **build.gradle** file to resolve the issue:

```diff
--- a/modules/tester/android/build.gradle
+++ b/modules/tester/android/build.gradle
@@ -35,19 +35,11 @@ buildscript {
   }
 }

-// Creating sources with comments
-task androidSourcesJar(type: Jar) {
-  classifier = 'sources'
-  from android.sourceSets.main.java.srcDirs
-}
-
 afterEvaluate {
   publishing {
     publications {
       release(MavenPublication) {
         from components.release
-        // Add additional sourcesJar to artifacts
-        artifact(androidSourcesJar)
       }
     }
   }
 }
 
 android {
   lintOptions {
     abortOnError false
   }
+  publishing {
+    singleVariant("release") {
+      withSourcesJar()
+    }
+  }
 }

 repositories {
```

## Warning: `Setting the namespace via a source AndroidManifest.xml's package attribute is deprecated.`

If you see a warning similar to the following:

```
package="com.tester" found in source AndroidManifest.xml: /path/to/modules/tester/android/src/main/AndroidManifest.xml.
Setting the namespace via a source AndroidManifest.xml's package attribute is deprecated.
Please instead set the namespace (or testNamespace) in the module's build.gradle file, as described here: https://developer.android.com/studio/build/configure-app-module#set-namespace
This migration can be done automatically using the AGP Upgrade Assistant, please refer to https://developer.android.com/studio/build/agp-upgrade-assistant for more information.
```

Please note that [this warning will become an error starting from React Native 0.73](https://github.com/react-native-community/discussions-and-proposals/issues/671). To address the issue in advance, you can follow these steps:

1. Open your module's **build.gradle** file.
2. Locate the `android` block and add the following line:

   ```diff
   --- a/modules/tester/android/build.gradle
   +++ b/modules/tester/android/build.gradle
   @@ -59,6 +51,7 @@ afterEvaluate {
   }

   android {
   +  namespace = "com.tester"
      compileSdkVersion safeExtGet("compileSdkVersion", 33)

      compileOptions {
   ```

3. Open your module's **AndroidManifest.xml** file.
4. Replace the `package` attribute with `namespace`, as shown in the following patch:

   ```diff
   --- a/modules/tester/android/src/main/AndroidManifest.xml
   +++ b/modules/tester/android/src/main/AndroidManifest.xml
   @@ -1,2 +1,2 @@
   -<manifest package="com.tester">
   +<manifest>
    </manifest>
   ```

By following these steps, you will address the deprecation warning and ensure compatibility with Gradle 8.
