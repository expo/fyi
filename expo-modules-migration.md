# Migrating to Expo modules

Starting from SDK 43, `react-native-unimodules` has been replaced by `expo`. This change represents a number of massive improvements to our module system, such as better autolinking, monorepo support, and modular hooks that allow for a cleaner integration of libraries like [expo-updates][expo-sdk-updates], [expo-constants][expo-sdk-constants], and [expo-splash-screen][expo-sdk-splash-screen].

> 💡 Read more [about our new infrastructure here][expo-blog-modules]

## Installation

Installing this new module system starts by removing `react-native-unimodules` in your `package.json` and upgrading to Expo SDK 43. You can upgrade the Expo SDK by running the upgrade command inside your project.

```bash
expo upgrade 43
```

> 💡 Do you want to integrate Expo modules in a React Native project without Unimodules? Add the `"expo": "~43.0.0"` dependency in `package.json` first.

## Automatic configuration

If you have limited or no changes in your native code, you can automatically set up the new module system with [prebuild][expo-cli-prebuild]. Remove both `/android` and `/ios` directories, run the command below, and re-apply any changes you made manually.

```bash
expo prebuild
```

## Manual configuration

These changes are based on the Expo SDK 42 project files. If you have a React Native project without Expo, you might not have the exact same code to change. Make sure you have all added lines in your code.

### Android

Apply all changes listed below to the files in `/android`.

<details>
<summary><strong>/app/../MainActivity.java</strong></summary>

```diff
package com.helloworld;

-import android.content.res.Configuration;
-import android.content.Intent;
-
import android.os.Bundle;

import com.facebook.react.ReactActivity;
import com.facebook.react.ReactActivityDelegate;
import com.facebook.react.ReactRootView;
import com.swmansion.gesturehandler.react.RNGestureHandlerEnabledRootView;

-import expo.modules.splashscreen.singletons.SplashScreen;
-import expo.modules.splashscreen.SplashScreenImageResizeMode;
+import expo.modules.ReactActivityDelegateWrapper;

public class MainActivity extends ReactActivity {
-  // Added automatically by Expo Config
-  @Override
-  public void onConfigurationChanged(Configuration newConfig) {
-    super.onConfigurationChanged(newConfig);
-    Intent intent = new Intent("onConfigurationChanged");
-    intent.putExtra("newConfig", newConfig);
-    sendBroadcast(intent);
-  }
-
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    // Set the theme to AppTheme BEFORE onCreate to support
    // coloring the background, status bar, and navigation bar.
    // This is required for expo-splash-screen.
    setTheme(R.style.AppTheme);
    super.onCreate(null);
-    // @generated begin expo-splash-screen-mainActivity-onCreate-show-splash - expo prebuild (DO NOT MODIFY) sync-XXXXXXXX
-    // SplashScreen.show(...) has to be called after super.onCreate(...)
-    // Below line is handled by '@expo/configure-splash-screen' command and it's discouraged to modify it manually
-    SplashScreen.show(this, SplashScreenImageResizeMode.CONTAIN, ReactRootView.class, false);
-    // @generated end expo-splash-screen-mainActivity-onCreate-show-splash
  }

  /**
    * Returns the name of the main component registered from JavaScript.
    * This is used to schedule rendering of the component.
    */
  @Override
  protected String getMainComponentName() {
    return "main";
  }

  @Override
  protected ReactActivityDelegate createReactActivityDelegate() {
-    return new ReactActivityDelegate(this, getMainComponentName()) {
-      @Override
-      protected ReactRootView createRootView() {
-        return new RNGestureHandlerEnabledRootView(MainActivity.this);
-      }
-    };
+    return new ReactActivityDelegateWrapper(
+      this,
+      new ReactActivityDelegate(this, getMainComponentName()) {
+        @Override
+        protected ReactRootView createRootView() {
+          return new RNGestureHandlerEnabledRootView(MainActivity.this);
+        }
+      }
+    );
  }
}
```

</details>

<details>
<summary><strong>/app/../MainApplication.java</strong></summary>

```diff
 package com.helloworld;

 import android.app.Application;
 import android.content.Context;
-import android.net.Uri;
+import android.content.res.Configuration;
+import androidx.annotation.NonNull;

 import com.facebook.react.PackageList;
 import com.facebook.react.ReactApplication;
 import com.facebook.react.ReactInstanceManager;
 import com.facebook.react.ReactNativeHost;
 import com.facebook.react.ReactPackage;
 import com.facebook.soloader.SoLoader;
-import com.helloworld.generated.BasePackageList;

-import org.unimodules.adapters.react.ReactAdapterPackage;
-import org.unimodules.adapters.react.ModuleRegistryAdapter;
-import org.unimodules.adapters.react.ReactModuleRegistryProvider;
-import org.unimodules.core.interfaces.Package;
-import org.unimodules.core.interfaces.SingletonModule;
-import expo.modules.updates.UpdatesController;
+import expo.modules.ApplicationLifecycleDispatcher;
+import expo.modules.ReactNativeHostWrapper;

 import com.facebook.react.bridge.JSIModulePackage;
 import com.swmansion.reanimated.ReanimatedJSIModulePackage;

 import java.lang.reflect.InvocationTargetException;
-import java.util.Arrays;
 import java.util.List;
-import javax.annotation.Nullable;

 public class MainApplication extends Application implements ReactApplication {
-  private final ReactModuleRegistryProvider mModuleRegistryProvider = new ReactModuleRegistryProvider(
-    new BasePackageList().getPackageList()
-  );

-  private final ReactNativeHost mReactNativeHost = new ReactNativeHost(this) {
+  private final ReactNativeHost mReactNativeHost = new ReactNativeHostWrapper(
+    this,
+    new ReactNativeHost(this) {
     @Override
     public boolean getUseDeveloperSupport() {
       return BuildConfig.DEBUG;
     }

     @Override
     protected List<ReactPackage> getPackages() {
+      @SuppressWarnings("UnnecessaryLocalVariable")
       List<ReactPackage> packages = new PackageList(this).getPackages();
-      packages.add(new ModuleRegistryAdapter(mModuleRegistryProvider));
+      // Packages that cannot be autolinked yet can be added manually here, for example:
+      // packages.add(new MyReactNativePackage());
       return packages;
     }

     @Override
     protected String getJSMainModuleName() {
       return "index";
     }

     @Override
     protected JSIModulePackage getJSIModulePackage() {
       return new ReanimatedJSIModulePackage();
     }
-
-    @Override
-    protected @Nullable String getJSBundleFile() {
-      if (BuildConfig.DEBUG) {
-        return super.getJSBundleFile();
-      } else {
-        return UpdatesController.getInstance().getLaunchAssetFile();
-      }
-    }
-
-    @Override
-    protected @Nullable String getBundleAssetName() {
-      if (BuildConfig.DEBUG) {
-        return super.getBundleAssetName();
-      } else {
-        return UpdatesController.getInstance().getBundleAssetName();
-      }
-    }
-  };
+  });

   @Override
   public ReactNativeHost getReactNativeHost() {
     return mReactNativeHost;
   }

   @Override
   public void onCreate() {
     super.onCreate();
     SoLoader.init(this, /* native exopackage */ false);

-    if (!BuildConfig.DEBUG) {
-      UpdatesController.initialize(this);
-    }

     initializeFlipper(this, getReactNativeHost().getReactInstanceManager());
+    ApplicationLifecycleDispatcher.onApplicationCreate(this);
   }
+
+  @Override
+  public void onConfigurationChanged(@NonNull Configuration newConfig) {
+    super.onConfigurationChanged(newConfig);
+    ApplicationLifecycleDispatcher.onConfigurationChanged(this, newConfig);
+  }

   /**
    * Loads Flipper in React Native templates. Call this in the onCreate method with something like
    * initializeFlipper(this, getReactNativeHost().getReactInstanceManager());
    *
    * @param context
    * @param reactInstanceManager
    */
   private static void initializeFlipper(
       Context context, ReactInstanceManager reactInstanceManager) {
     if (BuildConfig.DEBUG) {
       try {
         /*
          We use reflection here to pick up the class that initializes Flipper,
         since Flipper library is not available in release mode
         */
         Class<?> aClass = Class.forName("com.awesomeapp.ReactNativeFlipper");
         aClass
             .getMethod("initializeFlipper", Context.class, ReactInstanceManager.class)
             .invoke(null, context, reactInstanceManager);
       } catch (ClassNotFoundException e) {
         e.printStackTrace();
       } catch (NoSuchMethodException e) {
         e.printStackTrace();
       } catch (IllegalAccessException e) {
         e.printStackTrace();
       } catch (InvocationTargetException e) {
         e.printStackTrace();
       }
     }
   }
 }
```

</details>

<details>
<summary><strong>/app/build.gradle</strong></summary>

```diff
 apply plugin: "com.android.application"

 import com.android.build.OutputFile

 ...

 project.ext.react = [
     enableHermes: (findProperty('expo.jsEngine') ?: "jsc") == "hermes",
+    cliPath: new File(["node", "--print", "require.resolve('react-native/package.json')"].execute().text.trim(), "../cli.js"),
 ]

-apply from: '../../node_modules/react-native-unimodules/gradle.groovy'
-apply from: "../../node_modules/react-native/react.gradle"
-apply from: "../../node_modules/expo-constants/scripts/get-app-config-android.gradle"
-apply from: "../../node_modules/expo-updates/scripts/create-manifest-android.gradle"
+apply from: new File(["node", "--print", "require.resolve('react-native/package.json')"].execute().text.trim(), "../react.gradle")

 ...

 dependencies {
     implementation fileTree(dir: "libs", include: ["*.jar"])
     //noinspection GradleDynamicVersion
     implementation "com.facebook.react:react-native:+"  // From node_modules
+
+    def isGifEnabled = (findProperty('expo.gif.enabled') ?: "") == "true";
+    def isWebpEnabled = (findProperty('expo.webp.enabled') ?: "") == "true";
+    def isWebpAnimatedEnabled = (findProperty('expo.webp.animated') ?: "") == "true";
+
+    // If your app supports Android versions before Ice Cream Sandwich (API level 14)
+    // All fresco packages should use the same version
+    if (isGifEnabled || isWebpEnabled) {
+        implementation 'com.facebook.fresco:fresco:2.0.0'
+        implementation 'com.facebook.fresco:imagepipeline-okhttp3:2.0.0'
+    }
+
+    if (isGifEnabled) {
+        // For animated gif support
+        implementation 'com.facebook.fresco:animated-gif:2.0.0'
+    }
+
+    if (isWebpEnabled) {
+        // For webp support
+        implementation 'com.facebook.fresco:webpsupport:2.0.0'
+        if (isWebpAnimatedEnabled) {
+            // Animated webp support
+            implementation 'com.facebook.fresco:animated-webp:2.0.0'
+        }
+    }
+
     implementation "androidx.swiperefreshlayout:swiperefreshlayout:1.0.0"
     debugImplementation("com.facebook.flipper:flipper:${FLIPPER_VERSION}") {
       exclude group:'com.facebook.fbjni'
     }
     debugImplementation("com.facebook.flipper:flipper-network-plugin:${FLIPPER_VERSION}") {
         exclude group:'com.facebook.flipper'
         exclude group:'com.squareup.okhttp3', module:'okhttp'
     }
     debugImplementation("com.facebook.flipper:flipper-fresco-plugin:${FLIPPER_VERSION}") {
         exclude group:'com.facebook.flipper'
     }
-    addUnimodulesDependencies()

     if (enableHermes) {
-        def hermesPath = "../../node_modules/hermes-engine/android/";
-        debugImplementation files(hermesPath + "hermes-debug.aar")
-        releaseImplementation files(hermesPath + "hermes-release.aar")
+        debugImplementation files(new File(["node", "--print", "require.resolve('hermes-engine/package.json')"].execute().text.trim(), "../android/hermes-debug.aar"))
+        releaseImplementation files(new File(["node", "--print", "require.resolve('hermes-engine/package.json')"].execute().text.trim(), "../android/hermes-release.aar"))
     } else {
         implementation jscFlavor
     }
 }

 // Run this once to be able to run the application with BUCK
 // puts all compile dependencies into folder libs for BUCK to use
 task copyDownloadableDepsToLibs(type: Copy) {
     from configurations.compile
     into 'libs'
 }

-apply from: file("../../node_modules/@react-native-community/cli-platform-android/native_modules.gradle"); applyNativeModulesAppBuildGradle(project)
+apply from: new File(["node", "--print", "require.resolve('@react-native-community/cli-platform-android/package.json')"].execute().text.trim(), "../native_modules.gradle");
+applyNativeModulesAppBuildGradle(project)
```

</details>

<details>
<summary><strong>/build.gradle</strong></summary>

```diff
 // Top-level build file where you can add configuration options common to all sub-projects/modules.

 buildscript {
     ext {
         buildToolsVersion = "29.0.3"
         minSdkVersion = 21
         compileSdkVersion = 30
         targetSdkVersion = 30
     }
     repositories {
         google()
+        mavenCentral()
         jcenter()
     }
     dependencies {
         classpath("com.android.tools.build:gradle:4.1.0")

         // NOTE: Do not place your application dependencies here; they belong
         // in the individual module build.gradle files
     }
 }

 allprojects {
     repositories {
         mavenLocal()
         maven {
             // All of React Native (JS, Obj-C sources, Android binaries) is installed from npm
-            url("$rootDir/../node_modules/react-native/android")
+            url(new File(["node", "--print", "require.resolve('react-native/package.json')"].execute().text.trim(), "../android"))
         }
         maven {
             // Android JSC is installed from npm
-            url("$rootDir/../node_modules/jsc-android/dist")
+            url(new File(["node", "--print", "require.resolve('jsc-android/package.json')"].execute().text.trim(), "../dist"))
         }

         google()
+        mavenCentral()
         jcenter()
         maven { url 'https://www.jitpack.io' }
     }
 }
```

</details>

<details>
<summary><strong>/gradle.properties</strong></summary>

```diff
 # Project-wide Gradle settings.

 ...

 # The hosted JavaScript engine
 # Supported values: expo.jsEngine = "hermes" | "jsc"
 expo.jsEngine=jsc

+# Enable GIF support in React Native images (~200 B increase)
+expo.gif.enabled=true
+# Enable webp support in React Native images (~85 KB increase)
+expo.webp.enabled=true
+# Enable animated webp support (~3.4 MB increase)
+# Disabled by default because iOS doesn't support animated webp
+expo.webp.animated=false
```

</details>

<details>
<summary><strong>/settings.gradle</strong></summary>

```diff
 rootProject.name = 'helloworld'

-apply from: '../node_modules/react-native-unimodules/gradle.groovy'
-includeUnimodulesProjects()
+apply from: new File(["node", "--print", "require.resolve('expo/package.json')"].execute().text.trim(), "../scripts/autolinking.gradle");
+useExpoModules()

-apply from: file("../node_modules/@react-native-community/cli-platform-android/native_modules.gradle");
+apply from: new File(["node", "--print", "require.resolve('@react-native-community/cli-platform-android/package.json')"].execute().text.trim(), "../native_modules.gradle");
 applyNativeModulesSettingsGradle(settings)

 include ':app'
```

</details>

Use the run command to test if the applied changes are working.

```bash
expo run:android (--device <name>)
```

### iOS

Apply all changes listed below to the files in `/ios`.

<details>
<summary><strong>/../AppDelegate.h</strong></summary>

```diff
 #import <Foundation/Foundation.h>
-#import <EXUpdates/EXUpdatesAppController.h>
 #import <React/RCTBridgeDelegate.h>
 #import <UIKit/UIKit.h>

-#import <UMCore/UMAppDelegateWrapper.h>
+#import <Expo/Expo.h>

-@interface AppDelegate : UMAppDelegateWrapper <RCTBridgeDelegate, EXUpdatesAppControllerDelegate>
+@interface AppDelegate : EXAppDelegateWrapper <RCTBridgeDelegate>

 @end
```

</details>

<details>
<summary><strong>/../AppDelegate.m</strong></summary>

```diff
 #import "AppDelegate.h"

 #import <React/RCTBridge.h>
 #import <React/RCTBundleURLProvider.h>
 #import <React/RCTRootView.h>
 #import <React/RCTLinkingManager.h>
+#import <React/RCTConvert.h>

-#import <UMCore/UMModuleRegistry.h>
-#import <UMReactNativeAdapter/UMNativeModulesProxy.h>
-#import <UMReactNativeAdapter/UMModuleRegistryAdapter.h>
-#import <EXSplashScreen/EXSplashScreenService.h>
-#import <UMCore/UMModuleRegistryProvider.h>
-
 #if defined(FB_SONARKIT_ENABLED) && __has_include(<FlipperKit/FlipperClient.h>)
 #import <FlipperKit/FlipperClient.h>
 #import <FlipperKitLayoutPlugin/FlipperKitLayoutPlugin.h>
 #import <FlipperKitUserDefaultsPlugin/FKUserDefaultsPlugin.h>
 #import <FlipperKitNetworkPlugin/FlipperKitNetworkPlugin.h>
 #import <SKIOSNetworkPlugin/SKIOSNetworkAdapter.h>
 #import <FlipperKitReactPlugin/FlipperKitReactPlugin.h>

 static void InitializeFlipper(UIApplication *application) {
   FlipperClient *client = [FlipperClient sharedClient];
   SKDescriptorMapper *layoutDescriptorMapper = [[SKDescriptorMapper alloc] initWithDefaults];
   [client addPlugin:[[FlipperKitLayoutPlugin alloc] initWithRootNode:application withDescriptorMapper:layoutDescriptorMapper]];
   [client addPlugin:[[FKUserDefaultsPlugin alloc] initWithSuiteName:nil]];
   [client addPlugin:[FlipperKitReactPlugin new]];
   [client addPlugin:[[FlipperKitNetworkPlugin alloc] initWithNetworkAdapter:[SKIOSNetworkAdapter new]]];
   [client start];
 }
 #endif

-@interface AppDelegate () <RCTBridgeDelegate>
-
-@property (nonatomic, strong) UMModuleRegistryAdapter *moduleRegistryAdapter;
-@property (nonatomic, strong) NSDictionary *launchOptions;
-
-@end
-
 @implementation AppDelegate

 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
 {
 #if defined(FB_SONARKIT_ENABLED) && __has_include(<FlipperKit/FlipperClient.h>)
   InitializeFlipper(application);
 #endif

-  self.moduleRegistryAdapter = [[UMModuleRegistryAdapter alloc] initWithModuleRegistryProvider:[[UMModuleRegistryProvider alloc] init]];
-  self.launchOptions = launchOptions;
-  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
-  #ifdef DEBUG
-    [self initializeReactNativeApp];
-  #else
-    EXUpdatesAppController *controller = [EXUpdatesAppController sharedInstance];
-    controller.delegate = self;
-    [controller startAndShowLaunchScreen:self.window];
-  #endif
+  RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:launchOptions];
+  RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge moduleName:@"main" initialProperties:nil];
+  id rootViewBackgroundColor = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"RCTRootViewBackgroundColor"];
+  if (rootViewBackgroundColor != nil) {
+    rootView.backgroundColor = [RCTConvert UIColor:rootViewBackgroundColor];
+  } else {
+    rootView.backgroundColor = [UIColor whiteColor];
+  }
+
+  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
+  UIViewController *rootViewController = [UIViewController new];
+  rootViewController.view = rootView;
+  self.window.rootViewController = rootViewController;
+  [self.window makeKeyAndVisible];

   [super application:application didFinishLaunchingWithOptions:launchOptions];

   return YES;
 }

-- (RCTBridge *)initializeReactNativeApp
-{
-  RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:self.launchOptions];
-  RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge moduleName:@"main" initialProperties:nil];
-  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
-
-  UIViewController *rootViewController = [UIViewController new];
-  rootViewController.view = rootView;
-  self.window.rootViewController = rootViewController;
-  [self.window makeKeyAndVisible];
-
-  return bridge;
- }
-
 - (NSArray<id<RCTBridgeModule>> *)extraModulesForBridge:(RCTBridge *)bridge
 {
-  NSArray<id<RCTBridgeModule>> *extraModules = [_moduleRegistryAdapter extraModulesForBridge:bridge];
   // If you'd like to export some custom RCTBridgeModules that are not Expo modules, add them here!
-  return extraModules;
+  return @[];
 }

 - (NSURL *)sourceURLForBridge:(RCTBridge *)bridge {
  #ifdef DEBUG
   return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
  #else
-  return [[EXUpdatesAppController sharedInstance] launchAssetUrl];
+  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
  #endif
 }

-- (void)appController:(EXUpdatesAppController *)appController didStartWithSuccess:(BOOL)success {
-  appController.bridge = [self initializeReactNativeApp];
-  EXSplashScreenService *splashScreenService = (EXSplashScreenService *)[UMModuleRegistryProvider getSingletonModuleForClass:[EXSplashScreenService class] ];
-  [splashScreenService showSplashScreenFor:self.window.rootViewController];
-}
-
 // Linking API
 - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
   return [RCTLinkingManager application:application openURL:url options:options];
 }

 // Universal Links
 - (BOOL)application:(UIApplication *)application continueUserActivity:(nonnull NSUserActivity *)userActivity restorationHandler:(nonnull void (^) (NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
   return [RCTLinkingManager application:application
                    continueUserActivity:userActivity
                      restorationHandler:restorationHandler];
 }

 @end
```

</details>

<details>
<summary><strong>/../noop-file.swift</strong></summary>

```diff
+//
+// @generated
+// A blank Swift file must be created for native modules with Swift files to work correctly.
+//
```

</details>

<details>
<summary><strong>/Podfile</strong></summary>

```diff
-require_relative '../node_modules/react-native/scripts/react_native_pods'
-require_relative '../node_modules/react-native-unimodules/cocoapods.rb'
-require_relative '../node_modules/@react-native-community/cli-platform-ios/native_modules'
+require File.join(File.dirname(`node --print "require.resolve('expo/package.json')"`), "scripts/autolinking")
+require File.join(File.dirname(`node --print "require.resolve('react-native/package.json')"`), "scripts/react_native_pods")
+require File.join(File.dirname(`node --print "require.resolve('@react-native-community/cli-platform-ios/package.json')"`), "native_modules")

-platform :ios, '11.0'
+platform :ios, '12.0'

+require 'json'
+podfile_properties = JSON.parse(File.read('./Podfile.properties.json')) rescue {}

 target 'HelloWorld' do
-  use_unimodules!
+  use_expo_modules!
   config = use_native_modules!

-  use_react_native!(:path => config["reactNativePath"])
+  use_react_native!(
+    :path => config["reactNativePath"],
+    :hermes_enabled => podfile_properties['expo.jsEngine'] == 'hermes'
+  )

   # Uncomment to opt-in to using Flipper
   #
   # if !ENV['CI']
   #   use_flipper!('Flipper' => '0.75.1', 'Flipper-Folly' => '2.5.3', 'Flipper-RSocket' => '1.3.1')
   #   post_install do |installer|
   #     flipper_post_install(installer)
   #   end
   # end
+
+  post_install do |installer|
+    react_native_post_install(installer)
+
+    # Workaround `Cycle inside FBReactNativeSpec` error for react-native 0.64
+    # Reference: https://github.com/software-mansion/react-native-screens/issues/842#issuecomment-812543933
+    installer.pods_project.targets.each do |target|
+      if (target.name&.eql?('FBReactNativeSpec'))
+        target.build_phases.each do |build_phase|
+          if (build_phase.respond_to?(:name) && build_phase.name.eql?('[CP-User] Generate Specs'))
+            target.build_phases.move(build_phase, 0)
+          end
+        end
+      end
+    end
+  end
 end
```

</details>

<details>
<summary><strong>/Podfile.properties.json</strong></summary>

```diff
+{
+  "expo.jsEngine": "jsc"
+}
```

</details>

Make sure your project uses `IPHONEOS_DEPLOYMENT_TARGET = 12.0;`, instead of `= 11.0;`, in your `project.pbxproj`. Use the pod-install and run commands to test if the applied changes are working.

```bash
npx pod-install
expo run:ios (--device <uuid>)
```

[expo-blog-modules]: https://blog.expo.dev/whats-new-in-expo-modules-infrastructure-7a7cdda81ebc
[expo-cli-prebuild]: ./prebuilding.md
[expo-sdk-constants]: https://docs.expo.dev/versions/latest/sdk/constants/
[expo-sdk-splash-screen]: https://docs.expo.dev/versions/latest/sdk/splash-screen/
[expo-sdk-updates]: https://docs.expo.dev/versions/latest/sdk/updates/
